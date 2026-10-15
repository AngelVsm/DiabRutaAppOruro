import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:diabruta_about/diabruta_about.dart';
import 'package:diabruta_fares/diabruta_fares.dart';
import 'package:diabruta_feedback/diabruta_feedback.dart';
import 'package:diabruta_home_screen/diabruta_home_screen.dart';
import 'package:diabruta_maps/diabruta_maps.dart';
import 'package:diabruta_navigation/diabruta_navigation.dart';
import 'package:diabruta_routing/diabruta_routing.dart'
    show
        RoutingEngineManager,
        IRoutingProvider,
        DiabRutaPlannerProvider,
        DiabRutaPlannerConfig;
import 'package:diabruta_saved_places/diabruta_saved_places.dart';
import 'package:diabruta_search_locations/diabruta_search_locations.dart';
import 'package:diabruta_settings/diabruta_settings.dart';
import 'package:diabruta_transport_list/diabruta_transport_list.dart';
import 'package:diabruta_ui/diabruta_ui.dart';
import 'package:diabruta_utils/diabruta_utils.dart' show OverlayManager;

import 'marca.dart';

String _esEn(BuildContext context, String es, String en) {
  final codigo = Localizations.localeOf(context).languageCode;
  return codigo == 'en' ? en : es;
}

// ============ CONFIGURATION ============
const _photonUrl = 'https://photon.komoot.io';
const _nominatimUrl = 'https://nominatim.openstreetmap.org';
const _geocoderUserAgent =
    'DiabRuta/1.0 (https://github.com/AngelVsm/DiabRutaAppOruro)';
const _defaultCenter = LatLng(-17.9604176, -67.1106498);
const _deepLinkScheme = 'diabruta';

// Rutas de Oruro, empaquetadas en la app. Los servidores OTP de ejemplo
// planifican otra ciudad y no se ofrecen.
final List<IRoutingProvider> _routingEngines = [
  DiabRutaPlannerProvider(
    config: const DiabRutaPlannerConfig.local(
      gtfsAsset: 'assets/routing/oruro.gtfs.zip',
      displayName: 'Rutas de Oruro',
    ),
  ),
];

// Estilos del mundo. Solo se descarga el sector visible.
final List<IDiabRutaMapEngine> _mapEngines = [
  MapLibreEngine(
    engineId: 'osm_bright',
    styleString: 'https://tiles.openfreemap.org/styles/bright',
    displayName: 'Claro',
    descriptionBuilder: (context) =>
        MapsLocalizations.of(context).mapStyleLightDescription,
  ),
  MapLibreEngine(
    engineId: 'osm_liberty',
    styleString: 'https://tiles.openfreemap.org/styles/liberty',
    displayName: 'Estándar',
    descriptionBuilder: (context) =>
        MapsLocalizations.of(context).mapStyleStandardDescription,
  ),
  MapLibreEngine(
    engineId: 'dark_matter',
    styleString: 'https://tiles.openfreemap.org/styles/dark',
    displayName: 'Oscuro',
    descriptionBuilder: (context) =>
        MapsLocalizations.of(context).mapStyleDarkDescription,
  ),
  MapLibreEngine(
    engineId: 'fiord_color',
    styleString: 'https://tiles.openfreemap.org/styles/fiord',
    displayName: 'Colorido',
    descriptionBuilder: (context) =>
        MapsLocalizations.of(context).mapStyleColorfulDescription,
  ),
];
// ========================================

