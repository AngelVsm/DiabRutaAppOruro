// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'routing_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class RoutingLocalizationsDe extends RoutingLocalizations {
  RoutingLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get prefsWalkingSpeed => 'Gehgeschwindigkeit';

  @override
  String get prefsSpeedSlow => 'Langsam';

  @override
  String get prefsSpeedNormal => 'Normal';

  @override
  String get prefsSpeedFast => 'Schnell';

  @override
  String get prefsMaxWalkDistance => 'Maximale Gehentfernung';

  @override
  String get prefsNoLimit => 'Kein Limit';

  @override
  String get prefsTransportModes => 'Verkehrsmittel';

  @override
  String get prefsModeTransit => 'ÖPNV';

  @override
  String get prefsModeWalk => 'Zu Fuß';

  @override
  String get prefsModeBicycle => 'Fahrrad';

  @override
  String get prefsWheelchairAccessible => 'Rollstuhlgerecht';

  @override
  String get prefsWheelchairOn => 'Routen vermeiden Treppen und steile Hänge';

  @override
  String get prefsWheelchairOff => 'Alle Routen einschließen';

  @override
  String serviceActiveClosesAt(String time) {
    return 'Aktiv · schließt um $time';
  }

  @override
  String serviceClosedOpensAt(String time) {
    return 'Geschlossen · öffnet um $time';
  }

  @override
  String serviceClosedOpensDayAt(String day, String time) {
    return 'Geschlossen · öffnet $day um $time';
  }

  @override
  String get serviceClosed => 'Geschlossen';

  @override
  String get serviceTomorrow => 'morgen';

  @override
  String get trufiPlannerLocalDescription =>
      'Findet Routen mit den auf deinem Gerät gespeicherten Daten.';

  @override
  String get trufiPlannerRemoteDescription =>
      'Findet Routen über unseren eigenen Dienst. Benötigt eine Verbindung.';

  @override
  String get trufiPlannerInfoTitle => 'So werden Routen berechnet';

  @override
  String get trufiPlannerInfoIntro =>
      'DiabRuta plant die Fahrt mit den in der App gespeicherten Linien von Oruro.';

  @override
  String get trufiPlannerInfoLocalBody =>
      'Es wird kein Routenserver abgefragt. Karte und Ortssuche brauchen Internet. Die Fahrt kommt aus der Datei in der App.';

  @override
  String get trufiPlannerInfoRemoteBody =>
      'Diese Variante würde einen Server fragen. DiabRuta nutzt sie nicht.';

  @override
  String get otpOnlineDescription =>
      'Findet Routen über einen Online-Dienst. Kann aktuellere Informationen haben.';

  @override
  String distanceKilometers(String value) {
    return '$value km';
  }

  @override
  String distanceMeters(String value) {
    return '$value m';
  }
}
