import 'package:flutter/material.dart';

class ProjectItem {
  final String imageUrl;
  final String category;
  final String title;
  final String description;
  final List<String> gallery;

  const ProjectItem({
    required this.imageUrl,
    required this.category,
    required this.title,
    this.description = '',
    this.gallery = const [],
  });

  ProjectItem copyWith({
    String? imageUrl,
    String? category,
    String? title,
    String? description,
    List<String>? gallery,
  }) => ProjectItem(
    imageUrl: imageUrl ?? this.imageUrl,
    category: category ?? this.category,
    title: title ?? this.title,
    description: description ?? this.description,
    gallery: gallery ?? this.gallery,
  );
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;
  final String detailDescription;
  final List<String> features;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
    this.detailDescription = '',
    this.features = const [],
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
        detailDescription:
            'Diseñamos e instalamos sistemas de vigilancia completos para tu hogar, '
            'combinando cámaras de alta definición, sensores de movimiento y control '
            'remoto desde tu smartphone. Todo configurado para ser simple de usar y difícil de evadir.',
        features: [
          'Cámaras 4K con visión nocturna hasta 30 m',
          'Grabación 24/7 en la nube y almacenamiento local',
          'Alertas en tiempo real a tu celular',
          'Acceso remoto desde cualquier dispositivo',
          'Instalación certificada con garantía de 1 año',
          'Integración con asistentes de voz (Alexa / Google)',
        ],
      ),
      ServiceItem(
        icon: Icons.business_outlined,
        title: 'Seguridad Comercial',
        description:
            'Sistemas de alta resolución para oficinas, bodegas y tiendas con reconocimiento facial y analíticas.',
        detailDescription:
            'Soluciones escalables de videovigilancia para negocios de cualquier tamaño. '
            'Desde una tienda hasta un complejo industrial, diseñamos arquitecturas de '
            'seguridad que protegen activos, reducen pérdidas y mejoran la operación.',
        features: [
          'Reconocimiento facial e inteligencia artificial',
          'Analíticas de conteo de personas y zonas de calor',
          'Integración con sistemas de control de acceso',
          'Monitoreo centralizado multisite',
          'Cámaras PTZ con zoom óptico 20x',
          'Reportes automáticos e historial de incidentes',
        ],
      ),
      ServiceItem(
        icon: Icons.support_agent_outlined,
        title: 'Mantenimiento y Soporte',
        description:
            'Planes de soporte preventivo y correctivo para asegurar que tu sistema nunca deje de grabar.',
        detailDescription:
            'Tu sistema de seguridad debe funcionar el 100% del tiempo. '
            'Ofrecemos planes de mantenimiento preventivo y soporte correctivo prioritario '
            'para garantizar que tus cámaras, grabadores y red operen sin interrupciones.',
        features: [
          'Revisión y limpieza trimestral de equipos',
          'Actualización de firmware y software',
          'Soporte técnico remoto en menos de 2 horas',
          'Visita técnica presencial prioritaria',
          'Reemplazo de piezas con stock garantizado',
          'Informe detallado de estado del sistema',
        ],
      ),
    ],
    this.projects = const [
      // ── CORPORATIVO ────────────────────────────────────────────────────────
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80',
        category: 'CORPORATIVO',
        title: 'Oficinas Global Tech Hub',
        description:
            'Implementación de 48 cámaras PTZ de alta resolución con reconocimiento facial '
            'y analíticas de comportamiento en un complejo de oficinas de 12 pisos. '
            'Sistema integrado con control de acceso y monitoreo centralizado 24/7.',
        gallery: [
          'https://images.unsplash.com/photo-1497366216548-37526070297c?w=1200&q=80',
          'https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=1200&q=80',
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=1200&q=80',
          'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?w=800&q=80',
        category: 'CORPORATIVO',
        title: 'Torre Empresarial Centroamérica',
        description:
            'Vigilancia perimetral y de pasillos para torre de 20 plantas con '
            '120 cámaras IP integradas al sistema BMS del edificio, acceso biométrico '
            'en cada piso y sala de monitoreo dedicada con operadores en turnos rotativos.',
        gallery: [
          'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?w=1200&q=80',
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&q=80',
          'https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=1200&q=80',
          'https://images.unsplash.com/photo-1554469384-e58fac16e23a?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=800&q=80',
        category: 'CORPORATIVO',
        title: 'Campus Universitario Norte',
        description:
            'Proyecto integral para campus universitario: 200 cámaras distribuidas en '
            'aulas, laboratorios, estacionamientos y zonas comunes. Panel de control '
            'centralizado con alertas automáticas ante eventos anómalos.',
        gallery: [
          'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=1200&q=80',
          'https://images.unsplash.com/photo-1562774053-701939374585?w=1200&q=80',
          'https://images.unsplash.com/photo-1607237138185-eedd9c632b0b?w=1200&q=80',
          'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?w=1200&q=80',
        ],
      ),
      // ── RESIDENCIAL ────────────────────────────────────────────────────────
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800&q=80',
        category: 'RESIDENCIAL',
        title: 'Residencia Vista Marina',
        description:
            'Residencia de lujo con sistema perimetral inteligente: cámaras 4K con visión '
            'nocturna a color, sensores de movimiento de largo alcance, video-portero IP '
            'y acceso móvil desde cualquier parte del mundo.',
        gallery: [
          'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=1200&q=80',
          'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1200&q=80',
          'https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?w=1200&q=80',
          'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&q=80',
        category: 'RESIDENCIAL',
        title: 'Condominio Las Palmas',
        description:
            'Sistema de seguridad para condominio de 80 unidades con cámaras en '
            'áreas comunes, piscina, estacionamiento y accesos. App personalizada '
            'para vecinos con alertas y visualización en tiempo real.',
        gallery: [
          'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200&q=80',
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1200&q=80',
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200&q=80',
          'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800&q=80',
        category: 'RESIDENCIAL',
        title: 'Residencial El Roble',
        description:
            'Proyecto de vigilancia para comunidad privada de 35 casas: caseta de '
            'seguridad con pantallas de monitoreo, cámaras en cada acceso vehicular '
            'y peatonal, e intercomunicador central.',
        gallery: [
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=1200&q=80',
          'https://images.unsplash.com/photo-1416331108676-a22ccb276e35?w=1200&q=80',
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=80',
          'https://images.unsplash.com/photo-1575517111839-3a3843ee7f5d?w=1200&q=80',
        ],
      ),
      // ── RETAIL ────────────────────────────────────────────────────────────
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
        category: 'RETAIL',
        title: 'Boutique Elite',
        description:
            'Sistema de videovigilancia para cadena de tiendas con análisis de flujo de '
            'clientes, prevención de pérdidas mediante IA y alertas en tiempo real. '
            'Cámaras discretas de alto diseño integradas al entorno comercial.',
        gallery: [
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&q=80',
          'https://images.unsplash.com/photo-1528698827591-e19ccd7bc23d?w=1200&q=80',
          'https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?w=1200&q=80',
          'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1601924638867-3a6de6b7a500?w=800&q=80',
        category: 'RETAIL',
        title: 'Supermercado FreshMart',
        description:
            'Red de 60 cámaras para supermercado con analíticas de comportamiento, '
            'mapas de calor por zona, integración con cajas registradoras y '
            'sistema antirrobo en estantes inteligentes.',
        gallery: [
          'https://images.unsplash.com/photo-1601924638867-3a6de6b7a500?w=1200&q=80',
          'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=1200&q=80',
          'https://images.unsplash.com/photo-1542838132-92c53300491e?w=1200&q=80',
          'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&q=80',
        category: 'RETAIL',
        title: 'Restaurante Cadena Sabor GT',
        description:
            'Instalación en 8 sucursales con cámaras en cocina, salón, caja y '
            'estacionamiento. Sistema unificado de monitoreo remoto para que la gerencia '
            'supervise todas las ubicaciones desde una sola plataforma.',
        gallery: [
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=1200&q=80',
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=1200&q=80',
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200&q=80',
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=1200&q=80',
        ],
      ),
      // ── INDUSTRIAL ─────────────────────────────────────────────────────────
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=800&q=80',
        category: 'INDUSTRIAL',
        title: 'Logística Central',
        description:
            'Solución de seguridad para bodega industrial de 15,000 m² con cobertura '
            'total mediante cámaras térmicas, drones de patrullaje automatizado y '
            'sistema de control de acceso vehicular con reconocimiento de placas.',
        gallery: [
          'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?w=1200&q=80',
          'https://images.unsplash.com/photo-1553413077-190dd305871c?w=1200&q=80',
          'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?w=1200&q=80',
          'https://images.unsplash.com/photo-1568992688065-536aad8a12f6?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1565793298595-6a879b1d9492?w=800&q=80',
        category: 'INDUSTRIAL',
        title: 'Planta Manufactura ProTech',
        description:
            'Vigilancia de planta de manufactura con cámaras resistentes a polvo y '
            'vibraciones, monitoreo de líneas de producción, control de acceso a '
            'áreas restringidas y alarmas integradas al sistema SCADA.',
        gallery: [
          'https://images.unsplash.com/photo-1565793298595-6a879b1d9492?w=1200&q=80',
          'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=1200&q=80',
          'https://images.unsplash.com/photo-1518770660439-4636190af475?w=1200&q=80',
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=80',
        ],
      ),
      ProjectItem(
        imageUrl: 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=800&q=80',
        category: 'INDUSTRIAL',
        title: 'Aeropuerto Zona Cargo',
        description:
            'Sistema de seguridad perimetral para zona de carga aérea: cámaras térmicas '
            'de largo alcance, reconocimiento de placas vehiculares, control de acceso '
            'biométrico y sala de crisis con monitoreo en tiempo real.',
        gallery: [
          'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=1200&q=80',
          'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=1200&q=80',
          'https://images.unsplash.com/photo-1578575437130-527eed3abbec?w=1200&q=80',
          'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=1200&q=80',
        ],
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
