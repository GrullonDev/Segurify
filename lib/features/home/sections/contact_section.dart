import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class ContactSection extends StatefulWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;

  const ContactSection({
    super.key,
    required this.config,
    required this.sectionKey,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      key: widget.sectionKey,
      color: const Color(0xFF070B12),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isWide ? 80 : 24,
      ),
      child: Container(
        padding: EdgeInsets.all(isWide ? 60 : 32),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1622),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1A2535)),
        ),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: _ContactInfo(config: widget.config),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 6,
                    child: _ContactForm(
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      phoneCtrl: _phoneCtrl,
                      accent: widget.config.accentColor,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  _ContactInfo(config: widget.config),
                  const SizedBox(height: 48),
                  _ContactForm(
                    nameCtrl: _nameCtrl,
                    emailCtrl: _emailCtrl,
                    phoneCtrl: _phoneCtrl,
                    accent: widget.config.accentColor,
                  ),
                ],
              ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final SiteConfig config;

  const _ContactInfo({required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Listo para blindar\ntu espacio?',
          style: GoogleFonts.sora(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Completa el formulario y uno de nuestros especialistas se pondrá '
          'en contacto contigo en menos de 24 horas.',
          style: GoogleFonts.inter(
            color: const Color(0xFF8892A4),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        _InfoRow(
          icon: Icons.phone_outlined,
          text: config.phone,
          accent: config.accentColor,
        ),
        const SizedBox(height: 16),
        _InfoRow(
          icon: Icons.email_outlined,
          text: config.email,
          accent: config.accentColor,
        ),
        const SizedBox(height: 16),
        _InfoRow(
          icon: Icons.location_on_outlined,
          text: config.address,
          accent: config.accentColor,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color accent;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: accent, size: 18),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final Color accent;

  const _ContactForm({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Field(ctrl: nameCtrl, label: 'NOMBRE COMPLETO', hint: 'Juan Pérez'),
        const SizedBox(height: 20),
        _Field(
          ctrl: emailCtrl,
          label: 'EMAIL CORPORATIVO / PERSONAL',
          hint: 'juan@ejemplo.com',
        ),
        const SizedBox(height: 20),
        _Field(
          ctrl: phoneCtrl,
          label: 'TELÉFONO DE CONTACTO',
          hint: '+56 9...',
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: accent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              'ENVIAR SOLICITUD',
              style: GoogleFonts.sora(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final String hint;

  const _Field({
    required this.ctrl,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.sora(
            color: const Color(0xFF8892A4),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(color: const Color(0xFF3A4A5C), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF0A1018),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1A2535)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1A2535)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
        ),
      ],
    );
  }
}
