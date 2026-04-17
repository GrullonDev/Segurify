import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class ServicesSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;

  const ServicesSection({
    super.key,
    required this.config,
    required this.sectionKey,
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

  const _ServiceCard({required this.service, required this.accent});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
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
            Row(
              children: [
                Text(
                  'Detalles',
                  style: GoogleFonts.sora(
                    color: widget.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: widget.accent, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
