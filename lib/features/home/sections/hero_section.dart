import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class HeroSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;

  const HeroSection({
    super.key,
    required this.config,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return Container(
      key: sectionKey,
      height: size.height - 70,
      constraints: const BoxConstraints(minHeight: 600),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            config.heroBackgroundImage,
            fit: BoxFit.cover,
            errorBuilder: (context, err, stack) =>
                Container(color: const Color(0xFF070B12)),
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
            padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24),
            child: Align(
              alignment:
                  isWide ? Alignment.centerLeft : Alignment.center,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: isWide ? 620 : double.infinity),
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
                        fontSize: isWide ? 58 : 36,
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
                          onPressed: () {},
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
                          onPressed: () {},
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
