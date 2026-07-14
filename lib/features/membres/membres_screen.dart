import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';

class MembresScreen extends StatefulWidget {
  const MembresScreen({super.key});

  @override
  State<MembresScreen> createState() => _MembresScreenState();
}

class _MembresScreenState extends State<MembresScreen> {
  final _nomController = TextEditingController();
  final _telephoneController = TextEditingController();
  int _rang = 1;

  @override
  void dispose() {
    _nomController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: AppBar(
        backgroundColor: TColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: TColors.primary, size: 20),
          onPressed: () => context.go('/tontine/detail/Afrik Solidaire'),
        ),
        title: Text('Ajouter un membre', style: TText.h3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Bannière info
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: TColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.info_circle,
                      color: TColors.primary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Ajoutez un membre à votre groupe de tontine.',
                      style: TText.caption.copyWith(color: TColors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Avatar membre
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: TColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: TColors.border, width: 1.5),
                    ),
                    child: const Icon(Iconsax.user,
                        color: TColors.textMuted, size: 40),
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
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Nom complet
            _SectionLabel(label: 'Nom complet', icon: Iconsax.user),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nomController,
              style: TText.body,
              decoration: const InputDecoration(
                hintText: 'ex: Jean Koffi',
                prefixIcon:
                    Icon(Iconsax.user, color: TColors.textLight, size: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Téléphone
            _SectionLabel(label: 'Numéro de téléphone', icon: Iconsax.call),
            const SizedBox(height: 8),
            TextFormField(
              controller: _telephoneController,
              keyboardType: TextInputType.phone,
              style: TText.body,
              decoration: const InputDecoration(
                hintText: 'ex: 07 XX XX XX XX',
                prefixIcon:
                    Icon(Iconsax.call, color: TColors.textLight, size: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Rang dans l'ordre des tours
            _SectionLabel(
                label: 'Rang (ordre des tours)', icon: Iconsax.ranking),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: TColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: TColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Position dans le calendrier', style: TText.bodyMuted),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_rang > 1) setState(() => _rang--);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: TColors.bg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: TColors.border),
                          ),
                          child: const Icon(Icons.remove,
                              color: TColors.textMuted, size: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '$_rang',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: TColors.primary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _rang++),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rôle
            _SectionLabel(label: 'Rôle dans le groupe', icon: Iconsax.shield),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: TColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: TColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'Membre',
                  isExpanded: true,
                  dropdownColor: TColors.surface,
                  style: TText.body,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: TColors.textLight),
                  items: ['Membre', 'Administrateur']
                      .map((r) => DropdownMenuItem(
                            value: r,
                            child: Text(r, style: TText.body),
                          ))
                      .toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Bouton ajouter
            ElevatedButton(
              onPressed: () => context.go('/tontine/detail/Afrik Solidaire'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.user_add, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text('Ajouter le membre', style: TText.button),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Annuler
            OutlinedButton(
              onPressed: () => context.go('/tontine/detail/Afrik Solidaire'),
              child: Text(
                'Annuler',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: TColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ── Widget SectionLabel ──────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SectionLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: TColors.primary),
        const SizedBox(width: 8),
        Text(label, style: TText.label),
      ],
    );
  }
}
