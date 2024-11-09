import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/localization_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      fontSizeResolver: (fontSize, instance) => FontSizeResolvers.radius(fontSize, instance),
      // rebuildFactor: (_, __) => false,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Combined Flutter App',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    // Generate a light color scheme from a seed color
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.orangeAccent, // Change this to any color you want
      brightness: Brightness.light,
      contrastLevel: 0,
    );

    return ThemeData(
      useMaterial3: true, // Enable Material 3 design
      colorScheme: colorScheme, // Apply the generated color scheme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colorScheme.primary,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    // Generate a dark color scheme from the same seed color
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue, // Change this to any color you want
      brightness: Brightness.dark,
      contrastLevel: -0.9,
    );

    return ThemeData(
      useMaterial3: true, // Enable Material 3 design
      colorScheme: colorScheme, // Apply the generated color scheme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colorScheme.primary,
      ),
    );
  }
}
