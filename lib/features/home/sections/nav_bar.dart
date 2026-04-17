import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class NavBar extends StatelessWidget {
  final SiteConfig config;
  final List<({String label, GlobalKey sectionKey})> sections;
  final VoidCallback onEditTap;
  final VoidCallback onCotizaTap;

  const NavBar({
    super.key,
    required this.config,
    required this.sections,
    required this.onEditTap,
    required this.onCotizaTap,
  });

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF070B12).withValues(alpha: 0.96),
        border: const Border(
          bottom: BorderSide(color: Color(0xFF1A2535)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 20),
        child: Row(
          children: [
            Text(
              config.companyName.toUpperCase(),
              style: GoogleFonts.sora(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const Spacer(),
            if (isWide) ...[
              ...sections.map(
                (s) => _NavLink(
                  label: s.label,
                  onTap: () => _scrollTo(s.sectionKey),
                ),
              ),
              const SizedBox(width: 24),
              _CtaButton(
                label: 'Solicitar Cotización',
                color: config.accentColor,
                onTap: onCotizaTap,
              ),
            ],
            const SizedBox(width: 16),
            Tooltip(
              message: 'Editor del sitio',
              child: IconButton(
                onPressed: onEditTap,
                icon: const Icon(Icons.tune_rounded, size: 22),
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            widget.label,
            style: GoogleFonts.sora(
              color: _hovered ? Colors.white : const Color(0xFF8892A4),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CtaButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        label,
        style: GoogleFonts.sora(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
