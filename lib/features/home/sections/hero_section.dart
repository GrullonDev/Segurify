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
    final heroHeight = isWide
        ? (size.height * 0.95).clamp(640.0, 900.0)
        : (size.height * 1.05).clamp(720.0, 980.0);

    return SizedBox(
      key: sectionKey,
      width: double.infinity,
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AdaptiveImage(
            source: config.heroBackgroundImage,
            fit: BoxFit.cover,
            placeholder: Container(color: const Color(0xFF070B12)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF070B12).withValues(alpha: 0.97),
                  const Color(0xFF070B12).withValues(alpha: 0.88),
                  const Color(0xFF070B12).withValues(alpha: 0.55),
                  const Color(0xFF070B12).withValues(alpha: 0.2),
                ],
                stops: const [0.0, 0.38, 0.68, 1.0],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF070B12).withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: heroPadding,
              vertical: isCompact ? 72 : 96,
            ),
            child: Align(
              alignment:
                  isWide ? Alignment.centerLeft : Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 620 : double.infinity,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isWide
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
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
                    const SizedBox(height: 28),
                    Text(
                      config.heroTitle,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: heroTitleSize,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                      textAlign:
                          isWide ? TextAlign.left : TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      config.heroSubtitle,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8892A4),
                        fontSize: isWide ? 16 : 14,
                        height: 1.7,
                      ),
                      textAlign:
                          isWide ? TextAlign.left : TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      alignment: isWide
                          ? WrapAlignment.start
                          : WrapAlignment.center,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
