import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:diabruta_about/diabruta_about.dart';
import 'package:url_launcher/url_launcher.dart';

const appName = 'DiabRuta';
const cityName = 'Oruro';
const countryName = 'Bolivia';
const logoAsset = 'assets/branding/logo.png';

const facebookUrl = 'https://facebook.com/angelhvm';
const instagramUrl = 'https://instagram.com/angelhvm_';
const tiktokUrl = 'https://www.tiktok.com/@angelhvm_';
const githubUrl = 'https://github.com/AngelVsm/DiabRutaAppOruro';

final whatsappSugerenciaUrl = Uri.https('wa.me', '/59173808629', {
  'text': 'Buenas 👋, quiero dejar una sugerencia para la app.',
}).toString();

const _red = Color(0xFFD01218);
const _redBright = Color(0xFFFF3B30);
const _gold = Color(0xFFE6A100);
const _goldBright = Color(0xFFFFC107);

ThemeData temaClaro() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _red,
    brightness: Brightness.light,
    primary: _red,
    onPrimary: Colors.white,
    secondary: _gold,
    onSecondary: const Color(0xFF2A1D00),
    surface: const Color(0xFFFFF8F6),
  );
  return ThemeData(colorScheme: scheme, useMaterial3: true);
}

ThemeData temaOscuro() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _red,
    brightness: Brightness.dark,
    primary: _redBright,
    onPrimary: const Color(0xFF2A0505),
    secondary: _goldBright,
    onSecondary: const Color(0xFF2A1D00),
    surface: const Color(0xFF121212),
  );
  return ThemeData(colorScheme: scheme, useMaterial3: true);
}

Widget logoApp({double tamano = 56}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(tamano * 0.22),
    child: Image.asset(logoAsset, width: tamano, height: tamano, fit: BoxFit.cover),
  );
}

class IconoTikTok extends StatelessWidget {
  const IconoTikTok({super.key});

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color ?? Colors.black;
    return SvgPicture.string(
      _tiktokSvg,
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

List<Widget> seccionesAcerca() {
  const estilo = TextStyle(height: 1.55);
  return [
    const AboutSectionCard(
      icon: Icons.route_rounded,
      iconColor: _red,
      title: 'Para qué la hice',
      child: Text(
        'Soy Angel Vargas y vivo en Oruro. Aquí no había una app para saber qué línea te lleva, y de esa falta nació DiabRuta. Eliges a dónde vas y te muestro el recorrido sobre el mapa, con las rutas de la ciudad que tengo cargadas.\n\nTodavía la estoy mejorando. Si una línea cambió de calle, si falta una parada o si el viaje que te propongo no es el que realmente se usa, cuéntamelo. Con eso corrijo la siguiente versión.',
        style: estilo,
      ),
    ),
    const AboutSectionCard(
      icon: Icons.school_rounded,
      iconColor: _gold,
      title: 'Quién soy',
      child: Text(
        'Estudio Ingeniería de Sistemas en la Universidad de Aquino Bolivia (UDABOL). Voy en séptimo semestre y me falta uno para culminar la carrera.\n\nDiabRuta es mi proyecto de Desarrollo de Aplicaciones Móviles II, con el Ing. Kevin Arroyo. No quise entregar una app pequeña solo para cumplir la materia. Estoy armando una herramienta que la gente de Oruro pueda usar de verdad.',
        style: estilo,
      ),
    ),
    AboutSectionCard(
      icon: Icons.code_rounded,
      iconColor: const Color(0xFF2E7D32),
      title: 'Código abierto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DiabRuta es de código abierto: se puede leer, compartir y mejorar. El mapa y el cálculo de rutas se apoyan en librerías libres, y su licencia se queda en la app. En Licencias está ese detalle.\n\nSi programas, puedes mirar el repositorio y proponer un cambio. Si solo quieres decirme que una ruta está mal, con WhatsApp me alcanza.',
            style: estilo,
          ),
          const SizedBox(height: 14),
          AboutLinkTile(
            icon: Icons.code_rounded,
            iconColor: const Color(0xFF2E7D32),
            title: 'GitHub',
            subtitle: 'AngelVsm/DiabRutaAppOruro',
            onTap: () => _abrir(githubUrl),
          ),
        ],
      ),
    ),
    AboutSectionCard(
      icon: Icons.alternate_email_rounded,
      iconColor: _red,
      title: 'Contacto',
      child: Column(
        children: [
          AboutLinkTile(
            icon: Icons.facebook_rounded,
            iconColor: const Color(0xFF1877F2),
            title: 'Facebook',
            subtitle: 'facebook.com/angelhvm',
            onTap: () => _abrir(facebookUrl),
          ),
          const SizedBox(height: 10),
          AboutLinkTile(
            icon: Icons.camera_alt_outlined,
            iconColor: const Color(0xFFE1306C),
            title: 'Instagram',
            subtitle: 'instagram.com/angelhvm_',
            onTap: () => _abrir(instagramUrl),
          ),
          const SizedBox(height: 10),
          AboutLinkTile(
            icon: Icons.music_note_rounded,
            iconColor: Colors.black,
            title: 'TikTok',
            subtitle: 'tiktok.com/@angelhvm_',
            onTap: () => _abrir(tiktokUrl),
          ),
          const SizedBox(height: 10),
          AboutLinkTile(
            icon: Icons.chat_rounded,
            iconColor: const Color(0xFF25D366),
            title: 'WhatsApp',
            subtitle: '+591 73808629',
            onTap: () => _abrir(whatsappSugerenciaUrl),
          ),
        ],
      ),
    ),
  ];
}

Future<void> _abrir(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

const _tiktokSvg =
    '<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path fill="currentColor" d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.63.41-1.11 1.04-1.36 1.75-.21.51-.15 1.07-.14 1.61.24 1.64 1.82 3.02 3.5 2.87 1.12-.01 2.19-.66 2.77-1.61.19-.33.4-.67.41-1.06.1-1.79.06-3.57.07-5.36.01-4.03-.01-8.05.02-12.07z"/></svg>';

