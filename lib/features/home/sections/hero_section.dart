import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';
import 'package:segurify/widgets/adaptive_image.dart';

class HeroSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;
  final VoidCallback onCotizaTap;
  final VoidCallback onVerSistemasTap;

  const HeroSection({
    super.key,
    required this.config,
    required this.sectionKey,
    required this.onCotizaTap,
    required this.onVerSistemasTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;
    final isCompact = size.width < 600;

    return Container(
      key: sectionKey,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DesignSystem.background,
      ),
      child: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -200,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DesignSystem.accent.withOpacity(0.05),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 4.seconds),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 80 : 24,
              vertical: isCompact ? 40 : 100,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 900;

                final textBlock = Column(
                  crossAxisAlignment: stacked ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: DesignSystem.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: DesignSystem.accent.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.verified_user_rounded, color: DesignSystem.accent, size: 14),
                          const SizedBox(width: 8),
                          Text(
                            config.tagline,
                            style: DesignSystem.label,
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                    const SizedBox(height: 32),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.white, Color(0xFF94A3B8)],
                      ).createShader(bounds),
                      child: Text(
                        config.heroTitle,
                        style: DesignSystem.h1.copyWith(
                          fontSize: isWide ? 56 : 36,
                          color: Colors.white,
                        ),
                        textAlign: stacked ? TextAlign.center : TextAlign.left,
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 800.ms).slideY(begin: 0.2),
                    const SizedBox(height: 24),
                    Text(
                      config.heroSubtitle,
                      style: DesignSystem.bodyLarge,
                      textAlign: stacked ? TextAlign.center : TextAlign.left,
                    ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
                    const SizedBox(height: 48),
                    Wrap(
                      spacing: 20,
                      runSpacing: 16,
                      alignment: stacked ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        _HeroButton(
                          label: 'Cotiza tu Instalación',
                          isPrimary: true,
                          onTap: onCotizaTap,
                        ),
                        _HeroButton(
                          label: 'Ver Sistemas',
                          isPrimary: false,
                          onTap: onVerSistemasTap,
                        ),
                      ],
                    ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
                  ],
                );

                final imagePanel = Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: DesignSystem.accent.withOpacity(0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        AdaptiveImage(
                          source: config.heroBackgroundImage,
                          height: isWide ? 500 : 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  DesignSystem.background.withOpacity(0.6),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .moveY(begin: 0, end: -15, duration: 3.seconds, curve: Curves.easeInOut)
                 .animate().scale(delay: 400.ms, duration: 800.ms, curve: Curves.easeOutBack);

                if (stacked) {
                  return Column(
                    children: [
                      imagePanel,
                      const SizedBox(height: 60),
                      textBlock,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(flex: 6, child: textBlock),
                    const SizedBox(width: 60),
                    Expanded(flex: 5, child: imagePanel),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.05 : 1.0,
        duration: 200.ms,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: widget.isPrimary && !_hovered ? DesignSystem.primaryGradient : null,
            color: !widget.isPrimary || _hovered ? (widget.isPrimary ? Colors.white : Colors.white.withOpacity(0.05)) : null,
            border: !widget.isPrimary ? Border.all(color: Colors.white.withOpacity(0.1)) : null,
          ),
          child: ElevatedButton(
            onPressed: widget.onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: widget.isPrimary && !_hovered ? Colors.white : (widget.isPrimary ? DesignSystem.accent : Colors.white),
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              widget.label,
              style: DesignSystem.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: widget.isPrimary && !_hovered ? Colors.white : (widget.isPrimary ? DesignSystem.accent : Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
