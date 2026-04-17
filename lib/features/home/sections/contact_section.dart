import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/site_config.dart';

// ─── Country model ────────────────────────────────────────────────────────────

class _Country {
  final String name;
  final String flag;
  final String dialCode;
  const _Country(this.name, this.flag, this.dialCode);
}

const _kCountries = [
  _Country('Guatemala', '\u{1F1EC}\u{1F1F9}', '+502'),
  _Country('El Salvador', '\u{1F1F8}\u{1F1FB}', '+503'),
  _Country('Honduras', '\u{1F1ED}\u{1F1F3}', '+504'),
  _Country('Nicaragua', '\u{1F1F3}\u{1F1EE}', '+505'),
  _Country('Costa Rica', '\u{1F1E8}\u{1F1F7}', '+506'),
  _Country('Panama', '\u{1F1F5}\u{1F1E6}', '+507'),
  _Country('Colombia', '\u{1F1E8}\u{1F1F4}', '+57'),
  _Country('Ecuador', '\u{1F1EA}\u{1F1E8}', '+593'),
  _Country('Mexico', '\u{1F1F2}\u{1F1FD}', '+52'),
  _Country('Estados Unidos', '\u{1F1FA}\u{1F1F8}', '+1'),
  _Country('Canada', '\u{1F1E8}\u{1F1E6}', '+1'),
];

// ─── Section ──────────────────────────────────────────────────────────────────

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
  _Country _selectedCountry = _kCountries.first; // Guatemala default

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
                      selectedCountry: _selectedCountry,
                      onCountryChanged: (c) =>
                          setState(() => _selectedCountry = c),
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
                    selectedCountry: _selectedCountry,
                    onCountryChanged: (c) =>
                        setState(() => _selectedCountry = c),
                  ),
                ],
              ),
      ),
    );
  }
}

