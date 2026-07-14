import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class DetailTontineScreen extends StatefulWidget {
  final String nom;
  const DetailTontineScreen({super.key, required this.nom});

  @override
  State<DetailTontineScreen> createState() => _DetailTontineScreenState();
}

class _DetailTontineScreenState extends State<DetailTontineScreen> {
  int _tabIndex = 0;

  final List<Map<String, dynamic>> _membres = [
    {'nom': 'Jean Koffi', 'initiales': 'JK', 'statut': 'paye', 'dark': true},
    {
      'nom': 'Aminata Diarra',
      'initiales': 'AD',
      'statut': 'paye',
      'dark': false
    },
    {
      'nom': 'Moussa Traoré',
      'initiales': 'MT',
      'statut': 'retard',
      'dark': true
    },
    {'nom': 'Fatou Sow', 'initiales': 'FS', 'statut': 'paye', 'dark': false},
    {
      'nom': 'Abdoulaye Camara',
      'initiales': 'AC',
      'statut': 'retard',
      'dark': true
    },
  ];

  final List<IconData> _tabIcons = [
    Iconsax.people,
    Iconsax.wallet,
    Iconsax.repeat,
    Iconsax.clock,
    Iconsax.setting_2,
  ];

  final List<String> _tabLabels = [
    'Membres',
    'Cotisations',
    'Tours',
    'Historique',
    'Paramètres',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  // Bouton retour
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/tontine/groupes'),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: TColors.primary, size: 22),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Infos groupe
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: TColors.primary, width: 2),
                          color: TColors.surface,
                        ),
                        child: const Icon(Iconsax.people5,
                            color: TColors.primary, size: 40),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.nom, style: TText.h2),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Iconsax.people,
                                    size: 14, color: TColors.textMuted),
                                const SizedBox(width: 4),
                                Text('15 membres', style: TText.bodyMuted),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: TColors.successLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: TColors.success,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Actif',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: TColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_tabLabels.length, (i) {
                        final selected = _tabIndex == i;
                        return GestureDetector(
                          onTap: () => setState(() => _tabIndex = i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selected
                                      ? TColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _tabIcons[i],
                                  size: 16,
                                  color: selected
                                      ? TColors.primary
                                      : TColors.textMuted,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _tabLabels[i],
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 13,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: selected
                                        ? TColors.primary
                                        : TColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Divider(color: TColors.border, height: 1),
                ],
              ),
            ),

            // Contenu tab
            Expanded(
              child: _tabIndex == 0
                  ? _buildMembres()
                  : _tabIndex == 1
                      ? _buildCotisations()
                      : _tabIndex == 2
                          ? _buildTours()
                          : _tabIndex == 3
                              ? _buildHistorique()
                              : _buildParametres(),
            ),
          ],
        ),
      ),

      // FAB
      floatingActionButton: _tabIndex == 0
          ? FloatingActionButton(
              onPressed: () => context.go('/membres'),
              backgroundColor: TColors.primary,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
                context.go('/tontine/groupes');
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

  Widget _buildMembres() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: _membres.length,
      separatorBuilder: (_, __) =>
          const Divider(color: TColors.border, height: 1),
      itemBuilder: (context, index) {
        final m = _membres[index];
        final bool paye = m['statut'] == 'paye';
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Avatar initiales
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: m['dark'] ? const Color(0xFF1A1A1A) : TColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    m['initiales'],
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Nom + statut
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['nom'],
                        style:
                            TText.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color:
                            paye ? TColors.successLight : TColors.warningLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            paye ? Icons.check_rounded : Iconsax.clock,
                            size: 12,
                            color: paye ? TColors.success : TColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            paye ? 'Payé' : 'En retard',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: paye ? TColors.success : TColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Boutons edit + delete
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: TColors.border),
                    ),
                    child: const Icon(Iconsax.edit,
                        size: 16, color: TColors.textMuted),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: TColors.danger),
                    ),
                    child: const Icon(Iconsax.trash,
                        size: 16, color: TColors.danger),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTours() {
    final List<Map<String, dynamic>> tours = [
      {
        'periode': 'Janvier 2026',
        'beneficiaire': 'Yvan De Kenty',
        'initiales': 'YD',
        'montant': '50 000',
        'statut': 'verse',
        'date_versement': '31 Jan 2026',
        'dark': false
      },
      {
        'periode': 'Février 2026',
        'beneficiaire': 'Jean Koffi',
        'initiales': 'JK',
        'montant': '50 000',
        'statut': 'encours',
        'date_versement': '28 Fév 2026',
        'dark': true
      },
      {
        'periode': 'Mars 2026',
        'beneficiaire': 'Aminata Diarra',
        'initiales': 'AD',
        'montant': '50 000',
        'statut': 'avenir',
        'date_versement': '31 Mar 2026',
        'dark': false
      },
      {
        'periode': 'Avril 2026',
        'beneficiaire': 'Moussa Traoré',
        'initiales': 'MT',
        'montant': '50 000',
        'statut': 'avenir',
        'date_versement': '30 Avr 2026',
        'dark': true
      },
      {
        'periode': 'Mai 2026',
        'beneficiaire': 'Fatou Sow',
        'initiales': 'FS',
        'montant': '50 000',
        'statut': 'avenir',
        'date_versement': '31 Mai 2026',
        'dark': false
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: tours.length,
      itemBuilder: (context, index) {
        final t = tours[index];
        final isLast = index == tours.length - 1;
        final bool verse = t['statut'] == 'verse';
        final bool encours = t['statut'] == 'encours';

        Color dotColor = verse
            ? TColors.success
            : encours
                ? TColors.primary
                : TColors.border;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: verse
                            ? TColors.successLight
                            : encours
                                ? TColors.primary.withOpacity(0.15)
                                : TColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: dotColor, width: 2),
                      ),
                      child: Center(
                        child: verse
                            ? const Icon(Icons.check_rounded,
                                color: TColors.success, size: 16)
                            : encours
                                ? const Icon(Iconsax.clock,
                                    color: TColors.primary, size: 14)
                                : Text('${index + 1}',
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: TColors.textMuted)),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                          child: Container(
                              width: 2,
                              color: verse ? TColors.success : TColors.border,
                              margin: const EdgeInsets.symmetric(vertical: 4))),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Card
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: encours
                        ? TColors.primary.withOpacity(0.06)
                        : TColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: encours ? TColors.primary : TColors.border,
                        width: encours ? 1.5 : 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t['periode'],
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: TColors.textMuted)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: verse
                                  ? TColors.successLight
                                  : encours
                                      ? TColors.primary.withOpacity(0.12)
                                      : TColors.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              verse
                                  ? 'Versé'
                                  : encours
                                      ? 'En cours'
                                      : 'À venir',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: verse
                                      ? TColors.success
                                      : encours
                                          ? TColors.primary
                                          : TColors.textMuted),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: t['dark']
                                  ? const Color(0xFF1A1A1A)
                                  : TColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Text(t['initiales'],
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t['beneficiaire'],
                                    style: TText.body
                                        .copyWith(fontWeight: FontWeight.w600)),
                                Text('Versement : ${t['date_versement']}',
                                    style: TText.caption),
                              ],
                            ),
                          ),
                          Text('${t['montant']} FCFA',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: verse
                                      ? TColors.success
                                      : encours
                                          ? TColors.primary
                                          : TColors.textMuted)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCotisations() {
    final List<Map<String, dynamic>> cotisations = [
      {
        'nom': 'Jean Koffi',
        'initiales': 'JK',
        'montant': '10 000',
        'date': '12 Jan 2026',
        'statut': 'paye',
        'moyen': 'Wave',
        'dark': true
      },
      {
        'nom': 'Aminata Diarra',
        'initiales': 'AD',
        'montant': '10 000',
        'date': '13 Jan 2026',
        'statut': 'paye',
        'moyen': 'Orange Money',
        'dark': false
      },
      {
        'nom': 'Moussa Traoré',
        'initiales': 'MT',
        'montant': '10 000',
        'date': '—',
        'statut': 'retard',
        'moyen': '—',
        'dark': true
      },
      {
        'nom': 'Fatou Sow',
        'initiales': 'FS',
        'montant': '10 000',
        'date': '14 Jan 2026',
        'statut': 'paye',
        'moyen': 'Cash',
        'dark': false
      },
      {
        'nom': 'Abdoulaye Camara',
        'initiales': 'AC',
        'montant': '10 000',
        'date': '—',
        'statut': 'retard',
        'moyen': '—',
        'dark': true
      },
    ];

    final int totalPaye =
        cotisations.where((c) => c['statut'] == 'paye').length;
    final int totalRetard =
        cotisations.where((c) => c['statut'] == 'retard').length;

    return Column(
      children: [
        // Résumé
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TColors.successLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: TColors.success.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline_rounded,
                          color: TColors.success, size: 18),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$totalPaye payé(s)',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: TColors.success)),
                          Text('sur ${cotisations.length} membres',
                              style: TText.caption),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TColors.warningLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: TColors.warning.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Iconsax.clock,
                          color: TColors.warning, size: 18),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$totalRetard retard(s)',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: TColors.warning)),
                          Text('à relancer', style: TText.caption),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Liste
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            itemCount: cotisations.length,
            separatorBuilder: (_, __) =>
                const Divider(color: TColors.border, height: 1),
            itemBuilder: (context, index) {
              final c = cotisations[index];
              final bool paye = c['statut'] == 'paye';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: c['dark']
                            ? const Color(0xFF1A1A1A)
                            : TColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(c['initiales'],
                            style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Nom + date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['nom'],
                              style: TText.body
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(
                            paye
                                ? '${c['date']} · ${c['moyen']}'
                                : 'Pas encore payé',
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
                          '${c['montant']} FCFA',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: paye ? TColors.success : TColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: paye
                                ? TColors.successLight
                                : TColors.warningLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                paye ? Icons.check_rounded : Iconsax.clock,
                                size: 11,
                                color: paye ? TColors.success : TColors.warning,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                paye ? 'Payé' : 'En retard',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      paye ? TColors.success : TColors.warning,
                                ),
                              ),
                            ],
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
    );
  }

  Widget _buildHistorique() {
    final List<Map<String, dynamic>> historique = [
      {
        'type': 'cotisation',
        'nom': 'Jean Koffi',
        'initiales': 'JK',
        'montant': '10 000',
        'date': '12 Jan 2026',
        'heure': '18h30',
        'moyen': 'Wave',
        'dark': true,
      },
      {
        'type': 'cotisation',
        'nom': 'Aminata Diarra',
        'initiales': 'AD',
        'montant': '10 000',
        'date': '13 Jan 2026',
        'heure': '09h15',
        'moyen': 'Orange Money',
        'dark': false,
      },
      {
        'type': 'versement',
        'nom': 'Yvan De Kenty',
        'initiales': 'YD',
        'montant': '50 000',
        'date': '31 Jan 2026',
        'heure': '10h00',
        'moyen': 'Orange Money',
        'dark': false,
      },
      {
        'type': 'cotisation',
        'nom': 'Fatou Sow',
        'initiales': 'FS',
        'montant': '10 000',
        'date': '14 Jan 2026',
        'heure': '11h00',
        'moyen': 'Cash',
        'dark': false,
      },
      {
        'type': 'membre',
        'nom': 'Sarah Coulibaly',
        'initiales': 'SC',
        'montant': '—',
        'date': '01 Jan 2026',
        'heure': '08h00',
        'moyen': '—',
        'dark': true,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: historique.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final h = historique[index];
        final bool isVersement = h['type'] == 'versement';
        final bool isMembre = h['type'] == 'membre';

        Color color = isVersement
            ? TColors.success
            : isMembre
                ? const Color(0xFFAB6FD8)
                : TColors.primary;

        Color bg = isVersement
            ? TColors.successLight
            : isMembre
                ? const Color(0xFF1A0A2E)
                : TColors.primary.withOpacity(0.1);

        IconData icon = isVersement
            ? Iconsax.money_recive
            : isMembre
                ? Iconsax.user_add
                : Iconsax.wallet;

        String label = isVersement
            ? 'Versement'
            : isMembre
                ? 'Nouveau membre'
                : 'Cotisation';

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: TColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: TColors.border, width: 0.5),
          ),
          child: Row(
            children: [
              // Icône action
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),

              // Infos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      h['nom'],
                      style: TText.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${h['date']} à ${h['heure']}${h['moyen'] != '—' ? ' · ${h['moyen']}' : ''}',
                      style: TText.caption,
                    ),
                  ],
                ),
              ),

              // Montant + label
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (h['montant'] != '—')
                    Text(
                      '${isVersement ? '+' : '-'} ${h['montant']} FCFA',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildParametres() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Infos du groupe
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: TColors.border, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Iconsax.info_circle,
                        color: TColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Text('Informations du groupe', style: TText.h3),
                  ],
                ),
                const SizedBox(height: 16),
                _ParamItem(label: 'Nom du groupe', value: widget.nom),
                const Divider(color: TColors.border, height: 20),
                _ParamItem(label: 'Cotisation', value: '10 000 FCFA'),
                const Divider(color: TColors.border, height: 20),
                _ParamItem(label: 'Fréquence', value: 'Mensuelle'),
                const Divider(color: TColors.border, height: 20),
                _ParamItem(label: 'Date de début', value: '01 Jan 2026'),
                const Divider(color: TColors.border, height: 20),
                _ParamItem(label: 'Membres', value: '15'),
                const Divider(color: TColors.border, height: 20),
                _ParamItem(label: 'Total par tour', value: '150 000 FCFA'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Actions
          Container(
            decoration: BoxDecoration(
              color: TColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: TColors.border, width: 0.5),
            ),
            child: Column(
              children: [
                _ActionItem(
                  icon: Iconsax.edit,
                  label: 'Modifier le groupe',
                  color: TColors.text,
                  onTap: () => _showComingSoon(context),
                ),
                const Divider(color: TColors.border, height: 1),
                _ActionItem(
                  icon: Iconsax.user_add,
                  label: 'Ajouter un membre',
                  color: TColors.text,
                  onTap: () => context.go('/membres'),
                ),
                const Divider(color: TColors.border, height: 1),
                _ActionItem(
                  icon: Iconsax.notification,
                  label: 'Notifications du groupe',
                  color: TColors.text,
                  onTap: () => _showComingSoon(context),
                ),
                const Divider(color: TColors.border, height: 1),
                _ActionItem(
                  icon: Iconsax.logout,
                  label: 'Quitter le groupe',
                  color: TColors.warning,
                  onTap: () => _showConfirmQuitter(context),
                ),
                const Divider(color: TColors.border, height: 1),
                _ActionItem(
                  icon: Iconsax.trash,
                  label: 'Supprimer le groupe',
                  color: TColors.danger,
                  onTap: () => _showConfirmSupprimer(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: TColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Iconsax.clock, color: TColors.primary, size: 28),
              ),
              const SizedBox(height: 16),
              Text('Disponible bientôt', style: TText.h3),
              const SizedBox(height: 8),
              Text(
                'Cette fonctionnalité sera disponible dans la prochaine version de TontinCI.',
                style: TText.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TText.button),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmQuitter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: TColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: TColors.warningLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.logout,
                    color: TColors.warning, size: 28),
              ),
              const SizedBox(height: 16),
              Text('Quitter le groupe ?', style: TText.h3),
              const SizedBox(height: 8),
              Text(
                'Vous allez quitter ${widget.nom}. Vous perdrez accès à toutes les informations de ce groupe.',
                style: TText.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/tontine/groupes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.warning,
                ),
                child: Text('Quitter le groupe', style: TText.button),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Annuler',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: TColors.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmSupprimer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: TColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: TColors.dangerLight,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Iconsax.trash, color: TColors.danger, size: 28),
              ),
              const SizedBox(height: 16),
              Text('Supprimer le groupe ?', style: TText.h3),
              const SizedBox(height: 8),
              Text(
                'Cette action est irréversible. Toutes les données du groupe seront supprimées.',
                style: TText.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/tontine/groupes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.danger,
                ),
                child: Text('Supprimer', style: TText.button),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Annuler',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: TColors.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} // ← fermeture de _DetailTontineScreenState

class _ParamItem extends StatelessWidget {
  final String label;
  final String value;

  const _ParamItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TText.bodyMuted),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: TColors.text,
          ),
        ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: color == TColors.text ? TColors.textMuted : color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
