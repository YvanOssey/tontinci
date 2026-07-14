import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class CalendrierScreen extends StatefulWidget {
  const CalendrierScreen({super.key});

  @override
  State<CalendrierScreen> createState() => _CalendrierScreenState();
}

class _CalendrierScreenState extends State<CalendrierScreen> {
  int _filterIndex = 0;
  final List<String> _filters = ['Tous', 'Cotisations', 'Versements'];

  final List<Map<String, dynamic>> _historique = [
    {
      'type': 'cotisation',
      'nom': 'Jean Koffi',
      'initiales': 'JK',
      'groupe': 'Afrik Solidaire',
      'montant': '10 000',
      'date': '12 Jan 2026',
      'heure': '18h30',
      'moyen': 'Wave',
      'dark': true,
    },
    {
      'type': 'versement',
      'nom': 'Yvan De Kenty',
      'initiales': 'YD',
      'groupe': 'Afrik Solidaire',
      'montant': '50 000',
      'date': '31 Jan 2026',
      'heure': '10h00',
      'moyen': 'Orange Money',
      'dark': false,
    },
    {
      'type': 'cotisation',
      'nom': 'Aminata Diarra',
      'initiales': 'AD',
      'groupe': 'Union des Femmes',
      'montant': '5 000',
      'date': '13 Jan 2026',
      'heure': '09h15',
      'moyen': 'Wave',
      'dark': false,
    },
    {
      'type': 'cotisation',
      'nom': 'Fatou Sow',
      'initiales': 'FS',
      'groupe': 'Afrik Solidaire',
      'montant': '10 000',
      'date': '14 Jan 2026',
      'heure': '11h00',
      'moyen': 'Cash',
      'dark': false,
    },
    {
      'type': 'cotisation',
      'nom': 'Moussa Traoré',
      'initiales': 'MT',
      'groupe': 'Jeunesses Unies',
      'montant': '20 000',
      'date': '10 Jan 2026',
      'heure': '14h30',
      'moyen': 'MTN Money',
      'dark': true,
    },
    {
      'type': 'versement',
      'nom': 'Marie Koné',
      'initiales': 'MK',
      'groupe': 'Union des Femmes',
      'montant': '100 000',
      'date': '31 Déc 2025',
      'heure': '09h00',
      'moyen': 'Wave',
      'dark': true,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_filterIndex == 0) return _historique;
    if (_filterIndex == 1)
      return _historique.where((h) => h['type'] == 'cotisation').toList();
    return _historique.where((h) => h['type'] == 'versement').toList();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Historique', style: TText.h1),
                      IconButton(
                        icon: const Icon(Iconsax.notification,
                            color: TColors.text, size: 26),
                        onPressed: () => context.go('/notifications'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Toutes vos transactions',
                    style: TText.bodyMuted,
                  ),
                  const SizedBox(height: 16),

                  // Stats rapides
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Total cotisé',
                          value: '45 000 FCFA',
                          color: TColors.primary,
                          icon: Iconsax.wallet,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          label: 'Total reçu',
                          value: '50 000 FCFA',
                          color: TColors.success,
                          icon: Iconsax.money_recive,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Filtres
                  Row(
                    children: List.generate(_filters.length, (i) {
                      final selected = _filterIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => _filterIndex = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected ? TColors.primary : TColors.surface,
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
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Liste
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: _filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final h = _filtered[index];
                  return _HistoriqueCard(item: h);
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom nav
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: TColors.surface,
          border: Border(top: BorderSide(color: TColors.border, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: 3,
          onTap: (i) {
            switch (i) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/tontine/groupes');
                break;
              case 2:
                context.go('/cotisation');
                break;
              case 3:
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
}

// ── Widget StatCard ───────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: TColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TText.caption),
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Widget HistoriqueCard ─────────────────────────────────────────────────────
class _HistoriqueCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _HistoriqueCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isVersement = item['type'] == 'versement';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: TColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item['dark'] ? const Color(0xFF1A1A1A) : TColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                item['initiales'],
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['nom'],
                  style: TText.body.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Iconsax.people,
                        size: 12, color: TColors.textMuted),
                    const SizedBox(width: 4),
                    Text(item['groupe'], style: TText.caption),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${item['date']} à ${item['heure']} · ${item['moyen']}',
                  style: TText.caption,
                ),
              ],
            ),
          ),

          // Montant + type
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isVersement ? '+' : '-'} ${item['montant']} FCFA',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isVersement ? TColors.success : TColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isVersement
                      ? TColors.successLight
                      : TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isVersement ? 'Versement' : 'Cotisation',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isVersement ? TColors.success : TColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
