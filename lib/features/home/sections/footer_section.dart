import 'package:flutter/material.dart';
import 'package:segurify/config/site_config.dart';
import 'package:segurify/core/design_system.dart';

class FooterSection extends StatelessWidget {
  final SiteConfig config;

  const FooterSection({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      color: DesignSystem.background,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isWide ? 80 : 24,
      ),
      child: Column(
        children: [
          const Divider(color: Colors.white10),
          const SizedBox(height: 48),
          if (isWide)
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      config.companyName.toUpperCase(),
                      style: DesignSystem.h3.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '© $year ${config.companyName}. Todos los derechos reservados.',
                      style: DesignSystem.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: _links(),
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  config.companyName.toUpperCase(),
                  style: DesignSystem.h3.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: _links(),
                ),
                const SizedBox(height: 32),
                Text(
                  '© $year ${config.companyName}. Todos los derechos reservados.',
                  style: DesignSystem.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        ],
      ),
    );
  }

  List<Widget> _links() {
    return ['PRIVACIDAD', 'TÉRMINOS', 'LICENCIA', 'SOPORTE']
        .map(
          (l) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              l,
              style: DesignSystem.label.copyWith(fontSize: 10),
            ),
          ),
        )
        .toList();
  }
}