void main() {
  runDiabRutaApp(
    AppConfiguration(
      appName: appName,
      deepLinkScheme: _deepLinkScheme,
      defaultLocale: const Locale('es'),
      localeConfig: const DiabRutaLocaleConfig(
        supportedLocales: [Locale('es'), Locale('en')],
      ),
      themeConfig: DiabRutaThemeConfig(
        theme: temaClaro(),
        darkTheme: temaOscuro(),
        themeMode: ThemeMode.system,
      ),
      logo: logoApp(),
      socialMediaLinks: [
        SocialMediaLink(
          url: facebookUrl,
          icon: SocialMediaPreset.facebook.icon,
          label: 'Facebook',
        ),
        SocialMediaLink(
          url: instagramUrl,
          icon: SocialMediaPreset.instagram.icon,
          label: 'Instagram',
        ),
        SocialMediaLink(
          url: tiktokUrl,
          icon: const IconoTikTok(),
          label: 'TikTok',
        ),
      ],
      overlayManager: OverlayManager(
        managers: [
          OnboardingManager(
            overlayBuilder: (onComplete) =>
                OnboardingSheet(onComplete: onComplete),
          ),
        ],
      ),
      providers: [
        ChangeNotifierProvider(
        create: (_) => MapEngineManager(
          engines: _mapEngines,
          defaultCenter: _defaultCenter,
          defaultIndex: 0,
        ),
        ),
        ChangeNotifierProvider(
          // 15, y no 5, para poder agrupar recorridos casi iguales
          // del cálculo local. La lista que se ve sigue siendo corta.
          create: (_) => RoutingEngineManager(
            engines: _routingEngines,
            maxItineraries: 15,
          ),
        ),
        BlocProvider(
          create: (_) => SearchLocationsCubit(
            searchLocationService: CompositeSearchLocationService(
              timeout: const Duration(seconds: 12),
              services: [
                NominatimSearchService(
                  baseUrl: _nominatimUrl,
                  userAgent: _geocoderUserAgent,
                  countryCodes: const ['bo'],
                  biasLatitude: _defaultCenter.latitude,
                  biasLongitude: _defaultCenter.longitude,
                  biasRadius: 0.25,
                ),
                PhotonSearchService(
                  baseUrl: _photonUrl,
                  biasLatitude: _defaultCenter.latitude,
                  biasLongitude: _defaultCenter.longitude,
                ),
              ],
            ),
          ),
        ),
      ],
      screens: [
        HomeScreenDiabRutaScreen(
          config: HomeScreenConfig(
            appName: appName,
            deepLinkScheme: _deepLinkScheme,
          ),
          onStartNavigation: (context, itinerary, locationService) {
            NavigationScreen.showFromItinerary(
              context,
              itinerary: itinerary,
              locationService: locationService,
              mapEngineManager: MapEngineManager.read(context),
            );
          },
          onRouteTap: (context, routeCode) {
            TransportDetailScreen.show(context, routeCode: routeCode);
          },
        ),
        SavedPlacesDiabRutaScreen(),
        TransportListDiabRutaScreen(),
        FaresDiabRutaScreen(
          config: FaresConfig(
            currency: 'Bs.',
            lastUpdated: DateTime(2025, 12, 26),
            externalFareUrl:
                'https://lapatria.bo/enfoque-nacional/alcaldia-de-oruro-fija-nuevas-tarifas-transitorias-para-el-transporte-urbano/',
            fares: [
              FareInfo(
                title: 'Minibús',
                titleBuilder: (context) => _esEn(context, 'Minibús', 'Minibus'),
                icon: Icons.directions_bus_filled,
                primary: FareCategory(
                  label: 'Adulto',
                  labelBuilder: (context) => _esEn(context, 'Adulto', 'Adult'),
                  price: '2.50',
                  icon: Icons.person_rounded,
                ),
                additional: [
                  FareCategory(
                    label: 'Adulto mayor',
                    labelBuilder: (context) =>
                        _esEn(context, 'Adulto mayor', 'Senior'),
                    price: '2.00',
                    icon: Icons.elderly_rounded,
                  ),
                ],
              ),
              FareInfo(
                title: 'Microbús',
                titleBuilder: (context) =>
                    _esEn(context, 'Microbús', 'Microbus'),
                icon: Icons.airport_shuttle,
                primary: FareCategory(
                  label: 'Adulto',
                  labelBuilder: (context) => _esEn(context, 'Adulto', 'Adult'),
                  price: '2.20',
                  icon: Icons.person_rounded,
                ),
                additional: [
                  FareCategory(
                    label: 'Adulto mayor',
                    labelBuilder: (context) =>
                        _esEn(context, 'Adulto mayor', 'Senior'),
                    price: '1.50',
                    icon: Icons.elderly_rounded,
                  ),
                  FareCategory(
                    label: 'Universitario',
                    labelBuilder: (context) =>
                        _esEn(context, 'Universitario', 'University student'),
                    price: '1.50',
                    icon: Icons.school_rounded,
                  ),
                  FareCategory(
                    label: 'Secundaria y escolar',
                    labelBuilder: (context) => _esEn(
                      context,
                      'Secundaria y escolar',
                      'Secondary and school',
                    ),
                    price: '1.00',
                    icon: Icons.school_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
        FeedbackDiabRutaScreen(
          config: FeedbackConfig(feedbackUrl: whatsappSugerenciaUrl),
        ),
        SettingsDiabRutaScreen(),
        AboutDiabRutaScreen(
          config: AboutScreenConfig(
            appName: appName,
            cityName: cityName,
            countryName: countryName,
            emailContact: facebookUrl,
            logoAssetPath: logoAsset,
            facebookUrl: facebookUrl,
            sections: seccionesAcerca(),
          ),
        ),
      ],
    ),
  );
}
