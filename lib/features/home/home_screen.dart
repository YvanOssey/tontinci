import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import 'package:iconsax/iconsax.dart';
import '../../shared/services/supabase_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> _groupes = [];
  bool _loadingGroupes = true;
  Map<String, dynamic> _stats = {
    'groupes_actifs': 0,
    'membres_totaux': 0,
    'epargnes_totales': 0,
  };

  @override
  void initState() {
    super.initState();
    _chargerGroupes();
  }

  Future<void> _chargerGroupes() async {
    try {
      final data = await SupabaseService.getTontines();
      final stats = await SupabaseService.getStats();
      setState(() {
        _groupes = data;
        _stats = stats;
        _loadingGroupes = false;
      });
    } catch (e) {
      setState(() => _loadingGroupes = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar custom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Image.asset('assets/images/logo.png', width: 36, height: 36),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tontin",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: TColors.text,
                          ),
                        ),
                        TextSpan(
                          text: "CI",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: TColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined,
                            color: TColors.text, size: 28),
                        onPressed: () => context.go('/notifications'),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: TColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle_outlined,
                        color: TColors.text, size: 32),
                    onPressed: () => context.go('/profil'),
                  ),
                ],
              ),
            ),

            // Contenu scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Grille stats 2x2
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: [
                        _StatCard(
                          icon: Iconsax.people,
                          label: 'Groupes actifs',
                          value: '${_stats['groupes_actifs']}',
                          iconBg: const Color(0xFF2A1A00),
                          iconColor: TColors.primary,
                          valueColor: TColors.primary,
                        ),
                        _StatCard(
                          icon: Iconsax.profile_2user,
                          label: 'Membres totaux',
                          value: '${_stats['membres_totaux']}',
                          iconBg: const Color(0xFF1A0A2E),
                          iconColor: const Color(0xFFAB6FD8),
                          valueColor: const Color(0xFFAB6FD8),
                        ),
                        _StatCard(
                          icon: Iconsax.wallet,
                          label: 'Epargnes totales',
                          value: '${_stats['epargnes_totales']}\nFCFA',
                          iconBg: const Color(0xFF0A2A10),
                          iconColor: const Color(0xFF4CAF50),
                          valueColor: const Color(0xFF4CAF50),
                        ),
                        _StatCard(
                          icon: Iconsax.money_send,
                          label: 'Prêt en cours',
                          value: '0\nFCFA',
                          iconBg: const Color(0xFF2A1A00),
                          iconColor: TColors.primary,
                          valueColor: TColors.primary,
                          highlighted: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Section groupes actifs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Groupes actifs", style: TText.h3),
                        GestureDetector(
                          onTap: () => context.go('/tontine/groupes'),
                          child: Text(
                            "Voir tout >",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: TColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Liste des groupes
                    _loadingGroupes
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: TColors.primary))
                        : _groupes.isEmpty
                            ? Center(
                                child: Text('Aucun groupe',
                                    style: TText.bodyMuted),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _groupes.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final tontine = _groupes[index];
                                  return _GroupeCard(
                                    nom: tontine['nom'] ?? '',
                                    membres: tontine['nb_membres'] ?? 0,
                                    icon: Iconsax.people,
                                    iconColor: TColors.primary,
                                    iconBg: const Color(0xFF2A1A00),
                                    onTap: () => context.go(
                                        '/tontine/detail/${tontine['nom']}'),
                                  );
                                },
                              ),
                    const SizedBox(height: 20),
                  ],
                ),
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
          currentIndex: _currentIndex,
          onTap: (i) {
            setState(() => _currentIndex = i);
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
}

// ── Widget StatCard ──────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconBg;
  final Color iconColor;
  final Color valueColor;
  final bool highlighted;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconBg,
    required this.iconColor,
    required this.valueColor,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: highlighted
            ? Border.all(color: TColors.primary, width: 1.5)
            : Border.all(color: TColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TText.caption),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Widget GroupeCard ────────────────────────────────────────────────────────
class _GroupeCard extends StatelessWidget {
  final String nom;
  final int membres;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const _GroupeCard({
    required this.nom,
    required this.membres,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: TColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: TColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nom, style: TText.h3.copyWith(fontSize: 15)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Iconsax.people,
                          size: 14, color: TColors.textMuted),
                      const SizedBox(width: 4),
                      Text('$membres membres', style: TText.caption),
                      const SizedBox(width: 10),
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
            const Icon(Icons.chevron_right_rounded, color: TColors.textMuted),
          ],
        ),
      ),
    );
  }
}
