import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import 'theme.dart';

class LulemeApp extends StatelessWidget {
  const LulemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '撸了么',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainPage(),
    );
  }
}
