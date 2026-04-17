import 'package:flutter/material.dart';

class ProjectItem {
  final String imageUrl;
  final String category;
  final String title;

  const ProjectItem({
    required this.imageUrl,
    required this.category,
    required this.title,
  });

  ProjectItem copyWith({String? imageUrl, String? category, String? title}) =>
      ProjectItem(
        imageUrl: imageUrl ?? this.imageUrl,
        category: category ?? this.category,
        title: title ?? this.title,
      );
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class SiteConfig {
  final String companyName;
  final String tagline;
  final String heroTitle;
  final String heroSubtitle;
  final String heroBackgroundImage;
  final Color accentColor;
  final List<ServiceItem> services;
  final List<ProjectItem> projects;
  final String phone;
  final String email;
  final String address;

  const SiteConfig({
    this.companyName = 'Segurify',
    this.tagline = 'TECNOLOGÍA DE VANGUARDIA',
    this.heroTitle = 'Protege lo que\nmás importa con Bits Technology',
    this.heroSubtitle =
        'Instalación profesional de sistemas de vigilancia para hogares y empresas. '
        'Seguridad inteligente, control total y monitoreo en tiempo real desde cualquier lugar.',
    this.heroBackgroundImage = 'assets/circuit.jpg',
    this.accentColor = const Color(0xFFFF6820),
    this.services = const [
      ServiceItem(
        icon: Icons.home_outlined,
        title: 'Instalación Residencial',
        description:
            'Protección perimetral y monitoreo interior para tu hogar con sistemas amigables y acceso móvil.',
      ),
      ServiceItem(
        icon: Icons.business_outlined,
        title: 'Seguridad Comercial',
        description:
            'Sistemas de alta resolución para oficinas, bodegas y tiendas con reconocimiento facial y analíticas.',
      ),
      ServiceItem(
        icon: Icons.support_agent_outlined,
        title: 'Mantenimiento y Soporte',
        description:
            'Planes de soporte preventivo y correctivo para asegurar que tu sistema nunca deje de grabar.',
      ),
    ],
    this.projects = const [
      ProjectItem(
        imageUrl:
            'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80',
        category: 'CORPORATIVO',
        title: 'Oficinas Global Tech Hub',
      ),
      ProjectItem(
        imageUrl:
            'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800&q=80',
        category: 'RESIDENCIAL',
        title: 'Residencia Vista Marina',
      ),
      ProjectItem(
        imageUrl:
            'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
        category: 'RETAIL',
        title: 'Boutique Elite',
      ),
      ProjectItem(
        imageUrl:
            'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&q=80',
        category: 'INDUSTRIAL',
        title: 'Logística Central',
      ),
    ],
    this.phone = '+502 4909 5105',
    this.email = 'contacto@segurify.com',
    this.address = 'San Miguel Petapa, Guatemala City, Guatemala',
  });

  SiteConfig copyWith({
    String? companyName,
    String? tagline,
    String? heroTitle,
    String? heroSubtitle,
    String? heroBackgroundImage,
    Color? accentColor,
    List<ServiceItem>? services,
    List<ProjectItem>? projects,
    String? phone,
    String? email,
    String? address,
  }) => SiteConfig(
    companyName: companyName ?? this.companyName,
    tagline: tagline ?? this.tagline,
    heroTitle: heroTitle ?? this.heroTitle,
    heroSubtitle: heroSubtitle ?? this.heroSubtitle,
    heroBackgroundImage: heroBackgroundImage ?? this.heroBackgroundImage,
    accentColor: accentColor ?? this.accentColor,
    services: services ?? this.services,
    projects: projects ?? this.projects,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    address: address ?? this.address,
  );
}
