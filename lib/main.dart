import 'package:flutter/material.dart';
import 'package:flutter_portfolio/home_page.dart';
import 'package:get/get.dart';

import 'theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Abdul Raheem | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.bgOffWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.accentBlue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
