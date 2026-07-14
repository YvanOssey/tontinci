import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profil', style: TText.h1),
                  IconButton(
                    icon: const Icon(Iconsax.setting_2,
                        color: TColors.text, size: 26),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Avatar + infos
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: TColors.border, width: 0.5),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: TColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              'YD',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: TColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: TColors.bg, width: 2),
                            ),
                            child: const Icon(Icons.edit,
                                color: Colors.white, size: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Nom
                    Text(
                      'Yvan De Kenty',
                      style: TText.h2,
                    ),
                    const SizedBox(height: 4),
                    Text('+225 07 XX XX XX XX', style: TText.bodyMuted),
                    const SizedBox(height: 4),
                    Text('yvan@email.com', style: TText.caption),
                    const SizedBox(height: 16),

                    // Score confiance
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: TColors.primary.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.shield_tick,
                              color: TColors.primary, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Score de confiance : ',
                            style: TText.bodyMuted,
                          ),
                          Text(
                            '98/100',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: TColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Stats personnelles
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Tontines',
                      value: '4',
                      icon: Iconsax.people,
                      color: TColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      label: 'Paiements',
                      value: '24',
                      icon: Iconsax.tick_circle,
                      color: TColors.success,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      label: 'Retards',
                      value: '2',
                      icon: Iconsax.clock,
                      color: TColors.warning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Score IA détaillé
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
                        const Icon(Iconsax.chart,
                            color: TColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Text('Analyse IA', style: TText.h3),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _ScoreBar(
                        label: 'Régularité paiements',
                        value: 0.98,
                        color: TColors.success),
                    const SizedBox(height: 12),
                    _ScoreBar(
                        label: 'Respect des délais',
                        value: 0.85,
                        color: TColors.primary),
                    const SizedBox(height: 12),
                    _ScoreBar(
                        label: 'Fiabilité globale',
                        value: 0.92,
                        color: TColors.success),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: TColors.successLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline_rounded,
                              color: TColors.success, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Membre très fiable — Aucun risque de défaut détecté.',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: TColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menu options
              Container(
                decoration: BoxDecoration(
                  color: TColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: TColors.border, width: 0.5),
                ),
                child: Column(
                  children: [
                    _MenuItem(
                      icon: Iconsax.notification,
                      label: 'Notifications',
                      onTap: () => context.go('/notifications'),
                    ),
                    const Divider(color: TColors.border, height: 1),
                    _MenuItem(
                      icon: Iconsax.lock,
                      label: 'Sécurité',
                      onTap: () => _showComingSoon(context),
                    ),
                    const Divider(color: TColors.border, height: 1),
                    _MenuItem(
                      icon: Iconsax.info_circle,
                      label: 'À propos',
                      onTap: () => _showComingSoon(context),
                    ),
                    const Divider(color: TColors.border, height: 1),
                    _MenuItem(
                      icon: Iconsax.logout,
                      label: 'Se déconnecter',
                      color: TColors.danger,
                      onTap: () => context.go('/login'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
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
          currentIndex: 4,
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
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
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
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: TText.caption),
        ],
      ),
    );
  }
}

// ── Widget ScoreBar ───────────────────────────────────────────────────────────
class _ScoreBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ScoreBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TText.caption),
            Text(
              '${(value * 100).toInt()}%',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: TColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

// ── Widget MenuItem ───────────────────────────────────────────────────────────
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = TColors.text,
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
            Icon(Icons.chevron_right_rounded,
                color: color == TColors.text ? TColors.textMuted : color,
                size: 20),
          ],
        ),
      ),
    );
  }
}
