import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class CotisationScreen extends StatefulWidget {
  const CotisationScreen({super.key});

  @override
  State<CotisationScreen> createState() => _CotisationScreenState();
}

class _CotisationScreenState extends State<CotisationScreen> {
  int _filterIndex = 0;
  final List<String> _filters = ['Tous', 'Payé', 'En retard', 'En attente'];

  final List<Map<String, dynamic>> _cotisations = [
    {
      'nom': 'Jean Koffi',
      'initiales': 'JK',
      'montant': '10 000',
      'date': '12 Jan 2026',
      'heure': '18h30',
      'statut': 'paye',
      'moyen': 'Wave',
      'dark': true,
      'validePar': 'Yvan (Admin)',
    },
    {
      'nom': 'Aminata Diarra',
      'initiales': 'AD',
      'montant': '10 000',
      'date': '13 Jan 2026',
      'heure': '09h15',
      'statut': 'paye',
      'moyen': 'Orange Money',
      'dark': false,
      'validePar': 'Yvan (Admin)',
    },
    {
      'nom': 'Moussa Traoré',
      'initiales': 'MT',
      'montant': '10 000',
      'date': '—',
      'heure': '—',
      'statut': 'retard',
      'moyen': '—',
      'dark': true,
      'validePar': '—',
    },
    {
      'nom': 'Fatou Sow',
      'initiales': 'FS',
      'montant': '10 000',
      'date': '14 Jan 2026',
      'heure': '11h00',
      'statut': 'paye',
      'moyen': 'Cash',
      'dark': false,
      'validePar': 'Yvan (Admin)',
    },
    {
      'nom': 'Abdoulaye Camara',
      'initiales': 'AC',
      'montant': '10 000',
      'date': '—',
      'heure': '—',
      'statut': 'retard',
      'moyen': '—',
      'dark': true,
      'validePar': '—',
    },
    {
      'nom': 'Sarah Coulibaly',
      'initiales': 'SC',
      'montant': '10 000',
      'date': '—',
      'heure': '—',
      'statut': 'attente',
      'moyen': '—',
      'dark': false,
      'validePar': '—',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_filterIndex == 0) return _cotisations;
    if (_filterIndex == 1)
      return _cotisations.where((c) => c['statut'] == 'paye').toList();
    if (_filterIndex == 2)
      return _cotisations.where((c) => c['statut'] == 'retard').toList();
    return _cotisations.where((c) => c['statut'] == 'attente').toList();
  }

  int get _totalPaye => _cotisations.where((c) => c['statut'] == 'paye').length;
  int get _totalRetard =>
      _cotisations.where((c) => c['statut'] == 'retard').length;
  int get _totalAttente =>
      _cotisations.where((c) => c['statut'] == 'attente').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre + notif
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

                  // Résumé stats
                  Row(
                    children: [
                      Expanded(
                        child: _StatBadge(
                          label: 'Payé',
                          value: '$_totalPaye',
                          color: TColors.success,
                          bg: TColors.successLight,
                          icon: Icons.check_circle_outline_rounded,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatBadge(
                          label: 'En retard',
                          value: '$_totalRetard',
                          color: TColors.warning,
                          bg: TColors.warningLight,
                          icon: Iconsax.clock,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatBadge(
                          label: 'En attente',
                          value: '$_totalAttente',
                          color: TColors.textMuted,
                          bg: TColors.surface,
                          icon: Iconsax.timer_1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Total collecté
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: TColors.primary.withOpacity(0.3), width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total collecté ce mois',
                                style: TText.caption),
                            const SizedBox(height: 4),
                            Text(
                              '${_totalPaye * 10} 000 FCFA',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: TColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Janvier 2026',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

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
                                color:
                                    selected ? TColors.primary : TColors.border,
                              ),
                            ),
                            child: Text(
                              _filters[i],
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color:
                                    selected ? Colors.white : TColors.textMuted,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Liste cotisations
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final c = _filtered[index];
                  return _CotisationCard(cotisation: c);
                },
              ),
            ),
          ],
        ),
      ),

      // FAB enregistrer paiement
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showEnregistrerPaiement(context),
        backgroundColor: TColors.primary,
        icon: const Icon(Iconsax.add, color: Colors.white),
        label: Text(
          'Enregistrer',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
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

  // ── Bottom sheet enregistrer paiement ──────────────────────────────────────
  void _showEnregistrerPaiement(BuildContext context) {
    String _moyen = 'Wave';
    showModalBottomSheet(
      context: context,
      backgroundColor: TColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: TColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
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
                      border: Border.all(color: TColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'Jean Koffi',
                        isExpanded: true,
                        dropdownColor: TColors.surface,
                        style: TText.body,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: TColors.textLight),
                        items: _cotisations
                            .map((c) => DropdownMenuItem(
                                  value: c['nom'] as String,
                                  child: Text(c['nom'], style: TText.body),
                                ))
                            .toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Moyen de paiement
                  Text('Moyen de paiement', style: TText.label),
                  const SizedBox(height: 8),
                  Row(
                    children:
                        ['Wave', 'Orange Money', 'MTN Money', 'Cash'].map((m) {
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
                              color:
                                  selected ? TColors.primary : TColors.border,
                            ),
                          ),
                          child: Text(
                            m,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color:
                                  selected ? Colors.white : TColors.textMuted,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Bouton valider
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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

// ── Widget StatBadge ─────────────────────────────────────────────────────────
class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color bg;
  final IconData icon;

  const _StatBadge({
    required this.label,
    required this.value,
    required this.color,
    required this.bg,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              Text(label,
                  style: GoogleFonts.spaceGrotesk(fontSize: 10, color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Widget CotisationCard ────────────────────────────────────────────────────
class _CotisationCard extends StatelessWidget {
  final Map<String, dynamic> cotisation;

  const _CotisationCard({required this.cotisation});

  @override
  Widget build(BuildContext context) {
    final bool paye = cotisation['statut'] == 'paye';
    final bool retard = cotisation['statut'] == 'retard';

    Color statusColor = paye
        ? TColors.success
        : retard
            ? TColors.warning
            : TColors.textMuted;
    Color statusBg = paye
        ? TColors.successLight
        : retard
            ? TColors.warningLight
            : TColors.surface;
    String statusLabel = paye
        ? 'Payé'
        : retard
            ? 'En retard'
            : 'En attente';
    IconData statusIcon = paye
        ? Icons.check_rounded
        : retard
            ? Iconsax.clock
            : Iconsax.timer_1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              // Avatar
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cotisation['dark']
                      ? const Color(0xFF1A1A1A)
                      : TColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    cotisation['initiales'],
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Nom
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cotisation['nom'],
                      style: TText.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cotisation['date'] == '—'
                          ? 'Pas encore payé'
                          : '${cotisation['date']} à ${cotisation['heure']}',
                      style: TText.caption,
                    ),
                  ],
                ),
              ),

              // Montant + statut
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${cotisation['montant']} FCFA',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: paye ? TColors.success : TColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, size: 11, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          statusLabel,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Détails si payé
          if (paye) ...[
            const SizedBox(height: 12),
            const Divider(color: TColors.border, height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DetailItem(
                  label: 'Moyen',
                  value: cotisation['moyen'],
                  icon: Iconsax.wallet,
                ),
                _DetailItem(
                  label: 'Validé par',
                  value: cotisation['validePar'],
                  icon: Iconsax.shield_tick,
                ),
              ],
            ),
          ],

          // Bouton payer si retard ou attente
          if (!paye) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Enregistrer le paiement',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: TColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: TColors.textMuted),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TText.caption),
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: TColors.text,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
