import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'titre': 'Cotisation en retard',
      'message':
          'Moussa Traoré n\'a pas encore payé sa cotisation de 10 000 FCFA pour Afrik Solidaire.',
      'type': 'retard',
      'date': 'Aujourd\'hui à 09h00',
      'lu': false,
    },
    {
      'titre': 'Paiement reçu',
      'message':
          'Jean Koffi a payé sa cotisation de 10 000 FCFA pour Afrik Solidaire.',
      'type': 'paiement',
      'date': 'Aujourd\'hui à 08h30',
      'lu': false,
    },
    {
      'titre': 'Votre tour arrive !',
      'message':
          'Vous êtes le prochain bénéficiaire dans Afrik Solidaire. Versement prévu le 28 Fév 2026.',
      'type': 'tour',
      'date': 'Hier à 18h00',
      'lu': false,
    },
    {
      'titre': 'Rappel cotisation',
      'message':
          'Votre cotisation de 10 000 FCFA pour Afrik Solidaire arrive à échéance dans 3 jours.',
      'type': 'rappel',
      'date': 'Hier à 10h00',
      'lu': true,
    },
    {
      'titre': 'Nouveau membre',
      'message': 'Sarah Coulibaly a rejoint le groupe Afrik Solidaire.',
      'type': 'membre',
      'date': '12 Jan 2026',
      'lu': true,
    },
    {
      'titre': 'Paiement reçu',
      'message':
          'Fatou Sow a payé sa cotisation de 10 000 FCFA pour Afrik Solidaire.',
      'type': 'paiement',
      'date': '12 Jan 2026',
      'lu': true,
    },
    {
      'titre': 'Groupe créé',
      'message': 'Vous avez créé le groupe Afrik Solidaire avec 15 membres.',
      'type': 'groupe',
      'date': '01 Jan 2026',
      'lu': true,
    },
  ];

  IconData _getIcon(String type) {
    switch (type) {
      case 'retard':
        return Iconsax.clock;
      case 'paiement':
        return Iconsax.tick_circle;
      case 'tour':
        return Iconsax.medal_star;
      case 'rappel':
        return Iconsax.notification;
      case 'membre':
        return Iconsax.user_add;
      case 'groupe':
        return Iconsax.people;
      default:
        return Iconsax.notification;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'retard':
        return TColors.warning;
      case 'paiement':
        return TColors.success;
      case 'tour':
        return TColors.primary;
      case 'rappel':
        return TColors.primary;
      case 'membre':
        return const Color(0xFFAB6FD8);
      case 'groupe':
        return TColors.primary;
      default:
        return TColors.primary;
    }
  }

  Color _getBg(String type) {
    switch (type) {
      case 'retard':
        return TColors.warningLight;
      case 'paiement':
        return TColors.successLight;
      case 'tour':
        return TColors.primary.withOpacity(0.12);
      case 'rappel':
        return TColors.primary.withOpacity(0.12);
      case 'membre':
        return const Color(0xFF1A0A2E);
      case 'groupe':
        return TColors.primary.withOpacity(0.12);
      default:
        return TColors.surface;
    }
  }

  int get _nonLues => _notifications.where((n) => !n['lu']).length;

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
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.go('/home'),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: TColors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text('Notifications', style: TText.h1),
                        ],
                      ),
                      if (_nonLues > 0)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              for (var n in _notifications) {
                                n['lu'] = true;
                              }
                            });
                          },
                          child: Text(
                            'Tout lire',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: TColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_nonLues > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$_nonLues non lue${_nonLues > 1 ? 's' : ''}',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Liste
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                itemCount: _notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final n = _notifications[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() => n['lu'] = true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: n['lu']
                            ? TColors.surface
                            : TColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: n['lu']
                              ? TColors.border
                              : TColors.primary.withOpacity(0.3),
                          width: n['lu'] ? 0.5 : 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icône
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: _getBg(n['type']),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getIcon(n['type']),
                              color: _getColor(n['type']),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Contenu
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      n['titre'],
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 14,
                                        fontWeight: n['lu']
                                            ? FontWeight.w500
                                            : FontWeight.w700,
                                        color: TColors.text,
                                      ),
                                    ),
                                    if (!n['lu'])
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: TColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  n['message'],
                                  style: TText.caption,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  n['date'],
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 11,
                                    color: TColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
