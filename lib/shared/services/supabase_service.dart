import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final client = Supabase.instance.client;

  // ── AUTH ──────────────────────────────────────────────────────────────────

  // Inscription
  static Future<AuthResponse> inscription({
    required String email,
    required String password,
    required String nom,
    required String telephone,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'nom': nom, 'telephone': telephone},
    );

    if (response.user != null) {
      await client.from('users').insert({
        'id': response.user!.id,
        'nom': nom,
        'telephone': telephone,
        'email': email,
      });
    }

    return response;
  }

  // Connexion
  static Future<AuthResponse> connexion({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Déconnexion
  static Future<void> deconnexion() async {
    await client.auth.signOut();
  }

  // Utilisateur connecté
  static User? get currentUser => client.auth.currentUser;

  // ── TONTINES ──────────────────────────────────────────────────────────────

  // Créer une tontine
  static Future<Map<String, dynamic>> creerTontine({
    required String nom,
    required int montant,
    required String frequence,
    required String dateDebut,
    required int nbMembres,
  }) async {
    final response = await client
        .from('tontines')
        .insert({
          'nom': nom,
          'montant': montant,
          'frequence': frequence,
          'date_debut': dateDebut,
          'nb_membres': nbMembres,
          'admin_id': currentUser!.id,
        })
        .select()
        .single();

    // Générer automatiquement les tours
    await client.rpc('generer_turns', params: {'p_tontine_id': response['id']});

    return response;
  }

  static Future<String> getProchainBeneficiaire(String tontineId) async {
    final response = await client
        .from('turns')
        .select('*, members(*, users(*))')
        .eq('tontine_id', tontineId)
        .eq('statut', 'encours')
        .limit(1);

    if (response.isEmpty) {
      // Chercher le premier tour à venir
      final avenir = await client
          .from('turns')
          .select('*, members(*, users(*))')
          .eq('tontine_id', tontineId)
          .eq('statut', 'avenir')
          .order('date_versement', ascending: true)
          .limit(1);

      if (avenir.isEmpty) return 'À définir';

      final user = avenir[0]['members']['users'];
      return user['nom'] ?? 'À définir';
    }

    final user = response[0]['members']['users'];
    return user['nom'] ?? 'À définir';
  }

  // Récupérer les tontines de l'utilisateur
  static Future<List<Map<String, dynamic>>> getTontines() async {
    final response = await client
        .from('tontines')
        .select()
        .eq('admin_id', currentUser!.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // ── MEMBRES ───────────────────────────────────────────────────────────────

  // Ajouter un membre
  static Future<void> ajouterMembre({
    required String tontineId,
    required String userId,
    required int rang,
  }) async {
    await client.from('members').insert({
      'tontine_id': tontineId,
      'user_id': userId,
      'rang': rang,
    });
  }

  // Récupérer les membres d'une tontine
  static Future<List<Map<String, dynamic>>> getMembres(String tontineId) async {
    final response = await client
        .from('members')
        .select('*, users(*)')
        .eq('tontine_id', tontineId);

    return List<Map<String, dynamic>>.from(response);
  }

  // ── COTISATIONS ───────────────────────────────────────────────────────────

  // Enregistrer un paiement
  static Future<void> enregistrerPaiement({
    required String memberId,
    required String tontineId,
    required int montant,
    required String moyenPaiement,
  }) async {
    await client.from('payments').insert({
      'member_id': memberId,
      'tontine_id': tontineId,
      'montant': montant,
      'moyen_paiement': moyenPaiement,
      'valide_par': currentUser!.id,
    });

    // Audit log
    await client.from('audit_log').insert({
      'user_id': currentUser!.id,
      'action': 'PAIEMENT',
      'details': 'Paiement de $montant FCFA enregistré',
    });
  }

  // Récupérer les paiements d'une tontine
  static Future<List<Map<String, dynamic>>> getPaiements(
      String tontineId) async {
    final response = await client
        .from('payments')
        .select('*, members(*, users(*))')
        .eq('tontine_id', tontineId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // ── NOTIFICATIONS ─────────────────────────────────────────────────────────

  // Récupérer les notifications
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final response = await client
        .from('notifications')
        .select()
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // Marquer comme lu
  static Future<void> marquerLu(String notificationId) async {
    await client
        .from('notifications')
        .update({'lu': true}).eq('id', notificationId);
  }

  static Future<Map<String, dynamic>> getStats() async {
    // Nombre de groupes actifs
    final tontines =
        await client.from('tontines').select().eq('admin_id', currentUser!.id);

    // Nombre de membres totaux
    int totalMembres = 0;
    for (final t in tontines) {
      final membres =
          await client.from('members').select().eq('tontine_id', t['id']);
      totalMembres += (membres as List).length;
    }

    // Total épargnes (somme des paiements validés)
    final payments =
        await client.from('payments').select().eq('statut', 'paye');

    int totalEpargnes = 0;
    for (final p in payments) {
      totalEpargnes += (p['montant'] as int);
    }

    return {
      'groupes_actifs': tontines.length,
      'membres_totaux': totalMembres,
      'epargnes_totales': totalEpargnes,
    };
  }

  // ── SCORE CONFIANCE IA ────────────────────────────────────────────────────

  static Future<int> calculerScoreConfiance(String userId) async {
    // Récupérer tous les paiements de l'utilisateur
    final payments =
        await client.from('payments').select().eq('member_id', userId);

    if (payments.isEmpty) return 100;

    final total = payments.length;
    final enRetard = payments.where((p) => p['statut'] == 'retard').length;

    // Score = (paiements à temps / total) * 100
    final score = ((total - enRetard) / total * 100).round();

    // Mettre à jour le score dans la BDD
    await client
        .from('users')
        .update({'score_confiance': score}).eq('id', userId);

    return score;
  }
}
