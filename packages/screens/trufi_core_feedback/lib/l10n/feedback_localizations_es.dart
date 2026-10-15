// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'feedback_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class FeedbackLocalizationsEs extends FeedbackLocalizations {
  FeedbackLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get menuFeedback => 'Comentarios';

  @override
  String get feedbackTitle => '¡Nos encantaría saber de ti!';

  @override
  String get feedbackContent =>
      'Escríbeme por WhatsApp si falta una ruta, una parada está mal o tienes una idea para DiabRuta.';

  @override
  String get feedbackWhatWeWant => 'Qué nos gustaría saber';

  @override
  String get feedbackBugs => 'Errores o problemas que hayas encontrado';

  @override
  String get feedbackRoutes => 'Cambios de rutas o paradas faltantes';

  @override
  String get feedbackSuggestions => 'Ideas para mejorar la aplicación';

  @override
  String get feedbackSend => 'Escribir por WhatsApp';

  @override
  String get feedbackSubtitle => 'Tu opinión nos importa';
}
