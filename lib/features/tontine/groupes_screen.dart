import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class GroupesScreen extends StatefulWidget {
  const GroupesScreen({super.key});

  @override
  State<GroupesScreen> createState() => _GroupesScreenState();
}

class _GroupesScreenState extends State<GroupesScreen> {
  final List<Map<String, dynamic>> _groupes = [
    {
      'nom': 'Afrik Solidaire',
      'membres': 15,
      'cotisation': '10 000',
      'frequence': 'Mensuelle',
      'total': '150 000',
      'icon': Iconsax.people,
      'iconColor': TColors.primary,
      'iconBg': const Color(0xFF2A1A00),
      'prochain': 'Yvan — Août 2026',
    },
    {
      'nom': 'Union des Femmes',
      'membres': 20,
      'cotisation': '5 000',
      'frequence': 'Hebdomadaire',
      'total': '100 000',
      'icon': Iconsax.woman,
      'iconColor': const Color(0xFFAB6FD8),
      'iconBg': const Color(0xFF1A0A2E),
      'prochain': 'Marie — Sept 2026',
    },
    {
      'nom': 'Jeunesses Unies',
      'membres': 10,
      'cotisation': '20 000',
      'frequence': 'Mensuelle',
      'total': '200 000',
      'icon': Iconsax.profile_2user,
      'iconColor': const Color(0xFF4CAF50),
      'iconBg': const Color(0xFF0A2A10),
      'prochain': 'Paul — Oct 2026',
    },
    {
      'nom': 'Femmes du quartier',
      'membres': 7,
      'cotisation': '15 000',
      'frequence': 'Mensuelle',
      'total': '105 000',
      'icon': Iconsax.home,
      'iconColor': const Color(0xFF29B6F6),
      'iconBg': const Color(0xFF0A1A2E),
      'prochain': 'Sarah — Nov 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: AppBar(
        backgroundColor: TColors.bg,
        title: Text('Groupes', style: TText.h3),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: TColors.text),
            onPressed: () => context.go('/notifications'),
          ),
          IconButton(
            icon: const Icon(Iconsax.user, color: TColors.text),
            onPressed: () => context.go('/profil'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Barre de recherche
            TextField(
              style: TText.body,
              decoration: InputDecoration(
                hintText: 'Rechercher un groupe...',
                prefixIcon:
                    const Icon(Iconsax.search_normal, color: TColors.textLight),
                filled: true,
                fillColor: TColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Titre + compteur
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mes groupes', style: TText.h3),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_groupes.length} groupes',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: TColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Liste
            Expanded(
              child: ListView.separated(
                itemCount: _groupes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final g = _groupes[index];
                  return _GroupeDetailCard(
                    nom: g['nom'],
                    membres: g['membres'],
                    cotisation: g['cotisation'],
                    frequence: g['frequence'],
                    total: g['total'],
                    prochain: g['prochain'],
                    icon: g['icon'],
                    iconColor: g['iconColor'],
                    iconBg: g['iconBg'],
                    onTap: () => context.go('/tontine/detail/${g['nom']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bouton flottant créer groupe
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/tontine/create'),
        backgroundColor: TColors.primary,
        icon: const Icon(Iconsax.add, color: Colors.white),
        label: Text(
          'Créer un groupe',
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
          currentIndex: 1,
          onTap: (i) {
            switch (i) {
              case 0:
                context.go('/home');
                break;
              case 1:
                break;
              case 2:
                context.go('/cotisation');
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
}

// ── Widget GroupeDetailCard ──────────────────────────────────────────────────
class _GroupeDetailCard extends StatelessWidget {
  final String nom;
  final int membres;
  final String cotisation;
  final String frequence;
  final String total;
  final String prochain;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const _GroupeDetailCard({
    required this.nom,
    required this.membres,
    required this.cotisation,
    required this.frequence,
    required this.total,
    required this.prochain,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: iconBg, borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nom, style: TText.h3.copyWith(fontSize: 15)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Iconsax.people,
                              size: 13, color: TColors.textMuted),
                          const SizedBox(width: 4),
                          Text('$membres membres', style: TText.caption),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D2B1A),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Actif',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: TColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: TColors.textMuted),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(color: TColors.border, height: 1),
            const SizedBox(height: 14),

            // Infos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoItem(label: 'Cotisation', value: '$cotisation FCFA'),
                _InfoItem(label: 'Fréquence', value: frequence),
                _InfoItem(label: 'Total collecté', value: '$total FCFA'),
              ],
            ),
            const SizedBox(height: 12),

            // Prochain bénéficiaire
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.calendar,
                      size: 14, color: TColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Prochain bénéficiaire : ',
                    style: TText.caption,
                  ),
                  Text(
                    prochain,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TText.caption),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: TColors.text,
          ),
        ),
      ],
    );
  }
}
