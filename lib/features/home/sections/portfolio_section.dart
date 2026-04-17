import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';

class PortfolioSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;

  const PortfolioSection({
    super.key,
    required this.config,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final projects = config.projects;

    return Container(
      key: sectionKey,
      color: const Color(0xFF070B12),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isWide ? 80 : 24,
      ),
      child: Column(
        children: [
          _SectionHeader(
            title: 'Nuestros Proyectos Recientes',
            accent: config.accentColor,
          ),
          const SizedBox(height: 60),
          if (isWide) ...[
            Row(
              children: [
                Expanded(
                  child: _ProjectCard(
                    project: projects[0],
                    height: 320,
                    accent: config.accentColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ProjectCard(
                    project: projects[1],
                    height: 320,
                    accent: config.accentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _ProjectCard(
                    project: projects[2],
                    height: 260,
                    accent: config.accentColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: _ProjectCard(
                    project: projects[3],
                    height: 260,
                    accent: config.accentColor,
                  ),
                ),
              ],
            ),
          ] else
            Column(
              children: projects
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ProjectCard(
                        project: p,
                        height: 220,
                        accent: config.accentColor,
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color accent;

  const _SectionHeader({required this.title, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.sora(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(width: 48, height: 3, color: accent),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final double height;
  final Color accent;

  const _ProjectCard({
    required this.project,
    required this.height,
    required this.accent,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? widget.accent.withValues(alpha: 0.35)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                scale: _hovered ? 1.04 : 1.0,
                duration: const Duration(milliseconds: 400),
                child: Image.network(
                  widget.project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, err, stack) =>
                      Container(color: const Color(0xFF0D1622)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: widget.accent.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        widget.project.category,
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.project.title,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
