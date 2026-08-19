import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';
import '../../shared/services/supabase_service.dart';

class CotisationScreen extends StatefulWidget {
  const CotisationScreen({super.key});

  @override
  State<CotisationScreen> createState() => _CotisationScreenState();
}

class _CotisationScreenState extends State<CotisationScreen> {
  int _filterIndex = 0;
  final List<String> _filters = ['Tous', 'Payé', 'En retard'];
  List<Map<String, dynamic>> _cotisations = [];
  List<Map<String, dynamic>> _tontines = [];
  bool _loading = true;
  String? _selectedTontineId;

  @override
  void initState() {
    super.initState();
    _chargerDonnees();
  }

  Future<void> _chargerDonnees() async {
    try {
      final tontines = await SupabaseService.getTontines();
      if (tontines.isNotEmpty) {
        _selectedTontineId = tontines[0]['id'];
        final cotisations =
            await SupabaseService.getPaiements(_selectedTontineId!);
        setState(() {
          _tontines = tontines;
          _cotisations = cotisations;
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _chargerCotisations(String tontineId) async {
    setState(() => _loading = true);
    try {
      final cotisations = await SupabaseService.getPaiements(tontineId);
      setState(() {
        _cotisations = cotisations;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  List<Map<String, dynamic>> get _filtered {
    if (_filterIndex == 0) return _cotisations;
    if (_filterIndex == 1)
      return _cotisations.where((c) => c['statut'] == 'paye').toList();
    return _cotisations.where((c) => c['statut'] == 'retard').toList();
  }

  int get _totalPaye => _cotisations.where((c) => c['statut'] == 'paye').length;
  int get _totalRetard =>
      _cotisations.where((c) => c['statut'] != 'paye').length;
  int get _totalMontant => _cotisations
      .where((c) => c['statut'] == 'paye')
      .fold(0, (sum, c) => sum + (c['montant'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cotisations', style: TText.h1),
                      IconButton(
                        icon: const Icon(Iconsax.notification,
                            color: TColors.text, size: 26),
                        onPressed: () => context.go('/notifications'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sélecteur de tontine
                  if (_tontines.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: TColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: TColors.border),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedTontineId,
                          isExpanded: true,
                          dropdownColor: TColors.surface,
                          style: TText.body,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: TColors.textLight),
                          items: _tontines
                              .map((t) => DropdownMenuItem(
                                    value: t['id'] as String,
                                    child: Text(t['nom'], style: TText.body),
                                  ))
                              .toList(),
                          onChanged: (id) {
                            setState(() => _selectedTontineId = id);
                            _chargerCotisations(id!);
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Stats
                  Row(
                    children: [
                      Expanded(
                          child: _StatBadge(
                              label: 'Payé',
                              value: '$_totalPaye',
                              color: TColors.success,
                              bg: TColors.successLight,
                              icon: Icons.check_circle_outline_rounded)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _StatBadge(
                              label: 'En retard',
                              value: '$_totalRetard',
                              color: TColors.warning,
                              bg: TColors.warningLight,
                              icon: Iconsax.clock)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Total collecté
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: TColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total collecté', style: TText.caption),
                            const SizedBox(height: 4),
                            Text(
                              '$_totalMontant FCFA',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: TColors.primary),
                            ),
                          ],
                        ),
                        const Icon(Iconsax.wallet,
                            color: TColors.primary, size: 28),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Filtres
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_filters.length, (i) {
                        final selected = _filterIndex == i;
                        return GestureDetector(
                          onTap: () => setState(() => _filterIndex = i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  selected ? TColors.primary : TColors.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: selected
                                      ? TColors.primary
                                      : TColors.border),
                            ),
                            child: Text(_filters[i],
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? Colors.white
                                      : TColors.textMuted,
                                )),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // Liste
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: TColors.primary))
                  : _filtered.isEmpty
                      ? Center(
                          child:
                              Text('Aucune cotisation', style: TText.bodyMuted))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final c = _filtered[index];
                            final member =
                                c['members'] as Map<String, dynamic>? ?? {};
                            final user =
                                member['users'] as Map<String, dynamic>? ?? {};
                            final nom = user['nom'] ?? 'Inconnu';
                            final initiales = nom.length >= 2
                                ? nom.substring(0, 2).toUpperCase()
                                : nom.toUpperCase();
                            final bool paye = c['statut'] == 'paye';

                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: TColors.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: TColors.border, width: 0.5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? const Color(0xFF1A1A1A)
                                          : TColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(initiales,
                                            style: GoogleFonts.spaceGrotesk(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white))),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(nom,
                                            style: TText.body.copyWith(
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 2),
                                        Text(
                                          c['date_paiement'] != null
                                              ? c['date_paiement']
                                                  .toString()
                                                  .substring(0, 10)
                                              : 'Pas encore payé',
                                          style: TText.caption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('${c['montant']} FCFA',
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: paye
                                                ? TColors.success
                                                : TColors.textMuted,
                                          )),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: paye
                                              ? TColors.successLight
                                              : TColors.warningLight,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          paye ? 'Payé' : 'En retard',
                                          style: GoogleFonts.spaceGrotesk(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: paye
                                                  ? TColors.success
                                                  : TColors.warning),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEnregistrerPaiement(context),
        backgroundColor: TColors.primary,
        icon: const Icon(Iconsax.add, color: Colors.white),
        label: Text('Enregistrer',
            style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),

      // Bottom nav
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: TColors.surface,
          border: Border(top: BorderSide(color: TColors.border, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: 2,
          onTap: (i) {
            switch (i) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/tontine/groupes');
                break;
              case 2:
                break;
              case 3:
                context.go('/calendrier');
                break;
              case 4:
                context.go('/profil');
                break;
            }
          },
          backgroundColor: TColors.surface,
          selectedItemColor: TColors.primary,
          unselectedItemColor: TColors.textMuted,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: GoogleFonts.spaceGrotesk(
              fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.spaceGrotesk(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups_rounded), label: 'Groupes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Cotisations'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded), label: 'Historiques'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded), label: 'Profils'),
          ],
        ),
      ),
    );
  }

  void _showEnregistrerPaiement(BuildContext context) {
    String _moyen = 'Wave';
    String? _selectedMemberId;
    List<Map<String, dynamic>> _membres = [];

    showModalBottomSheet(
      context: context,
      backgroundColor: TColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            // Charger les membres
            if (_membres.isEmpty && _selectedTontineId != null) {
              SupabaseService.getMembres(_selectedTontineId!).then((data) {
                setModalState(() => _membres = data);
              });
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: TColors.border,
                              borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 20),
                  Text('Enregistrer un paiement', style: TText.h3),
                  const SizedBox(height: 20),

                  // Membre
                  Text('Membre', style: TText.label),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: TColors.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: TColors.border)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMemberId,
                        isExpanded: true,
                        hint: Text('Choisir un membre', style: TText.bodyMuted),
                        dropdownColor: TColors.surface,
                        style: TText.body,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: TColors.textLight),
                        items: _membres.map((m) {
                          final user =
                              m['users'] as Map<String, dynamic>? ?? {};
                          return DropdownMenuItem(
                            value: m['id'] as String,
                            child: Text(user['nom'] ?? 'Inconnu',
                                style: TText.body),
                          );
                        }).toList(),
                        onChanged: (id) =>
                            setModalState(() => _selectedMemberId = id),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Moyen de paiement
                  Text('Moyen de paiement', style: TText.label),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['Wave', 'Orange Money', 'MTN Money', 'Cash']
                          .map((m) {
                        final selected = _moyen == m;
                        return GestureDetector(
                          onTap: () => setModalState(() => _moyen = m),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: selected ? TColors.primary : TColors.bg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: selected
                                      ? TColors.primary
                                      : TColors.border),
                            ),
                            child: Text(m,
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: selected
                                        ? Colors.white
                                        : TColors.textMuted)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bouton valider
                  ElevatedButton(
                    onPressed: _selectedMemberId == null
                        ? null
                        : () async {
                            Navigator.pop(context);
                            final tontine = _tontines.firstWhere(
                                (t) => t['id'] == _selectedTontineId);
                            await SupabaseService.enregistrerPaiement(
                              memberId: _selectedMemberId!,
                              tontineId: _selectedTontineId!,
                              montant: tontine['montant'],
                              moyenPaiement: _moyen,
                            );
                            _chargerCotisations(_selectedTontineId!);
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.tick_circle,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text('Valider le paiement', style: TText.button),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ── Widget StatBadge ──────────────────────────────────────────────────────────
class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color bg;
  final IconData icon;

  const _StatBadge(
      {required this.label,
      required this.value,
      required this.color,
      required this.bg,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3))),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 16, fontWeight: FontWeight.w700, color: color)),
              Text(label,
                  style: GoogleFonts.spaceGrotesk(fontSize: 10, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}
