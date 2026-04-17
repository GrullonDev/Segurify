import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class ServicesSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;
  final VoidCallback? onContactTap;

  const ServicesSection({
    super.key,
    required this.config,
    required this.sectionKey,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      key: sectionKey,
      color: const Color(0xFF080D18),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isWide ? 80 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soluciones de Seguridad Especializadas',
            style: GoogleFonts.sora(
              color: Colors.white,
              fontSize: isWide ? 36 : 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Diseñamos arquitecturas de vigilancia adaptadas a cada entorno, '
            'utilizando hardware de grado industrial y conectividad en la nube.',
            style: GoogleFonts.inter(
              color: const Color(0xFF8892A4),
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 64),
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: config.services
                  .map(
                    (s) => Expanded(
                      child: _ServiceCard(
                        service: s,
                        accent: config.accentColor,
                        onContactTap: onContactTap,
                      ),
                    ),
                  )
                  .toList(),
            )
          else
            Column(
              children: config.services
                  .map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _ServiceCard(
                        service: s,
                        accent: config.accentColor,
                        onContactTap: onContactTap,
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceItem service;
  final Color accent;
  final VoidCallback? onContactTap;

  const _ServiceCard({
    required this.service,
    required this.accent,
    this.onContactTap,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  void _showDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => _ServiceDetailDialog(
        service: widget.service,
        accent: widget.accent,
        onContactTap: widget.onContactTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _showDetail(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF111B2B)
                : const Color(0xFF0D1622),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.accent.withValues(alpha: 0.3)
                  : const Color(0xFF1A2535),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: widget.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.service.icon,
                  color: widget.accent,
                  size: 26,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.service.title,
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.service.description,
                style: GoogleFonts.inter(
                  color: const Color(0xFF8892A4),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.sora(
                  color: _hovered
                      ? widget.accent
                      : widget.accent.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                child: Row(
                  children: [
                    const Text('Detalles'),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, color: widget.accent, size: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceDetailDialog extends StatelessWidget {
  final ServiceItem service;
  final Color accent;
  final VoidCallback? onContactTap;

  const _ServiceDetailDialog({
    required this.service,
    required this.accent,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isWide ? 560 : double.infinity),
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1622),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1A2535)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(service.icon, color: accent, size: 26),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white38, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                service.title,
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                service.detailDescription,
                style: GoogleFonts.inter(
                  color: const Color(0xFF8892A4),
                  fontSize: 14,
                  height: 1.7,
                ),
              ),
              if (service.features.isNotEmpty) ...[
                const SizedBox(height: 28),
                Container(height: 1, color: const Color(0xFF1A2535)),
                const SizedBox(height: 24),
                ...service.features.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_outline_rounded,
                            color: accent, size: 16),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onContactTap?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Solicitar cotización',
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
