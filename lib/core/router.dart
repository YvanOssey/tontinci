import 'package:go_router/go_router.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/inscription_screen.dart';
import '../features/home/home_screen.dart';
import '../features/tontine/create_tontine_screen.dart';
import '../features/tontine/detail_tontine_screen.dart';
import '../features/cotisation/cotisation_screen.dart';
import '../features/membres/membres_screen.dart';
import '../features/calendrier/calendrier_screen.dart';
import '../features/stats/stats_screen.dart';
import '../features/profil/profil_screen.dart';
import '../features/notifications/notifications_screen.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (c, s) => const LoginScreen(),
    ),
    GoRoute(
      path: '/inscription',
      builder: (c, s) => const InscriptionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (c, s) => const HomeScreen(),
    ),
    GoRoute(
      path: '/tontine/create',
      builder: (c, s) => const CreateTontineScreen(),
    ),
    GoRoute(
      path: '/tontine/detail',
      builder: (c, s) => const DetailTontineScreen(),
    ),
    GoRoute(
      path: '/cotisation',
      builder: (c, s) => const CotisationScreen(),
    ),
    GoRoute(
      path: '/membres',
      builder: (c, s) => const MembresScreen(),
    ),
    GoRoute(
      path: '/calendrier',
      builder: (c, s) => const CalendrierScreen(),
    ),
    GoRoute(
      path: '/stats',
      builder: (c, s) => const StatsScreen(),
    ),
    GoRoute(
      path: '/profil',
      builder: (c, s) => const ProfilScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (c, s) => const NotificationsScreen(),
    ),
  ],
);
