import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/site_config.dart';
import '../../widgets/adaptive_image.dart';

class ProjectListScreen extends StatefulWidget {
  final String category;
  final List<ProjectItem> projects;
  final Color accent;
  final VoidCallback? onContactTap;

  const ProjectListScreen({
    super.key,
    required this.category,
    required this.projects,
    required this.accent,
    this.onContactTap,
  });

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final _scrollController = ScrollController();

  static const _categoryIcons = {
    'CORPORATIVO': Icons.business_outlined,
    'RESIDENCIAL': Icons.home_outlined,
    'RETAIL': Icons.storefront_outlined,
    'INDUSTRIAL': Icons.factory_outlined,
  };

  static const _categoryDescriptions = {
    'CORPORATIVO':
        'Soluciones de vigilancia de alto rendimiento para edificios de oficinas, '
        'campus corporativos y espacios de trabajo profesionales.',
    'RESIDENCIAL':
        'Seguridad inteligente para hogares, condominios y comunidades privadas '
        'con acceso remoto y monitoreo familiar.',
    'RETAIL':
        'Sistemas orientados a prevención de pérdidas, analíticas de clientes '
        'y vigilancia multitienda en el sector comercial.',
    'INDUSTRIAL':
        'Videovigilancia de alta resistencia para plantas, bodegas y perimetros '
        'industriales con integración a sistemas de control.',
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openDetail(BuildContext context, ProjectItem project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (_) => _ProjectDetailDialog(
        project: project,
        accent: widget.accent,
        onContactTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          widget.onContactTap?.call();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;
    final icon = _categoryIcons[widget.category] ?? Icons.camera_alt_outlined;
    final desc = _categoryDescriptions[widget.category] ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _CategoryAppBar(
            category: widget.category,
            icon: icon,
            description: desc,
            accent: widget.accent,
            projectCount: widget.projects.length,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 80 : 20,
              vertical: 48,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _ProjectGridCard(
                  project: widget.projects[i],
                  accent: widget.accent,
                  onTap: () => _openDetail(context, widget.projects[i]),
                ),
                childCount: widget.projects.length,
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: isWide ? 360 : 420,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: isWide ? 0.78 : 1.15,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _ContactCta(
              accent: widget.accent,
              onTap: () {
                Navigator.of(context).pop();
                widget.onContactTap?.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _CategoryAppBar extends StatelessWidget {
  final String category;
  final IconData icon;
  final String description;
  final Color accent;
  final int projectCount;

  const _CategoryAppBar({
    required this.category,
    required this.icon,
    required this.description,
    required this.accent,
    required this.projectCount,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: const Color(0xFF070B12),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver',
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0D1622), Color(0xFF070B12)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isWide ? 80 : 20,
              isWide ? 80 : 88,
              isWide ? 80 : 20,
              32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Icon(icon, color: accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Proyectos',
                          style: GoogleFonts.sora(
                            color: accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          category,
                          style: GoogleFonts.sora(
                            color: Colors.white,
                            fontSize: isWide ? 28 : 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flex(
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF8892A4),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                    if (isWide)
                      const SizedBox(width: 40)
                    else
                      const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1622),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF1A2535)),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$projectCount',
                              style: GoogleFonts.sora(
                                color: accent,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: '\nproyectos',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF8892A4),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: const Color(0xFF1A2535)),
      ),
    );
  }
}

// ─── Grid Card ────────────────────────────────────────────────────────────────

class _ProjectGridCard extends StatefulWidget {
  final ProjectItem project;
  final Color accent;
  final VoidCallback onTap;

  const _ProjectGridCard({
    required this.project,
    required this.accent,
    required this.onTap,
  });

  @override
  State<_ProjectGridCard> createState() => _ProjectGridCardState();
}

class _ProjectGridCardState extends State<_ProjectGridCard> {
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
          decoration: BoxDecoration(
            color: const Color(0xFF0D1622),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.accent.withValues(alpha: 0.4)
                  : const Color(0xFF1A2535),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(11),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedScale(
                        scale: _hovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 350),
                        child: AdaptiveImage(
                          source: widget.project.imageUrl,
                          fit: BoxFit.cover,
                          placeholder:
                              Container(color: const Color(0xFF111B2B)),
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
                                alpha: _hovered ? 0.5 : 0.2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_hovered)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: widget.accent.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.photo_library_outlined,
                                    color: Colors.white, size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  'Ver proyecto',
                                  style: GoogleFonts.sora(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.project.description,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8892A4),
                        fontSize: 12,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

// ─── CTA Banner ───────────────────────────────────────────────────────────────

class _ContactCta extends StatelessWidget {
  final Color accent;
  final VoidCallback onTap;

  const _ContactCta({required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Container(
      margin: EdgeInsets.fromLTRB(isWide ? 80 : 20, 0, isWide ? 80 : 20, 80),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1622),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1A2535)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 700;

          final button = SizedBox(
            width: stacked ? double.infinity : null,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Solicitar cotización',
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Quieres un proyecto similar?',
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cuéntanos tu necesidad y te enviamos una cotización en 24 horas.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8892A4),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                button,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Quieres un proyecto similar?',
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cuéntanos tu necesidad y te enviamos una cotización en 24 horas.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8892A4),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              button,
            ],
          );
        },
      ),
    );
  }
}

