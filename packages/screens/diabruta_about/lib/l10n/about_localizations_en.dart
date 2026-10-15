// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'about_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AboutLocalizationsEn extends AboutLocalizations {
  AboutLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutCollapseContent =>
      'DiabRuta shows Oruro\'s routes. You pick where you are going and the app builds the trip with the lines stored in the phone.';

  @override
  String get aboutCollapseContentFoot =>
      'If a route is wrong, message me on WhatsApp.';

  @override
  String get aboutCollapseTitle => 'About DiabRuta';

  @override
  String get aboutContact => 'Contact';

  @override
  String aboutContent(String appName, String city) {
    return 'I am Angel Vargas. I made $appName because $city did not have an app to find which line to take. You pick a destination and I show the trip.';
  }

  @override
  String get aboutLicenses => 'Licenses';

  @override
  String get aboutOpenSource =>
      'This app is released as open source on GitHub. Feel free to contribute to the code, or bring an app to your own city.';

  @override
  String get aboutOpenSourceTitle => 'Open Source';

  @override
  String get aboutSendFeedback => 'Send us feedback';

  @override
  String get menuAbout => 'About us';

  @override
  String tagline(String city) {
    return 'Public transportation in $city';
  }

  @override
  String get diabrutaWebsite => 'DiabRuta on GitHub';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get volunteerDiabRuta => 'Open source';
}

