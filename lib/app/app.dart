import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/extensions/navigation_on_string/navigation_on_string.dart';
import '../config/localization_config.dart';
import 'app_route_paths.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.to.navigate(AppRoutePaths.chartsPath.toNavigation);

    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      fontSizeResolver: (fontSize, instance) => FontSizeResolvers.radius(fontSize, instance),
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
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.orangeAccent,
      brightness: Brightness.light,
      contrastLevel: 0,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
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
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
      contrastLevel: -0.9,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
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