// ─── Contact Info ─────────────────────────────────────────────────────────────

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
          'Completa el formulario y te contactamos directamente '
          'por WhatsApp en menos de 24 horas.',
          style: GoogleFonts.inter(
            color: const Color(0xFF8892A4),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        _InfoRow(icon: Icons.phone_outlined, text: config.phone, accent: config.accentColor),
        const SizedBox(height: 16),
        _InfoRow(icon: Icons.email_outlined, text: config.email, accent: config.accentColor),
        const SizedBox(height: 16),
        _InfoRow(icon: Icons.location_on_outlined, text: config.address, accent: config.accentColor),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF25D366).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF25D366).withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.chat_rounded, color: Color(0xFF25D366), size: 16),
              const SizedBox(width: 8),
              Text(
                'Respuesta vía WhatsApp',
                style: GoogleFonts.sora(
                  color: const Color(0xFF25D366),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color accent;

  const _InfoRow({required this.icon, required this.text, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            softWrap: true,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

// ─── Contact Form ─────────────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final Color accent;
  final _Country selectedCountry;
  final ValueChanged<_Country> onCountryChanged;

  const _ContactForm({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.accent,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  bool _sending = false;
  String? _error;

  Future<void> _submit() async {
    final name = widget.nameCtrl.text.trim();
    final phone = widget.phoneCtrl.text.trim().replaceAll(RegExp(r'\D'), '');

    if (name.isEmpty || phone.isEmpty) {
      setState(() => _error = 'El nombre y número de WhatsApp son requeridos.');
      return;
    }

    setState(() { _sending = true; _error = null; });

    final dialCode = widget.selectedCountry.dialCode.replaceAll('+', '');
    final email = widget.emailCtrl.text.trim();

    final message = Uri.encodeComponent(
      '¡Hola! Me llamo *$name*${email.isNotEmpty ? ' ($email)' : ''} '
      'y me interesa conocer más sobre sus servicios de seguridad. '
      'Quedo en espera de su respuesta. 🙏',
    );

    final url = Uri.parse('https://wa.me/$dialCode$phone?text=$message');

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      widget.nameCtrl.clear();
      widget.emailCtrl.clear();
      widget.phoneCtrl.clear();
    } catch (_) {
      setState(() => _error = 'No se pudo abrir WhatsApp. Verifica el número.');
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Field(ctrl: widget.nameCtrl, label: 'NOMBRE COMPLETO', hint: 'Juan Pérez'),
        const SizedBox(height: 20),
        _Field(
          ctrl: widget.emailCtrl,
          label: 'EMAIL (OPCIONAL)',
          hint: 'juan@ejemplo.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _PhoneField(
          ctrl: widget.phoneCtrl,
          accent: widget.accent,
          selectedCountry: widget.selectedCountry,
          onCountryChanged: widget.onCountryChanged,
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(
            _error!,
            style: GoogleFonts.inter(
              color: const Color(0xFFFF6B6B),
              fontSize: 12,
            ),
          ),
        ],
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _sending ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              disabledBackgroundColor: const Color(0xFF25D366).withValues(alpha: 0.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: _sending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        'ENVIAR POR WHATSAPP',
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Al enviar, se abrirá WhatsApp con tu mensaje prellenado.',
            style: GoogleFonts.inter(
              color: const Color(0xFF8892A4),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ─── Phone Field ──────────────────────────────────────────────────────────────

class _PhoneField extends StatelessWidget {
  final TextEditingController ctrl;
  final Color accent;
  final _Country selectedCountry;
  final ValueChanged<_Country> onCountryChanged;

  const _PhoneField({
    required this.ctrl,
    required this.accent,
    required this.selectedCountry,
    required this.onCountryChanged,
  });

  void _openPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => _CountryPickerDialog(
        accent: accent,
        selected: selectedCountry,
        onSelect: onCountryChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NÚMERO DE WHATSAPP',
          style: GoogleFonts.sora(
            color: const Color(0xFF8892A4),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Country picker button
            GestureDetector(
              onTap: () => _openPicker(context),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1018),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF1A2535)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(selectedCountry.flag, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 6),
                    Text(
                      selectedCountry.dialCode,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.expand_more_rounded,
                        color: Color(0xFF3A4A5C), size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Phone number input
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: ctrl,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: '5512 3456',
                    hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF3A4A5C), fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFF0A1018),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
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
                      borderSide:
                          const BorderSide(color: Color(0xFF25D366), width: 1.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Country Picker Dialog ────────────────────────────────────────────────────

class _CountryPickerDialog extends StatefulWidget {
  final Color accent;
  final _Country selected;
  final ValueChanged<_Country> onSelect;

  const _CountryPickerDialog({
    required this.accent,
    required this.selected,
    required this.onSelect,
  });

  @override
  State<_CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<_CountryPickerDialog> {
  final _searchCtrl = TextEditingController();
  List<_Country> _filtered = _kCountries;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String q) {
    final query = q.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? _kCountries
          : _kCountries
              .where((c) =>
                  c.name.toLowerCase().contains(query) ||
                  c.dialCode.contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 560),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D1622),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1A2535)),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 12),
                child: Row(
                  children: [
                    Text(
                      'Selecciona tu país',
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close,
                          color: Colors.white38, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: _onSearch,
                  autofocus: true,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Buscar país o código...',
                    hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF3A4A5C), fontSize: 13),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: Color(0xFF3A4A5C), size: 18),
                    filled: true,
                    fillColor: const Color(0xFF0A1018),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xFF1A2535)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xFF1A2535)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: widget.accent.withValues(alpha: 0.6)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _filtered.length,
                  itemBuilder: (_, i) {
                    final country = _filtered[i];
                    final isSelected =
                        country.dialCode == widget.selected.dialCode &&
                        country.name == widget.selected.name;
                    return InkWell(
                      onTap: () {
                        widget.onSelect(country);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        color: isSelected
                            ? widget.accent.withValues(alpha: 0.08)
                            : Colors.transparent,
                        child: Row(
                          children: [
                            Text(country.flag,
                                style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                country.name,
                                style: GoogleFonts.inter(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              country.dialCode,
                              style: GoogleFonts.sora(
                                color: isSelected
                                    ? widget.accent
                                    : const Color(0xFF8892A4),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
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
      ),
    );
  }
}

// ─── Generic Field ────────────────────────────────────────────────────────────

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final String hint;
  final TextInputType keyboardType;

  const _Field({
    required this.ctrl,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
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
          keyboardType: keyboardType,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(color: const Color(0xFF3A4A5C), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF0A1018),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

