import 'package:flutter/material.dart';
import 'package:segurify/features/begin.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const Begin(title: 'Flutter Demo Home Page'),
    );
  }
}
