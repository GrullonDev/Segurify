import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';
import 'package:segurify/widgets/adaptive_image.dart';

class PortfolioSection extends StatefulWidget {
  final SiteConfig config;
  final GlobalKey sectionKey;
  final VoidCallback? onContactTap;

  const PortfolioSection({
    super.key,
    required this.config,
    required this.sectionKey,
    this.onContactTap,
  });

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  String _selectedCategory = 'TODOS';

  @override
  Widget build(BuildContext context) {
    final categories = [
      'TODOS',
      ...widget.config.projects.map((p) => p.category).toSet(),
    ];
    final filteredProjects = _selectedCategory == 'TODOS'
        ? widget.config.projects
        : widget.config.projects
            .where((p) => p.category == _selectedCategory)
            .toList();

    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      key: widget.sectionKey,
      color: DesignSystem.surface,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: isWide ? 80 : 24,
      ),
      child: Column(
        children: [
          Text('PORTAFOLIO', style: DesignSystem.label).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Proyectos de Referencia',
            style: DesignSystem.h2,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 48),

          // Category Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories
                  .map(
                    (cat) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _FilterChip(
                        label: cat,
                        isSelected: _selectedCategory == cat,
                        onTap: () => setState(() => _selectedCategory = cat),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ).animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 64),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1200
                  ? 3
                  : (constraints.maxWidth > 700 ? 2 : 1);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: 0.9,
                ),
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  return _ProjectCard(
                    key: ValueKey('${_selectedCategory}_$index'),
                    project: filteredProjects[index],
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .scale(begin: const Offset(0.95, 0.95));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? DesignSystem.accent
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? DesignSystem.accent
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          label,
          style: DesignSystem.bodySmall.copyWith(
            color: isSelected ? Colors.white : DesignSystem.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _ProjectCard({super.key, required this.project});

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedScale(
                scale: _hovered ? 1.1 : 1.0,
                duration: 500.ms,
                child: AdaptiveImage(
                  source: widget.project.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                duration: 300.ms,
                opacity: _hovered ? 0.9 : 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        _hovered
                            ? DesignSystem.accent.withOpacity(0.8)
                            : Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.project.category,
                        style: DesignSystem.bodySmall.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.project.title,
                      style: DesignSystem.h3.copyWith(color: Colors.white),
                    ),
                    AnimatedContainer(
                      duration: 300.ms,
                      height: _hovered ? 80 : 0,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              widget.project.description,
                              style: DesignSystem.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
