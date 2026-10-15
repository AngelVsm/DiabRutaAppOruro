// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'about_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AboutLocalizationsEs extends AboutLocalizations {
  AboutLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get aboutCollapseContent =>
      'DiabRuta muestra las rutas de Oruro. Eliges a dónde vas y la app arma el recorrido con las líneas que tengo cargadas.';

  @override
  String get aboutCollapseContentFoot =>
      'Si una ruta está mal, escríbeme por WhatsApp.';

  @override
  String get aboutCollapseTitle => 'Sobre DiabRuta';

  @override
  String get aboutContact => 'Contacto';

  @override
  String aboutContent(String appName, String city) {
    return 'Soy Angel Vargas. Hice $appName porque en $city no había una app para saber qué línea tomar. Eliges el destino y te muestro el recorrido.';
  }

  @override
  String get aboutLicenses => 'Licencias';

  @override
  String get aboutOpenSource =>
      'Esta aplicación está publicada como código abierto en GitHub. Siéntase libre de contribuir o utilizarlo para su propia ciudad.';

  @override
  String get aboutOpenSourceTitle => 'Código abierto';

  @override
  String get aboutSendFeedback => 'Envíanos tus comentarios';

  @override
  String get menuAbout => 'Sobre nosotros';

  @override
  String tagline(String city) {
    return 'Transporte público en $city';
  }

  @override
  String get diabrutaWebsite => 'GitHub de DiabRuta';

  @override
  String version(String version) {
    return 'Versión $version';
  }

  @override
  String get volunteerDiabRuta => 'Código abierto';
}
