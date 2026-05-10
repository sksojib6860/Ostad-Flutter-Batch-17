import 'package:flutter/material.dart';
import 'package:view_profile_ui/presentations/screen/home_screen.dart';

import 'core/entities/theme.dart';

class ViewProfileApp extends StatelessWidget {
  const ViewProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
