// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'routing_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class RoutingLocalizationsEn extends RoutingLocalizations {
  RoutingLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get prefsWalkingSpeed => 'Walking speed';

  @override
  String get prefsSpeedSlow => 'Slow';

  @override
  String get prefsSpeedNormal => 'Normal';

  @override
  String get prefsSpeedFast => 'Fast';

  @override
  String get prefsMaxWalkDistance => 'Maximum walking distance';

  @override
  String get prefsNoLimit => 'No limit';

  @override
  String get prefsTransportModes => 'Transport modes';

  @override
  String get prefsModeTransit => 'Transit';

  @override
  String get prefsModeWalk => 'Walk';

  @override
  String get prefsModeBicycle => 'Bicycle';

  @override
  String get prefsWheelchairAccessible => 'Wheelchair accessible';

  @override
  String get prefsWheelchairOn => 'Routes avoid stairs and steep slopes';

  @override
  String get prefsWheelchairOff => 'Include all routes';

  @override
  String serviceActiveClosesAt(String time) {
    return 'Active · closes at $time';
  }

  @override
  String serviceClosedOpensAt(String time) {
    return 'Closed · opens at $time';
  }

  @override
  String serviceClosedOpensDayAt(String day, String time) {
    return 'Closed · opens $day at $time';
  }

  @override
  String get serviceClosed => 'Closed';

  @override
  String get serviceTomorrow => 'tomorrow';

  @override
  String get diabrutaPlannerLocalDescription =>
      'Finds routes using the data saved on your device.';

  @override
  String get diabrutaPlannerRemoteDescription =>
      'Finds routes through our own service. Needs a connection.';

  @override
  String get diabrutaPlannerInfoTitle => 'How routes are calculated';

  @override
  String get diabrutaPlannerInfoIntro =>
      'DiabRuta plans the trip with the Oruro lines stored in the app.';

  @override
  String get diabrutaPlannerInfoLocalBody =>
      'It does not call a route server. The map and place search do need internet. The trip comes from the file shipped inside the app.';

  @override
  String get diabrutaPlannerInfoRemoteBody =>
      'This variant would call a server. DiabRuta does not use it.';

  @override
  String get otpOnlineDescription =>
      'Finds routes through an online service. May have more up-to-date information.';

  @override
  String distanceKilometers(String value) {
    return '$value km';
  }

  @override
  String distanceMeters(String value) {
    return '$value m';
  }
}

