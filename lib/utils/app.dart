import 'package:flutter/material.dart';
import 'package:segurify/core/design_system.dart';
import 'package:segurify/features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Segurify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: DesignSystem.accent,
          brightness: Brightness.dark,
          surface: DesignSystem.background,
        ),
        scaffoldBackgroundColor: DesignSystem.background,
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: DesignSystem.h1,
          displayMedium: DesignSystem.h2,
          displaySmall: DesignSystem.h3,
          bodyLarge: DesignSystem.bodyLarge,
          bodyMedium: DesignSystem.bodyMedium,
          bodySmall: DesignSystem.bodySmall,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
