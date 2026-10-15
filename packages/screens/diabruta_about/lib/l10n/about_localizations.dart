import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'about_localizations_en.dart';
import 'about_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AboutLocalizations
/// returned by `AboutLocalizations.of(context)`.
///
/// Applications need to include `AboutLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/about_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AboutLocalizations.localizationsDelegates,
///   supportedLocales: AboutLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AboutLocalizations.supportedLocales
/// property.
abstract class AboutLocalizations {
  AboutLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AboutLocalizations of(BuildContext context) {
    return Localizations.of<AboutLocalizations>(context, AboutLocalizations)!;
  }

  static const LocalizationsDelegate<AboutLocalizations> delegate =
      _AboutLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// A short marketing sentence that describes the app
  ///
  /// In en, this message translates to:
  /// **'DiabRuta shows Oruro\'s routes. You pick where you are going and the app builds the trip with the lines stored in the phone.'**
  String get aboutCollapseContent;

  /// Call to action for volunteers
  ///
  /// In en, this message translates to:
  /// **'If a route is wrong, message me on WhatsApp.'**
  String get aboutCollapseContentFoot;

  /// Title for expandable section about DiabRuta
  ///
  /// In en, this message translates to:
  /// **'About DiabRuta'**
  String get aboutCollapseTitle;

  /// Title for the contact section
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get aboutContact;

  /// Text displayed on the about page
  ///
  /// In en, this message translates to:
  /// **'I am Angel Vargas. I made {appName} because {city} did not have an app to find which line to take. You pick a destination and I show the trip.'**
  String aboutContent(String appName, String city);

  /// Button label to show licenses
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get aboutLicenses;

  /// A note about open source
  ///
  /// In en, this message translates to:
  /// **'This app is released as open source on GitHub. Feel free to contribute to the code, or bring an app to your own city.'**
  String get aboutOpenSource;

  /// Title for the open source section
  ///
  /// In en, this message translates to:
  /// **'Open Source'**
  String get aboutOpenSourceTitle;

  /// Subtitle for the contact email link
  ///
  /// In en, this message translates to:
  /// **'Send us feedback'**
  String get aboutSendFeedback;

  /// Menu item that shows the about page
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get menuAbout;

  /// A short marketing sentence that describes the app
  ///
  /// In en, this message translates to:
  /// **'Public transportation in {city}'**
  String tagline(String city);

  /// Link text to DiabRuta website
  ///
  /// In en, this message translates to:
  /// **'DiabRuta on GitHub'**
  String get diabrutaWebsite;

  /// The application's version
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// Link text to volunteer page
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get volunteerDiabRuta;
}

class _AboutLocalizationsDelegate
    extends LocalizationsDelegate<AboutLocalizations> {
  const _AboutLocalizationsDelegate();

  @override
  Future<AboutLocalizations> load(Locale locale) {
    return SynchronousFuture<AboutLocalizations>(
      lookupAboutLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AboutLocalizationsDelegate old) => false;
}

AboutLocalizations lookupAboutLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AboutLocalizationsEn();
    case 'es':
      return AboutLocalizationsEs();
  }

  throw FlutterError(
    'AboutLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

