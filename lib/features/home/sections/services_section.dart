import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';

class ServicesSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;
  final VoidCallback? onContactTap;

  const ServicesSection({
    super.key,
    required this.config,
    required this.sectionKey,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      key: sectionKey,
      color: DesignSystem.background,
      child: Stack(
        children: [
          // Subtle background decoration
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DesignSystem.accent.withOpacity(0.03),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 120,
              horizontal: isWide ? 80 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SERVICIOS',
                  style: DesignSystem.label,
                ).animate().fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 16),
                Text(
                  'Soluciones de Seguridad Especializadas',
                  style: DesignSystem.h2,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    'Diseñamos arquitecturas de vigilancia adaptadas a cada entorno, utilizando hardware de grado industrial y conectividad en la nube.',
                    style: DesignSystem.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                const SizedBox(height: 80),

                LayoutBuilder(
                  builder: (context, constraints) {
                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: config.services
                            .asMap()
                            .entries
                            .map(
                              (entry) => Expanded(
                                child:
                                    _ServiceCard(
                                          service: entry.value,
                                          onContactTap: onContactTap,
                                        )
                                        .animate()
                                        .fadeIn(
                                          delay: (400 + entry.key * 200).ms,
                                        )
                                        .slideY(begin: 0.1),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return Column(
                      children: config.services
                          .map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: _ServiceCard(
                                service: s,
                                onContactTap: onContactTap,
                              ).animate().fadeIn().slideX(begin: 0.1),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceItem service;
  final VoidCallback? onContactTap;

  const _ServiceCard({required this.service, this.onContactTap});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  void _showDetail(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) => _ServiceDetailDialog(
        service: widget.service,
        onContactTap: widget.onContactTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _showDetail(context),
        child: AnimatedContainer(
          duration: 300.ms,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: _hovered ? DesignSystem.cardBg : DesignSystem.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovered
                  ? DesignSystem.accent.withOpacity(0.3)
                  : Colors.white.withOpacity(0.05),
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: DesignSystem.accent.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: 300.ms,
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _hovered
                      ? DesignSystem.accent
                      : DesignSystem.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.service.icon,
                  color: _hovered ? Colors.white : DesignSystem.accent,
                  size: 32,
                ),
              ),
              const SizedBox(height: 32),
              Text(widget.service.title, style: DesignSystem.h3),
              const SizedBox(height: 16),
              Text(
                widget.service.description,
                style: DesignSystem.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    'SABER MÁS',
                    style: DesignSystem.label.copyWith(
                      color: _hovered ? Colors.white : DesignSystem.accent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: _hovered ? Colors.white : DesignSystem.accent,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceDetailDialog extends StatelessWidget {
  final ServiceItem service;
  final VoidCallback? onContactTap;

  const _ServiceDetailDialog({required this.service, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isWide ? 600 : double.infinity),
        child: Container(
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: DesignSystem.surface,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: DesignSystem.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.security,
                        color: DesignSystem.accent,
                        size: 32,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white54),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  service.title,
                  style: DesignSystem.h2.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 16),
                Text(service.detailDescription, style: DesignSystem.bodyLarge),
                if (service.features.isNotEmpty) ...[
                  const SizedBox(height: 40),
                  Text('CARACTERÍSTICAS CLAVE', style: DesignSystem.label),
                  const SizedBox(height: 20),
                  ...service.features.map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: DesignSystem.accent,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              f,
                              style: DesignSystem.bodyMedium.copyWith(
                                color: DesignSystem.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onContactTap?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DesignSystem.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'SOLICITAR COTIZACIÓN',
                      style: DesignSystem.label.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack).fadeIn(),
    );
  }
}
