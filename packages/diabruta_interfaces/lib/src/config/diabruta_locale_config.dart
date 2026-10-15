import 'package:flutter/material.dart';

/// Locale configuration
class DiabRutaLocaleConfig {
  final List<Locale> supportedLocales;
  final int defaultLocaleIndex;

  /// Endonyms for languages beyond the ones diabruta-core knows, so the language
  /// picker shows e.g. "Runasimi" instead of the bare code "QU".
  final Map<String, String> languageNames;

  const DiabRutaLocaleConfig({
    this.supportedLocales = const [Locale('en'), Locale('es')],
    this.defaultLocaleIndex = 0,
    this.languageNames = const {},
  });

  Locale get defaultLocale => supportedLocales[defaultLocaleIndex];
}


