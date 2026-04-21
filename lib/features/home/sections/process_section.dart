import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';

class ProcessSection extends StatelessWidget {
  final SiteConfig config;

  const ProcessSection({super.key, required this.config});

  static const _steps = [
    (
      number: '01',
      title: 'CONSULTA GRATUITA',
      description:
          'Evaluamos tu propiedad y diseñamos un plan de seguridad personalizado sin compromiso.',
      icon: Icons.chat_bubble_outline_rounded,
    ),
    (
      number: '02',
      title: 'INSTALACIÓN EXPERTA',
      description:
          'Técnicos certificados realizan el montaje y configuración optimizando cada ángulo de visión.',
      icon: Icons.on_device_training_rounded,
    ),
    (
      number: '03',
      title: 'SOPORTE 24/7',
      description:
          'Acompañamiento continuo y respuesta rápida ante cualquier incidencia técnica.',
      icon: Icons.support_agent_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      color: DesignSystem.background,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: isWide ? 80 : 24,
      ),
      child: Column(
        children: [
          Text(
            'PROCESO',
            style: DesignSystem.label,
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Cómo Trabajamos',
            style: DesignSystem.h2,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 80),
          
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _steps.asMap().entries.map((e) {
                return Expanded(
                  child: _ProcessStep(
                    step: e.value,
                    isLast: e.key == _steps.length - 1,
                  ).animate().fadeIn(delay: (400 + e.key * 200).ms).slideX(begin: 0.1),
                );
              }).toList(),
            )
          else
            Column(
              children: _steps.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: _ProcessStep(step: s, isLast: true),
              )).toList(),
            ),
        ],
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final ({String number, String title, String description, IconData icon}) step;
  final bool isLast;

  const _ProcessStep({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (!isLast)
                Positioned(
                  left: 60,
                  right: -60,
                  top: 40,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          DesignSystem.accent.withOpacity(0.5),
                          DesignSystem.accent.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: DesignSystem.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: DesignSystem.accent.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: DesignSystem.accent.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(step.icon, color: DesignSystem.accent, size: 32),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: DesignSystem.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    step.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            step.title,
            style: DesignSystem.h3.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            step.description,
            style: DesignSystem.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
