import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;

import 'bounds.dart';

class DiabRutaCameraPosition {
  const DiabRutaCameraPosition({
    required this.target,
    this.zoom = 0.0,
    this.bearing = 0.0,
    this.viewportSize,
    this.visibleRegion,
  });

  final latlng.LatLng target;
  final double zoom;
  final double bearing;
  final Size? viewportSize;
  final LatLngBounds? visibleRegion;

  DiabRutaCameraPosition copyWith({
    latlng.LatLng? target,
    double? zoom,
    double? bearing,
    Size? viewportSize,
    LatLngBounds? visibleRegion,
  }) => DiabRutaCameraPosition(
    target: target ?? this.target,
    zoom: zoom ?? this.zoom,
    bearing: bearing ?? this.bearing,
    viewportSize: viewportSize ?? this.viewportSize,
    visibleRegion: visibleRegion ?? this.visibleRegion,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiabRutaCameraPosition &&
          target == other.target &&
          zoom == other.zoom &&
          bearing == other.bearing &&
          viewportSize == other.viewportSize &&
          visibleRegion == other.visibleRegion;

  @override
  int get hashCode =>
      Object.hash(target, zoom, bearing, viewportSize, visibleRegion);

  @override
  String toString() =>
      'DiabRutaCameraPosition('
      'target: ${target.latitude},${target.longitude}, '
      'zoom: $zoom, '
      'bearing: $bearing, '
      'viewportSize: $viewportSize, '
      'visibleRegion: $visibleRegion)';
}


