import 'package:flutter/material.dart';
import '../models/diabruta_latlng.dart';

/// Interface for map engines (MapLibre, FlutterMap, etc).
///
/// Implement this interface to create custom map engines that can be
/// used with diabruta_core map providers.
abstract class IDiabRutaMapEngine {
  /// Unique identifier for this engine
  String get id;

  /// Display name for UI
  String get name;

  /// Optional description
  String get description;

  /// Build the map widget
  Widget buildMap({
    required dynamic controller,
    void Function(DiabRutaLatLng)? onMapClick,
    void Function(DiabRutaLatLng)? onMapLongClick,
  });
}

/// Interface for map controller operations.
abstract class IDiabRutaMapController {
  /// Move the map to a specific location
  void move({
    required DiabRutaLatLng center,
    required double zoom,
    required TickerProvider tickerProvider,
  });

  /// Move the map to fit bounds containing all points
  void moveBounds({
    required List<DiabRutaLatLng> points,
    required TickerProvider tickerProvider,
  });

  /// Move to current bounds (crop)
  void moveCurrentBounds({required TickerProvider tickerProvider});

  /// Clean the map (remove markers, routes, etc)
  void cleanMap();
}

