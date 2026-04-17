import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';
import '../../../widgets/adaptive_image.dart';

class ProcessSection extends StatelessWidget {
  final SiteConfig config;

  const ProcessSection({super.key, required this.config});

  static const _steps = [
    (
      number: '1',
      title: 'Consulta gratuita',
      description:
          'Evaluamos tu propiedad y diseÃ±amos un plan de seguridad personalizado sin compromiso.',
    ),
    (
      number: '2',
      title: 'InstalaciÃ³n experta',
      description:
          'TÃ©cnicos certificados realizan el montaje y configuraciÃ³n optimizando cada Ã¡ngulo de visiÃ³n.',
    ),
    (
      number: '3',
      title: 'Soporte 24/7',
      description:
          'AcompaÃ±amiento continuo y respuesta rÃ¡pida ante cualquier incidencia tÃ©cnica.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      color: const Color(0xFF080D18),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: AdaptiveImage(
                source: config.sectionBackgroundImage,
                fit: BoxFit.cover,
                placeholder: Container(color: const Color(0xFF080D18)),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF080D18).withValues(alpha: 0.90),
                    const Color(0xFF080D18).withValues(alpha: 0.96),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 100,
              horizontal: isWide ? 80 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nuestro Proceso',
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: isWide ? 34 : 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Un flujo claro para pasar de la evaluación al sistema funcionando sin fricción.',
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
                    children: _steps.asMap().entries.map((e) {
                      return Expanded(
                        child: _StepCard(
                          number: e.value.number,
                          title: e.value.title,
                          description: e.value.description,
                          accent: config.accentColor,
                          showConnector: e.key < _steps.length - 1,
                        ),
                      );
                    }).toList(),
                  )
                else
                  Column(
                    children: _steps
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: _StepCard(
                              number: s.number,
                              title: s.title,
                              description: s.description,
                              accent: config.accentColor,
                              showConnector: false,
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final Color accent;
  final bool showConnector;

  const _StepCard({
    required this.number,
    required this.title,
    required this.description,
    required this.accent,
    required this.showConnector,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (showConnector)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        height: 1,
                        color: const Color(0xFF1A2535),
                      ),
                    ),
                  ),
                ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1622),
                  border: Border.all(color: const Color(0xFF1A2535)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.sora(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              color: const Color(0xFF8892A4),
              fontSize: 14,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
