import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../entities/bounds.dart';
import '../entities/camera.dart';
import '../entities/marker.dart';

/// Lightweight controller for imperative map operations.
///
/// Provides programmatic access to camera control and marker picking.
/// Data (layers, markers) is passed declaratively to [DiabRutaMap], not
/// through this controller.
///
/// ```dart
/// final controller = DiabRutaMapController();
///
/// DiabRutaMap(
///   controller: controller,
///   layers: [...],
/// )
///
/// // Later: programmatic camera control
/// controller.moveCamera(DiabRutaCameraPosition(target: latLng, zoom: 14));
/// controller.fitBounds(bounds);
/// ```
class DiabRutaMapController {
  DiabRutaMapDelegate? _delegate;

  /// Called by [DiabRutaMap] to bind its state. Do not call directly.
  void attach(DiabRutaMapDelegate delegate) => _delegate = delegate;

  /// Called by [DiabRutaMap] to unbind its state. Do not call directly.
  ///
  /// Guarded on purpose: when the map engine changes, Flutter builds the
  /// new map (which attaches) *before* disposing the old one (which
  /// detaches). An unconditional detach therefore left the controller
  /// bound to nothing for the rest of the screen's life — silently
  /// killing every controller-driven action after a style switch
  /// (camera moves, marker picking). Only the delegate currently bound
  /// may unbind itself.
  void detach(DiabRutaMapDelegate delegate) {
    if (identical(_delegate, delegate)) _delegate = null;
  }

  /// Current camera position, or null if the map is not yet ready.
  DiabRutaCameraPosition? get cameraPosition => _delegate?.cameraPosition;

  /// Move the camera to the given position.
  void moveCamera(DiabRutaCameraPosition position) {
    _delegate?.moveCamera(position);
  }

  /// Fit the camera to show the given bounds.
  void fitBounds(
    LatLngBounds bounds, {
    EdgeInsets padding = EdgeInsets.zero,
    double minZoom = 2.0,
    double maxZoom = 20.0,
  }) {
    _delegate?.fitBounds(
      bounds,
      padding: padding,
      minZoom: minZoom,
      maxZoom: maxZoom,
    );
  }

  /// Pick markers near a tap point.
  List<DiabRutaMarker> pickMarkersAt(
    latlng.LatLng tap, {
    double hitboxPx = 24.0,
    int? perLayerLimit,
    int? globalLimit,
  }) {
    return _delegate?.pickMarkersAt(
          tap,
          hitboxPx: hitboxPx,
          perLayerLimit: perLayerLimit,
          globalLimit: globalLimit,
        ) ??
        const [];
  }

  /// Pick the nearest marker to a tap point.
  DiabRutaMarker? pickNearestMarkerAt(
    latlng.LatLng tap, {
    double hitboxPx = 24.0,
  }) {
    final picks = pickMarkersAt(tap, hitboxPx: hitboxPx, globalLimit: 1);
    return picks.isEmpty ? null : picks.first;
  }
}

/// Internal delegate interface implemented by the map widget state.
abstract class DiabRutaMapDelegate {
  DiabRutaCameraPosition get cameraPosition;
  void moveCamera(DiabRutaCameraPosition position);
  void fitBounds(
    LatLngBounds bounds, {
    EdgeInsets padding,
    double minZoom,
    double maxZoom,
  });
  List<DiabRutaMarker> pickMarkersAt(
    latlng.LatLng tap, {
    double hitboxPx,
    int? perLayerLimit,
    int? globalLimit,
  });
}

/// Utility: convert pixel hitbox to meters at a given zoom/latitude.
double hitboxPxToMeters({
  required double centerLatDeg,
  required double zoomMapLibre,
  required double hitboxPx,
}) {
  const earthCircumference = 40075016.68557849;
  final metersPerPixel =
      (earthCircumference * math.cos(centerLatDeg * math.pi / 180.0)) /
      (256.0 * math.pow(2.0, zoomMapLibre));
  return metersPerPixel * (hitboxPx * 0.5);
}


