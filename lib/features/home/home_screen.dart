import 'package:flutter/material.dart';
import '../../config/site_config.dart';
import 'sections/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/services_section.dart';
import 'sections/portfolio_section.dart';
import 'sections/process_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'widgets/edit_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SiteConfig _config = const SiteConfig();
  bool _editOpen = false;

  final _heroKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _portfolioKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final sections = [
      (label: 'Sistemas', sectionKey: _servicesKey),
      (label: 'Instalación', sectionKey: _heroKey),
      (label: 'Portfolio', sectionKey: _portfolioKey),
      (label: 'Servicio', sectionKey: _contactKey),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF070B12),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                HeroSection(config: _config, sectionKey: _heroKey),
                ServicesSection(config: _config, sectionKey: _servicesKey),
                PortfolioSection(config: _config, sectionKey: _portfolioKey),
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
