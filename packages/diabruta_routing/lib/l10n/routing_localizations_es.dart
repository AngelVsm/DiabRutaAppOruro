// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'routing_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class RoutingLocalizationsEs extends RoutingLocalizations {
  RoutingLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get prefsWalkingSpeed => 'Velocidad de caminata';

  @override
  String get prefsSpeedSlow => 'Lento';

  @override
  String get prefsSpeedNormal => 'Normal';

  @override
  String get prefsSpeedFast => 'Rápido';

  @override
  String get prefsMaxWalkDistance => 'Distancia máxima de caminata';

  @override
  String get prefsNoLimit => 'Sin límite';

  @override
  String get prefsTransportModes => 'Modos de transporte';

  @override
  String get prefsModeTransit => 'Tránsito';

  @override
  String get prefsModeWalk => 'A pie';

  @override
  String get prefsModeBicycle => 'Bicicleta';

  @override
  String get prefsWheelchairAccessible => 'Accesible en silla de ruedas';

  @override
  String get prefsWheelchairOn =>
      'Las rutas evitan escaleras y pendientes pronunciadas';

  @override
  String get prefsWheelchairOff => 'Incluir todas las rutas';

  @override
  String serviceActiveClosesAt(String time) {
    return 'Activo · cierra a las $time';
  }

  @override
  String serviceClosedOpensAt(String time) {
    return 'Cerrado · abre a las $time';
  }

  @override
  String serviceClosedOpensDayAt(String day, String time) {
    return 'Cerrado · abre $day a las $time';
  }

  @override
  String get serviceClosed => 'Cerrado';

  @override
  String get serviceTomorrow => 'mañana';

  @override
  String get diabrutaPlannerLocalDescription =>
      'Busca rutas usando los datos guardados en tu dispositivo.';

  @override
  String get diabrutaPlannerRemoteDescription =>
      'Busca rutas con nuestro propio servicio. Necesita conexión.';

  @override
  String get diabrutaPlannerInfoTitle => 'Cómo se calculan las rutas';

  @override
  String get diabrutaPlannerInfoIntro =>
      'DiabRuta arma el viaje con las líneas de Oruro guardadas en la app.';

  @override
  String get diabrutaPlannerInfoLocalBody =>
      'No consulta un servidor de rutas. El mapa y la búsqueda de lugares sí necesitan internet. El recorrido sale del archivo que va dentro de la app.';

  @override
  String get diabrutaPlannerInfoRemoteBody =>
      'Esta variante consultaría un servidor. DiabRuta no la usa.';

  @override
  String get otpOnlineDescription =>
      'Busca rutas mediante un servicio en línea. Puede tener información más actualizada.';

  @override
  String distanceKilometers(String value) {
    return '$value km';
  }

  @override
  String distanceMeters(String value) {
    return '$value m';
  }
}
