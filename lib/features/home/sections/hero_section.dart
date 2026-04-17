import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';
import '../../../widgets/adaptive_image.dart';

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
    final heroTitleSize = isWide ? 58.0 : (isCompact ? 34.0 : 44.0);
    final heroPadding = isWide ? 80.0 : (isCompact ? 20.0 : 28.0);

    return Container(
      key: sectionKey,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF070B12),
            const Color(0xFF070B12).withValues(alpha: 0.98),
            const Color(0xFF080D18),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: heroPadding,
          vertical: isCompact ? 24 : 40,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 900;

            final imagePanel = ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: stacked ? 16 / 11 : 4 / 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AdaptiveImage(
                      source: config.heroBackgroundImage,
                      fit: BoxFit.cover,
                      placeholder:
                          Container(color: const Color(0xFF0D1622)),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF070B12).withValues(alpha: 0.18),
                            const Color(0xFF070B12).withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

            final textBlock = Column(
              crossAxisAlignment: stacked
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: config.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: config.accentColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    config.tagline,
                    style: GoogleFonts.sora(
                      color: config.accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  config.heroTitle,
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: heroTitleSize,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                  ),
                  textAlign: stacked ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 20),
                Text(
                  config.heroSubtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8892A4),
                    fontSize: isWide ? 16 : 14,
                    height: 1.7,
                  ),
                  textAlign: stacked ? TextAlign.center : TextAlign.left,
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  alignment:
                      stacked ? WrapAlignment.center : WrapAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: onCotizaTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: config.accentColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Cotiza tu Instalación',
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: onVerSistemasTap,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF3A4A5C)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Ver Sistemas',
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );

            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  imagePanel,
                  const SizedBox(height: 28),
                  textBlock,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: textBlock),
                const SizedBox(width: 40),
                Expanded(child: imagePanel),
              ],
            );
          },
        ),
      ),
    );
  }
}
