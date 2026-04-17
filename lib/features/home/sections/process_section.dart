import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class ProcessSection extends StatelessWidget {
  final SiteConfig config;

  const ProcessSection({super.key, required this.config});

  static const _steps = [
    (
      number: '1',
      title: 'Consulta gratuita',
      description:
          'Evaluamos tu propiedad y diseñamos un plan de seguridad personalizado sin compromiso.',
    ),
    (
      number: '2',
      title: 'Instalación experta',
      description:
          'Técnicos certificados realizan el montaje y configuración optimizando cada ángulo de visión.',
    ),
    (
      number: '3',
      title: 'Soporte 24/7',
      description:
          'Acompañamiento continuo y respuesta rápida ante cualquier incidencia técnica.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      color: const Color(0xFF080D18),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isWide ? 80 : 24,
      ),
      child: isWide
          ? Row(
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
          : Column(
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
