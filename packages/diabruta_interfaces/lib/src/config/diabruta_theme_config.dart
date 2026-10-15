import 'package:flutter/material.dart';

/// Theme configuration
class DiabRutaThemeConfig {
  final ThemeData? _theme;
  final ThemeData? _darkTheme;
  final ThemeMode themeMode;

  const DiabRutaThemeConfig({
    ThemeData? theme,
    ThemeData? darkTheme,
    this.themeMode = ThemeMode.system,
  }) : _theme = theme,
       _darkTheme = darkTheme;

  ThemeData get theme =>
      _theme ??
      ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      );

  ThemeData get darkTheme =>
      _darkTheme ??
      ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );
}


