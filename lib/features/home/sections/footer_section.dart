import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class FooterSection extends StatelessWidget {
  final SiteConfig config;

  const FooterSection({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      color: const Color(0xFF04070D),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: isWide ? 80 : 24,
            ),
            child: Column(
              children: [
                const Divider(color: Color(0xFF1A2535)),
                const SizedBox(height: 24),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            config.companyName.toUpperCase(),
                            style: GoogleFonts.sora(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '© $year ${config.companyName.toUpperCase()} SECURITY SYSTEMS. ALL RIGHTS RESERVED.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF4A5568),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: 28,
                        runSpacing: 12,
                        alignment: WrapAlignment.end,
                        children: _links(),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Text(
                        config.companyName.toUpperCase(),
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 20,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: _links(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '© $year ${config.companyName.toUpperCase()}. ALL RIGHTS RESERVED.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4A5568),
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _links() {
    return ['Privacy Policy', 'Terms of Service', 'Licensing', 'Contact Support']
        .map(
          (l) => Text(
            l,
            style: GoogleFonts.inter(
              color: const Color(0xFF4A5568),
              fontSize: 12,
            ),
          ),
        )
        .toList();
  }
}
