import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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
              const SizedBox(height: 40),

              // Logo + titre centré
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png',
                        width: 90, height: 90),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 20),
                    Text(
                      "Créer votre compte",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: TColors.text,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Nom complet
              TextFormField(
                controller: _nomController,
                style: TText.body,
                decoration: const InputDecoration(
                  hintText: "Nom complet",
                  prefixIcon: Icon(Icons.person_outline_rounded,
                      color: TColors.textLight),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TText.body,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail_outline_rounded,
                      color: TColors.textLight),
                ),
              ),
              const SizedBox(height: 16),

              // Téléphone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TText.body,
                decoration: const InputDecoration(
                  hintText: "Téléphone",
                  prefixIcon:
                      Icon(Icons.phone_outlined, color: TColors.textLight),
                ),
              ),
              const SizedBox(height: 16),

              // Mot de passe
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: TText.body,
                decoration: InputDecoration(
                  hintText: "Mot de passe",
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
              const SizedBox(height: 16),

              // Confirmer mot de passe
              TextFormField(
                controller: _confirmController,
                obscureText: _obscureConfirm,
                style: TText.body,
                decoration: InputDecoration(
                  hintText: "Confirmer mot de passe",
                  prefixIcon: const Icon(Icons.lock_outline_rounded,
                      color: TColors.textLight),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: TColors.textLight,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bouton S'inscrire
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: Text("S'inscrire", style: TText.button),
              ),
              const SizedBox(height: 24),

              // Déjà inscrit
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Déjà inscrit ? ", style: TText.bodyMuted),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Text(
                            "Se connecter",
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
