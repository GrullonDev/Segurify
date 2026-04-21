import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';
import 'package:segurify/features/home/sections/nav_bar.dart';
import 'package:segurify/features/home/sections/hero_section.dart';
import 'package:segurify/features/home/sections/services_section.dart';
import 'package:segurify/features/home/sections/portfolio_section.dart';
import 'package:segurify/features/home/sections/process_section.dart';
import 'package:segurify/features/home/sections/contact_section.dart';
import 'package:segurify/features/home/sections/footer_section.dart';
import 'package:segurify/features/home/widgets/edit_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SiteConfig _config = const SiteConfig();
  bool _editOpen = false;
  bool _showBackToTop = false;

  final _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _portfolioKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 400;
      if (show != _showBackToTop) setState(() => _showBackToTop = show);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      (label: 'Sistemas', sectionKey: _servicesKey),
      (label: 'Instalación', sectionKey: _heroKey),
      (label: 'Portfolio', sectionKey: _portfolioKey),
      (label: 'Servicio', sectionKey: _contactKey),
    ];

    return Scaffold(
      backgroundColor: DesignSystem.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 70),
                HeroSection(
                  config: _config,
                  sectionKey: _heroKey,
                  onCotizaTap: () => _scrollTo(_contactKey),
                  onVerSistemasTap: () => _scrollTo(_servicesKey),
                ),
                ServicesSection(
                  config: _config,
                  sectionKey: _servicesKey,
                  onContactTap: () => _scrollTo(_contactKey),
                ),
                PortfolioSection(
                  config: _config,
                  sectionKey: _portfolioKey,
                  onContactTap: () => _scrollTo(_contactKey),
                ),
                ProcessSection(config: _config),
                ContactSection(config: _config, sectionKey: _contactKey),
                FooterSection(config: _config),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              config: _config,
              sections: sections,
              onEditTap: () => setState(() => _editOpen = !_editOpen),
              onCotizaTap: () => _scrollTo(_contactKey),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            bottom: _showBackToTop ? 32 : -100,
            right: 32,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showBackToTop ? 1.0 : 0.0,
              child: FloatingActionButton.small(
                onPressed: _scrollToTop,
                backgroundColor: DesignSystem.accent,
                child: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
              ).animate().scale(),
            ),
          ),
          if (_editOpen)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: EditPanel(
                config: _config,
                onConfigChanged: (updated) =>
                    setState(() => _config = updated),
                onClose: () => setState(() => _editOpen = false),
              ),
            ),
        ],
      ),
    );
  }
}
