import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../l10n/maps_localizations.dart';
import '../../domain/controller/map_controller.dart';
import '../../domain/entities/camera.dart';
import '../../domain/entities/widget_marker.dart';
import '../../domain/layers/diabruta_layer.dart';
import '../../presentation/map/diabruta_map.dart';
import 'diabruta_map_engine.dart';

/// MapLibre GL engine implementation.
///
/// Provides vector map rendering with modern styling and better performance.
///
/// Example:
/// ```dart
/// MapLibreEngine(
///   engineId: 'maplibre_liberty',
///   styleString: 'https://tiles.openfreemap.org/styles/liberty',
///   displayName: 'Liberty',
/// )
/// ```
class MapLibreEngine implements IDiabRutaMapEngine {
  final String styleString;
  final String? engineId;
  final String? displayName;
  final String? displayDescription;
  final LocalizedStringBuilder? nameBuilder;
  final LocalizedStringBuilder? descriptionBuilder;
  final Widget? preview;

  const MapLibreEngine({
    required this.styleString,
    this.engineId,
    this.displayName,
    this.displayDescription,
    this.nameBuilder,
    this.descriptionBuilder,
    this.preview,
  });

  @override
  String get id => engineId ?? 'maplibre';

  @override
  String get name => displayName ?? 'Vector (MapLibre)';

  @override
  String get description =>
      displayDescription ??
      'Vector map with modern styling and better performance';

  @override
  String localizedName(BuildContext context) =>
      nameBuilder?.call(context) ??
      displayName ??
      MapsLocalizations.of(context).vectorMapName;

  @override
  String localizedDescription(BuildContext context) =>
      descriptionBuilder?.call(context) ??
      displayDescription ??
      MapsLocalizations.of(context).vectorMapDescription;

  @override
  Widget? get previewWidget =>
      preview ??
      Container(
        color: Colors.blue.shade100,
        child: const Center(
          child: Icon(Icons.map, size: 40, color: Colors.blue),
        ),
      );

  @override
  Future<void> initialize() async {}

  @override
  Widget buildMap({
    DiabRutaMapController? controller,
    required DiabRutaCameraPosition initialCamera,
    DiabRutaCameraPosition? camera,
    ValueChanged<DiabRutaCameraPosition>? onCameraChanged,
    void Function(LatLng)? onMapClick,
    void Function(LatLng)? onMapLongClick,
    List<DiabRutaLayer> layers = const [],
    List<WidgetMarker> widgetMarkers = const [],
  }) {
    return DiabRutaMap(
      key: ValueKey(id),
      controller: controller,
      initialCamera: initialCamera,
      camera: camera,
      styleString: styleString,
      onCameraChanged: onCameraChanged,
      onMapClick: onMapClick,
      onMapLongClick: onMapLongClick,
      layers: layers,
      widgetMarkers: widgetMarkers,
    );
  }
}

