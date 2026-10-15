// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'fares_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class FaresLocalizationsEs extends FaresLocalizations {
  FaresLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get menuFares => 'Tarifas';

  @override
  String get faresTitle => 'Información de Tarifas';

  @override
  String get faresSubtitle =>
      'Decreto Municipal N.° 408, del 26 de diciembre de 2025. Tarifas transitorias por 6 meses.';

  @override
  String faresLastUpdated(String date) {
    return 'Última actualización: $date';
  }

  @override
  String get faresMoreInfo => 'Más Información';

  @override
  String get faresTips => 'Consejos';

  @override
  String get fareCategoryRegular => 'Regular';

  @override
  String get fareCategoryStudent => 'Estudiante';

  @override
  String get fareCategorySenior => 'Adulto mayor';
}
