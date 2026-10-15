import '../entities/marker.dart';
import '../entities/line.dart';

/// Immutable data class representing a map layer with markers and lines.
///
/// Pass layers declaratively to [DiabRutaMap]:
/// ```dart
/// DiabRutaMap(
///   layers: [
///     DiabRutaLayer(id: 'route', markers: routeMarkers, lines: routeLines),
///     DiabRutaLayer(id: 'pois', markers: poiMarkers),
///   ],
/// )
/// ```
class DiabRutaLayer {
  const DiabRutaLayer({
    required this.id,
    this.markers = const [],
    this.lines = const [],
    this.visible = true,
    this.layerLevel = 1,
    this.parentId,
  });

  final String id;
  final List<DiabRutaMarker> markers;
  final List<DiabRutaLine> lines;
  final bool visible;
  final int layerLevel;

  /// Optional parent layer ID for hierarchical organization.
  final String? parentId;

  DiabRutaLayer copyWith({
    String? id,
    List<DiabRutaMarker>? markers,
    List<DiabRutaLine>? lines,
    bool? visible,
    int? layerLevel,
    String? parentId,
  }) =>
      DiabRutaLayer(
        id: id ?? this.id,
        markers: markers ?? this.markers,
        lines: lines ?? this.lines,
        visible: visible ?? this.visible,
        layerLevel: layerLevel ?? this.layerLevel,
        parentId: parentId ?? this.parentId,
      );
}

