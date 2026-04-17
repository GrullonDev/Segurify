import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/site_config.dart';
import '../../../widgets/adaptive_image.dart';
import '../../projects/project_list_screen.dart';

class PortfolioSection extends StatelessWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;
  final VoidCallback? onContactTap;

  const PortfolioSection({
    super.key,
    required this.config,
    required this.sectionKey,
    this.onContactTap,
  });

  void _goToCategory(BuildContext context, String category) {
    final filtered = config.projects
        .where((p) => p.category == category)
        .toList();

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => ProjectListScreen(
          category: category,
          projects: filtered,
          accent: config.accentColor,
          onContactTap: onContactTap,
        ),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  // Returns the first project of each category in a fixed order.
  List<ProjectItem> get _featuredProjects {
    const order = ['CORPORATIVO', 'RESIDENCIAL', 'RETAIL', 'INDUSTRIAL'];
    return order
        .map((cat) => config.projects.firstWhere(
              (p) => p.category == cat,
              orElse: () => config.projects.first,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final featured = _featuredProjects;

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
          const SizedBox(height: 12),
          Text(
            'Selecciona una categoría para ver todos los proyectos',
            style: GoogleFonts.inter(
              color: const Color(0xFF8892A4),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 60),
          if (isWide) ...[
            Row(
              children: [
                Expanded(
                  child: _ProjectCard(
                    project: featured[0],
                    height: 320,
                    accent: config.accentColor,
                    projectCount: config.projects
                        .where((p) => p.category == featured[0].category)
                        .length,
                    onTap: () =>
                        _goToCategory(context, featured[0].category),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ProjectCard(
                    project: featured[1],
                    height: 320,
                    accent: config.accentColor,
                    projectCount: config.projects
                        .where((p) => p.category == featured[1].category)
                        .length,
                    onTap: () =>
                        _goToCategory(context, featured[1].category),
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
                    project: featured[2],
                    height: 260,
                    accent: config.accentColor,
                    projectCount: config.projects
                        .where((p) => p.category == featured[2].category)
                        .length,
                    onTap: () =>
                        _goToCategory(context, featured[2].category),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 6,
                  child: _ProjectCard(
                    project: featured[3],
                    height: 260,
                    accent: config.accentColor,
                    projectCount: config.projects
                        .where((p) => p.category == featured[3].category)
                        .length,
                    onTap: () =>
                        _goToCategory(context, featured[3].category),
                  ),
                ),
              ],
            ),
          ] else
            Column(
              children: featured
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ProjectCard(
                        project: p,
                        height: 220,
                        accent: config.accentColor,
                        projectCount: config.projects
                            .where((x) => x.category == p.category)
                            .length,
                        onTap: () => _goToCategory(context, p.category),
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

// ─── Section Header ───────────────────────────────────────────────────────────

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

// ─── Project Card ─────────────────────────────────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final double height;
  final Color accent;
  final int projectCount;
  final VoidCallback onTap;

  const _ProjectCard({
    required this.project,
    required this.height,
    required this.accent,
    required this.projectCount,
    required this.onTap,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.accent.withValues(alpha: 0.4)
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
                  child: AdaptiveImage(
                    source: widget.project.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: Container(color: const Color(0xFF0D1622)),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(
                          alpha: _hovered ? 0.88 : 0.72,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
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
                      AnimatedOpacity(
                        opacity: _hovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: widget.accent.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${widget.projectCount} proyectos',
                                style: GoogleFonts.sora(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_rounded,
                                  color: Colors.white, size: 13),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