// ─── Detail Dialog ────────────────────────────────────────────────────────────

class _ProjectDetailDialog extends StatefulWidget {
  final ProjectItem project;
  final Color accent;
  final VoidCallback? onContactTap;

  const _ProjectDetailDialog({
    required this.project,
    required this.accent,
    this.onContactTap,
  });

  @override
  State<_ProjectDetailDialog> createState() => _ProjectDetailDialogState();
}

class _ProjectDetailDialogState extends State<_ProjectDetailDialog> {
  int _selectedIndex = 0;

  List<String> get _images => widget.project.gallery.isNotEmpty
      ? widget.project.gallery
      : [widget.project.imageUrl];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isWide ? 60 : 16,
        vertical: 40,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D1622),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1A2535)),
          ),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _GalleryPanel(
                        images: _images,
                        selectedIndex: _selectedIndex,
                        accent: widget.accent,
                        onSelect: (i) => setState(() => _selectedIndex = i),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: _InfoPanel(
                        project: widget.project,
                        accent: widget.accent,
                        onContactTap: widget.onContactTap,
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _GalleryPanel(
                        images: _images,
                        selectedIndex: _selectedIndex,
                        accent: widget.accent,
                        onSelect: (i) => setState(() => _selectedIndex = i),
                      ),
                      _InfoPanel(
                        project: widget.project,
                        accent: widget.accent,
                        onContactTap: widget.onContactTap,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _GalleryPanel extends StatelessWidget {
  final List<String> images;
  final int selectedIndex;
  final Color accent;
  final ValueChanged<int> onSelect;

  const _GalleryPanel({
    required this.images,
    required this.selectedIndex,
    required this.accent,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: AdaptiveImage(
                source: images[selectedIndex],
                key: ValueKey(selectedIndex),
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: Container(color: const Color(0xFF111B2B)),
              ),
            ),
          ),
        ),
        if (images.length > 1)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(images.length, (i) {
                final selected = i == selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelect(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: selected ? accent : const Color(0xFF1A2535),
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: AdaptiveImage(
                          source: images[i],
                          fit: BoxFit.cover,
                          placeholder:
                              Container(color: const Color(0xFF111B2B)),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final ProjectItem project;
  final Color accent;
  final VoidCallback? onContactTap;

  const _InfoPanel({
    required this.project,
    required this.accent,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: accent.withValues(alpha: 0.4)),
                ),
                child: Text(
                  project.category,
                  style: GoogleFonts.sora(
                    color: accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close,
                    color: Colors.white38, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            project.title,
            style: GoogleFonts.sora(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFF1A2535)),
          const SizedBox(height: 16),
          Text(
            project.description,
            style: GoogleFonts.inter(
              color: const Color(0xFF8892A4),
              fontSize: 13,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContactTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Solicitar proyecto similar',
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
