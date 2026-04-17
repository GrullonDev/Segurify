import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Segurify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        scaffoldBackgroundColor: const Color(0xFF070B12),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
