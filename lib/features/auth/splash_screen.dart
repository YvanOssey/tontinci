import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: Stack(
        children: [
          // Cercle décoratif haut gauche
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: TColors.primary.withOpacity(0.08),
              ),
            ),
          ),

          // Cercle décoratif haut droite
          Positioned(
            top: -30,
            right: -80,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.06),
              ),
            ),
          ),

          // Cercle décoratif bas gauche
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.07),
              ),
            ),
          ),

          // Cercle décoratif bas droite
          Positioned(
            bottom: -40,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: TColors.primary.withOpacity(0.06),
              ),
            ),
          ),

          // Contenu centré
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo + Titre sur la même ligne
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo.png',
                        width: 64, height: 64),
                    const SizedBox(width: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tontin",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: TColors.text,
                            ),
                          ),
                          TextSpan(
                            text: "CI",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: TColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Ligne orange sous le titre
                Container(
                  margin: const EdgeInsets.only(left: 76),
                  width: 80,
                  height: 3,
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),

                // Tagline
                Padding(
                  padding: const EdgeInsets.only(left: 76),
                  child: Text(
                    "Gestion intelligente de Tontines",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: TColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
