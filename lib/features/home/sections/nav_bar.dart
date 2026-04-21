import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';

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
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: DesignSystem.background.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 20),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => DesignSystem.primaryGradient.createShader(bounds),
                  child: Text(
                    config.companyName.toUpperCase(),
                    style: DesignSystem.h3.copyWith(
                      letterSpacing: 2,
                      fontSize: 22,
                    ),
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
                  const SizedBox(width: 32),
                  _CtaButton(
                    label: 'COTIZAR AHORA',
                    onTap: onCotizaTap,
                  ),
                ],
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.tune_rounded,
                  tooltip: 'Editor del sitio',
                  onTap: onEditTap,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0);
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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: DesignSystem.bodyMedium.copyWith(
                  color: _hovered ? Colors.white : DesignSystem.textSecondary,
                  fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: 200.ms,
                height: 2,
                width: _hovered ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: DesignSystem.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _CtaButton({required this.label, required this.onTap});

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: _hovered ? Colors.white : DesignSystem.accent,
            foregroundColor: _hovered ? DesignSystem.accent : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: _hovered ? 8 : 0,
            shadowColor: DesignSystem.accent.withOpacity(0.4),
          ),
          child: Text(
            widget.label,
            style: DesignSystem.label.copyWith(
              color: _hovered ? DesignSystem.accent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: DesignSystem.textSecondary),
          ),
        ),
      ),
    );
  }
}
