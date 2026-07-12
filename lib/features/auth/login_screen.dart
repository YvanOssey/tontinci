import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // Logo + titre centré
              Center(
                child: Column(
                  children: [
                    // Logo cercle avec mains
                    // Logo image
                    Image.asset(
                      'assets/images/logo.png',
                      width: 90,
                      height: 90,
                    ),
                    const SizedBox(height: 16),

                    // Titre TontinCI
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tontin",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: TColors.text,
                            ),
                          ),
                          TextSpan(
                            text: "CI",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: TColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Gestion intelligente de Tontines",
                      style: TText.bodyMuted,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Email
              Text("Email", style: TText.label),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TText.body,
                decoration: const InputDecoration(
                  hintText: "Entrez votre email",
                  prefixIcon: Icon(Icons.mail_outline_rounded,
                      color: TColors.textLight),
                ),
              ),
              const SizedBox(height: 20),

              // Mot de passe
              Text("Mot de passe", style: TText.label),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TText.body,
                decoration: InputDecoration(
                  hintText: "Entrez votre mot de passe",
                  prefixIcon: const Icon(Icons.lock_outline_rounded,
                      color: TColors.textLight),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: TColors.textLight,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),

              // Mot de passe oublié
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Mot de passe oublié ?",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: TColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Bouton connexion
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: Text("Se connecter", style: TText.button),
              ),
              const SizedBox(height: 32),

              // Pas de compte
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Pas de compte ? ",
                        style: TText.bodyMuted,
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => context.go('/inscription'),
                          child: Text(
                            "S'inscrire",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: TColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
