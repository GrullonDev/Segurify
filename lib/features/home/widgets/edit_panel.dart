import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class EditPanel extends StatefulWidget {
  final SiteConfig config;
  final ValueChanged<SiteConfig> onConfigChanged;
  final VoidCallback onClose;

  const EditPanel({
    super.key,
    required this.config,
    required this.onConfigChanged,
    required this.onClose,
  });

  @override
  State<EditPanel> createState() => _EditPanelState();
}

class _EditPanelState extends State<EditPanel> {
  late TextEditingController _nameCtrl;
  late TextEditingController _heroImgCtrl;
  late List<TextEditingController> _projectImgCtrls;

  static const _accentOptions = [
    Color(0xFFFF6820),
    Color(0xFF00D4FF),
    Color(0xFF00E676),
    Color(0xFFFF2D55),
    Color(0xFFFFD700),
    Color(0xFF9C27B0),
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.config.companyName);
    _heroImgCtrl =
        TextEditingController(text: widget.config.heroBackgroundImage);
    _projectImgCtrls = widget.config.projects
        .map((p) => TextEditingController(text: p.imageUrl))
        .toList();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _heroImgCtrl.dispose();
    for (final c in _projectImgCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _apply() {
    final updated = List<ProjectItem>.generate(
      widget.config.projects.length,
      (i) => widget.config.projects[i].copyWith(
        imageUrl: _projectImgCtrls[i].text.trim(),
      ),
    );
    widget.onConfigChanged(
      widget.config.copyWith(
        companyName: _nameCtrl.text.trim(),
        heroBackgroundImage: _heroImgCtrl.text.trim(),
        projects: updated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      decoration: const BoxDecoration(
        color: Color(0xFF0D1622),
        border: Border(left: BorderSide(color: Color(0xFF1A2535))),
      ),
      child: Column(
        children: [
          _PanelHeader(
            accentColor: widget.config.accentColor,
            onClose: widget.onClose,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Label('NOMBRE DE EMPRESA'),
                  const SizedBox(height: 8),
                  _EditField(ctrl: _nameCtrl, hint: 'Ej: Segurify'),
                  const SizedBox(height: 28),
                  _Label('COLOR DE ACENTO'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _accentOptions.map((color) {
                      final selected = widget.config.accentColor.toARGB32() == color.toARGB32();
                      return GestureDetector(
                        onTap: () => widget.onConfigChanged(
                          widget.config.copyWith(accentColor: color),
                        ),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selected
                                ? Border.all(color: Colors.white, width: 2.5)
                                : Border.all(
                                    color: Colors.transparent,
                                    width: 2.5,
                                  ),
                            boxShadow: selected
                                ? [
                                    BoxShadow(
                                      color: color.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                  _Label('IMAGEN HERO (URL)'),
                  const SizedBox(height: 8),
                  _EditField(
                    ctrl: _heroImgCtrl,
                    hint: 'https://...',
                    multiline: true,
                  ),
                  const SizedBox(height: 28),
                  _Label('IMÁGENES DE PROYECTOS'),
                  const SizedBox(height: 12),
                  ...List.generate(widget.config.projects.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.config.projects[i].title,
                            style: GoogleFonts.sora(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _EditField(
                            ctrl: _projectImgCtrls[i],
                            hint: 'https://...',
                            multiline: true,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          _ApplyButton(
            accentColor: widget.config.accentColor,
            onApply: _apply,
          ),
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final Color accentColor;
  final VoidCallback onClose;

  const _PanelHeader({required this.accentColor, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1A2535))),
      ),
      child: Row(
        children: [
          Icon(Icons.tune_rounded, color: accentColor, size: 18),
          const SizedBox(width: 10),
          Text(
            'Editor del Sitio',
            style: GoogleFonts.sora(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
            color: Colors.white38,
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  final Color accentColor;
  final VoidCallback onApply;

  const _ApplyButton({required this.accentColor, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF1A2535))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            'Aplicar Cambios',
            style: GoogleFonts.sora(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sora(
        color: Colors.white38,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _EditField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final bool multiline;

  const _EditField({
    required this.ctrl,
    required this.hint,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      maxLines: multiline ? 3 : 1,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0A1018),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
    );
  }
}
