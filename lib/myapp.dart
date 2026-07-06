import 'package:flutter/material.dart';

import 'home/home_page.dart';

/// The root application widget, configuring high-quality Material 3 themes,
/// adaptive light/dark color palettes, and global widget specifications.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Space',
      debugShowCheckedModeBanner: false,

      // Professional Light Theme
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFF8FAFC,
        ), // Elegant light slate background
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5), // Indigo seed
          brightness: Brightness.light,
          primary: const Color(0xFF4F46E5),
          secondary: const Color(0xFF0D9488), // Teal accent
          surface: Colors.white,
        ),
        cardTheme: const CardThemeData(elevation: 0.5, margin: EdgeInsets.zero),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),

      // Professional Dark Theme (OLED / Slate design)
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFF0B0F19,
        ), // Midnight dark background
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Soft Indigo seed
          brightness: Brightness.dark,
          primary: const Color(0xFF818CF8),
          secondary: const Color(0xFF2DD4BF), // Soft Teal
          surface: const Color(0xFF151C2C), // Slate dark card background
        ),
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),

      // Adaptive system mode
      themeMode: ThemeMode.system,

      home: const HomePage(),
    );
  }
}
