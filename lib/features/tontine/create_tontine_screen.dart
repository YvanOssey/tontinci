import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme.dart';
import '../../shared/services/supabase_service.dart';

class CreateTontineScreen extends StatefulWidget {
  const CreateTontineScreen({super.key});

  @override
  State<CreateTontineScreen> createState() => _CreateTontineScreenState();
}

class _CreateTontineScreenState extends State<CreateTontineScreen> {
  bool _loading = false;
  final _nomController = TextEditingController();
  final _cotisationController = TextEditingController();
  final _membresController = TextEditingController();
  String _frequence = 'Mensuelle';
  DateTime? _dateDebut;

  final List<String> _frequences = [
    'Hebdomadaire',
    'Mensuelle',
    'Trimestrielle'
  ];

  @override
  void dispose() {
    _nomController.dispose();
    _cotisationController.dispose();
    _membresController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: TColors.primary,
              surface: TColors.surface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _dateDebut = picked);
  }

  String get _totalCalcule {
    final cotisation =
        int.tryParse(_cotisationController.text.replaceAll(' ', '')) ?? 0;
    final membres = int.tryParse(_membresController.text) ?? 0;
    if (cotisation == 0 || membres == 0) return '— FCFA';
    final total = cotisation * membres;
    return '${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]} ')} FCFA';
  }

  Future<void> _creerTontine() async {
    if (_nomController.text.isEmpty ||
        _cotisationController.text.isEmpty ||
        _membresController.text.isEmpty ||
        _dateDebut == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Remplissez tous les champs')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await SupabaseService.creerTontine(
        nom: _nomController.text.trim(),
        montant: int.parse(_cotisationController.text.replaceAll(' ', '')),
        frequence: _frequence,
        dateDebut:
            '${_dateDebut!.year}-${_dateDebut!.month.toString().padLeft(2, '0')}-${_dateDebut!.day.toString().padLeft(2, '0')}',
        nbMembres: int.parse(_membresController.text.trim()),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Groupe créé avec succès !')),
        );
        context.go('/tontine/groupes');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: AppBar(
        backgroundColor: TColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: TColors.text, size: 20),
          onPressed: () => context.go('/tontine/groupes'),
        ),
        title: Text('Créer un groupe', style: TText.h3),
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
                      'Remplissez les informations pour créer votre groupe de tontine.',
                      style: TText.caption.copyWith(color: TColors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Nom du groupe
            _SectionLabel(label: 'Nom du groupe', icon: Iconsax.people),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nomController,
              style: TText.body,
              decoration: const InputDecoration(
                hintText: 'ex: Tontine des amis 2026',
                prefixIcon:
                    Icon(Iconsax.edit_2, color: TColors.textLight, size: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Cotisation
            _SectionLabel(
                label: 'Cotisation par membre (FCFA)', icon: Iconsax.wallet),
            const SizedBox(height: 8),
            TextFormField(
              controller: _cotisationController,
              style: TText.body,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'ex: 10 000',
                prefixIcon:
                    Icon(Iconsax.money, color: TColors.textLight, size: 18),
                suffixText: 'FCFA',
              ),
            ),
            const SizedBox(height: 20),

            // Nombre de membres
            _SectionLabel(
                label: 'Nombre de membres', icon: Iconsax.profile_2user),
            const SizedBox(height: 8),
            TextFormField(
              controller: _membresController,
              style: TText.body,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'ex: 10',
                prefixIcon:
                    Icon(Iconsax.people, color: TColors.textLight, size: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Fréquence
            _SectionLabel(
                label: 'Fréquence de cotisation', icon: Iconsax.calendar),
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
                  value: _frequence,
                  isExpanded: true,
                  dropdownColor: TColors.surface,
                  style: TText.body,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: TColors.textLight),
                  items: _frequences
                      .map((f) => DropdownMenuItem(
                            value: f,
                            child: Text(f, style: TText.body),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _frequence = v!),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Date de début
            _SectionLabel(label: 'Date de début', icon: Iconsax.calendar_1),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: TColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: TColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.calendar_2,
                        color: TColors.textLight, size: 18),
                    const SizedBox(width: 12),
                    Text(
                      _dateDebut == null
                          ? 'Sélectionner une date'
                          : '${_dateDebut!.day.toString().padLeft(2, '0')}/${_dateDebut!.month.toString().padLeft(2, '0')}/${_dateDebut!.year}',
                      style: _dateDebut == null
                          ? TText.body.copyWith(color: TColors.textLight)
                          : TText.body,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Calcul automatique
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: TColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: TColors.border, width: 0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total par tour', style: TText.caption),
                      const SizedBox(height: 4),
                      Text(
                        _totalCalcule,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Iconsax.calculator,
                      color: TColors.primary, size: 28),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Bouton créer
            ElevatedButton(
              onPressed: _loading ? null : _creerTontine,
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.people,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text('Créer le groupe', style: TText.button),
                      ],
                    ),
            ),
            const SizedBox(height: 16),

            // Annuler
            OutlinedButton(
              onPressed: () => context.go('/tontine/groupes'),
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
