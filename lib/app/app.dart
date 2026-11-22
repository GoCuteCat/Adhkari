
import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

class AdhkariApp extends StatelessWidget {
  const AdhkariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'أذكاري',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          home: const AppNavigation(),
        );
      },
    );
  }
}
