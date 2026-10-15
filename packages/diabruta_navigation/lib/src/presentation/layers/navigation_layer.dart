import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:diabruta_maps/diabruta_maps.dart';
import 'package:diabruta_utils/diabruta_utils.dart';

import '../../models/navigation_state.dart';

/// Degrees clockwise from north along the route, looking a short distance
/// ahead of [user] so a sharp corner does not spin the map on every point.
double? routeHeadingDegrees(LatLng user, List<LatLng> points) {
  if (points.length < 2) return null;
  const distance = Distance();
  var closest = 0;
  var min = double.infinity;
  for (var i = 0; i < points.length; i++) {
    final meters = distance.as(LengthUnit.Meter, user, points[i]);
    if (meters < min) {
      min = meters;
      closest = i;
    }
  }

  var ahead = closest;
  var walked = 0.0;
  while (ahead < points.length - 1 && walked < 40) {
    walked += distance.as(LengthUnit.Meter, points[ahead], points[ahead + 1]);
    ahead++;
  }
  if (ahead == closest) return null;
  final bearing = distance.bearing(points[closest], points[ahead]);
  return bearing < 0 ? bearing + 360 : bearing;
}

/// Produces navigation markers and lines for the map.
///
/// Unlike the old API this is a plain helper class — it does not extend
/// [DiabRutaLayer].  Call [buildLayerData] and pass the result into a
/// [DiabRutaLayer] data object that you hand to `buildMap(layers: ...)`.
class NavigationLayer {
  /// The layer id consumers should use when wrapping the output in a
  /// [DiabRutaLayer].
  static const layerId = 'navigation';

  /// Build markers, lines, and an optional camera position for the given
  /// navigation [state].
  ///
  /// Returns a record with `markers`, `lines` and an optional
  /// `cameraPosition` that the caller can feed to `buildMap`.
  ({
    List<DiabRutaMarker> markers,
    List<DiabRutaLine> lines,
    DiabRutaCameraPosition? cameraPosition,
  })
  buildLayerData(NavigationState state) {
    final markers = <DiabRutaMarker>[];
    final lines = <DiabRutaLine>[];

    final route = state.route;
    if (route == null || route.geometry.isEmpty) {
      return (markers: markers, lines: lines, cameraPosition: null);
    }

    final currentStopIndex = state.currentStopIndex;

    // Get user position if available
    final userPosition = state.currentLocation != null
        ? LatLng(
            state.currentLocation!.latitude,
            state.currentLocation!.longitude,
          )
        : null;

    // Determine current leg index based on user position
    final currentLegIndex = route.legs.isNotEmpty
        ? _getCurrentLegIndex(route, currentStopIndex, userPosition)
        : 0;

    // Build route lines
    _buildRouteLinesWithProgress(
      route,
      currentLegIndex,
      currentStopIndex,
      userPosition,
      markers,
      lines,
    );

    // Build user location marker
    _buildUserLocation(state, markers);

    // Compute camera position to follow user if enabled
    DiabRutaCameraPosition? cameraPosition;
    if (state.isMapFollowingUser && state.currentLocation != null) {
      final userPos = LatLng(
        state.currentLocation!.latitude,
        state.currentLocation!.longitude,
      );
      final heading = routeHeadingDegrees(userPos, route.geometry);
      cameraPosition = DiabRutaCameraPosition(
        target: userPos,
        zoom: 17,
        bearing: heading == null ? 0 : cameraBearingForHeading(heading),
      );
    }

    return (markers: markers, lines: lines, cameraPosition: cameraPosition);
  }

  void _buildUserLocation(NavigationState state, List<DiabRutaMarker> markers) {
    final location = state.currentLocation;
    if (location == null) return;

    final userPosition = LatLng(location.latitude, location.longitude);

    markers.add(
      DiabRutaMarker(
        id: 'user_location',
        position: userPosition,
        widget: _UserLocationMarker(isGpsWeak: state.isGpsWeak),
        size: const Size(48, 48),
        layerLevel: 100,
        imageCacheKey: 'nav_user_heading_${state.isGpsWeak}',
      ),
    );
  }

  void _buildRouteLinesWithProgress(
    NavigationRoute route,
    int currentLegIndex,
    int currentStopIndex,
    LatLng? userPosition,
    List<DiabRutaMarker> markers,
    List<DiabRutaLine> lines,
  ) {
    if (route.legs.isNotEmpty) {
      _buildLegsWithStyles(
        route,
        currentLegIndex,
        currentStopIndex,
        markers,
        lines,
        userPosition: userPosition,
      );
    } else {
      _buildSimpleGeometry(route, currentStopIndex, lines);
    }
  }

  int _getCurrentLegIndex(
    NavigationRoute route,
    int currentStopIndex,
    LatLng? userPosition,
  ) {
    if (route.legs.isEmpty) return 0;

    if (userPosition != null) {
      double minDist = double.infinity;
      int closestLegIndex = 0;

      for (int i = 0; i < route.legs.length; i++) {
        final leg = route.legs[i];
        for (int j = 0; j < leg.points.length; j++) {
          final dist = _distanceBetween(leg.points[j], userPosition);
          if (dist < minDist) {
            minDist = dist;
            closestLegIndex = i;
          }
        }
      }

      return closestLegIndex;
    }

    if (route.stops.isEmpty) return 0;
    if (currentStopIndex >= route.stops.length) {
      return route.legs.length - 1;
    }

    final currentStop = route.stops[currentStopIndex];

    double minDist = double.infinity;
    int closestLegIndex = 0;

    for (int i = 0; i < route.legs.length; i++) {
      final leg = route.legs[i];
      for (final point in leg.points) {
        final dist = _distanceBetween(point, currentStop.position);
        if (dist < minDist) {
          minDist = dist;
          closestLegIndex = i;
        }
      }
    }

    return closestLegIndex;
  }

  void _buildLegsWithStyles(
    NavigationRoute route,
    int currentLegIndex,
    int currentStopIndex,
    List<DiabRutaMarker> markers,
    List<DiabRutaLine> lines, {
    LatLng? userPosition,
  }) {
    for (int i = 0; i < route.legs.length; i++) {
      final leg = route.legs[i];
      if (leg.points.isEmpty) continue;

      final isCompletelyPassed = i < currentLegIndex;
      final isCurrentLeg = i == currentLegIndex;

      final Color activeColor;
      final double lineWidth;
      final bool useDots;

      if (leg.isTransit) {
        activeColor = leg.color != null ? Color(leg.color!) : Colors.blue;
        lineWidth = 6;
        useDots = false;
      } else if (leg.isBicycle) {
        activeColor = const Color(0xFF4CAF50);
        lineWidth = 5;
        useDots = false;
      } else {
        activeColor = Colors.grey;
        lineWidth = 4;
        useDots = true;
      }

      if (isCompletelyPassed) {
        lines.add(
          DiabRutaLine(
            id: 'leg-$i',
            position: leg.points,
            color: Colors.grey.withValues(alpha: 0.5),
            lineWidth: 4,
            activeDots: false,
            layerLevel: 0,
          ),
        );
      } else if (isCurrentLeg && userPosition != null) {
        final splitIndex = _findClosestPointIndex(leg.points, userPosition);

        if (splitIndex > 0) {
          final passedPoints = leg.points.sublist(0, splitIndex + 1);
          lines.add(
            DiabRutaLine(
              id: 'leg-$i-passed',
              position: passedPoints,
              color: Colors.grey.withValues(alpha: 0.5),
              lineWidth: 4,
              activeDots: false,
              layerLevel: 0,
            ),
          );
        }

        if (splitIndex < leg.points.length - 1) {
          final remainingPoints = leg.points.sublist(splitIndex);
          lines.add(
            DiabRutaLine(
              id: 'leg-$i-remaining',
              position: remainingPoints,
              color: activeColor,
              lineWidth: lineWidth,
              activeDots: useDots,
              layerLevel: 1,
            ),
          );
        }
      } else {
        lines.add(
          DiabRutaLine(
            id: 'leg-$i',
            position: leg.points,
            color: activeColor,
            lineWidth: lineWidth,
            activeDots: useDots,
            layerLevel: 1,
          ),
        );
      }
    }

    // Origin marker
    if (route.legs.isNotEmpty) {
      final firstLegPoints = route.legs.first.points;
      if (firstLegPoints.isNotEmpty) {
        markers.add(
          DiabRutaMarker(
            id: 'origin-marker',
            position: firstLegPoints.first,
            widget: const _OriginMarkerWidget(),
            size: const Size(24, 24),
            layerLevel: 3,
            imageCacheKey: 'nav_origin_marker',
          ),
        );
      }
    }

    // Destination marker
    if (route.legs.isNotEmpty) {
      final lastLegPoints = route.legs.last.points;
      if (lastLegPoints.isNotEmpty) {
        markers.add(
          DiabRutaMarker(
            id: 'destination-marker',
            position: lastLegPoints.last,
            widget: const _DestinationMarkerWidget(),
            size: const Size(32, 32),
            alignment: Alignment.topCenter,
            layerLevel: 3,
            imageCacheKey: 'nav_destination_marker',
          ),
        );
      }
    }
  }

  int _findClosestPointIndex(List<LatLng> points, LatLng position) {
    double minDist = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < points.length; i++) {
      final dist = _distanceBetween(points[i], position);
      if (dist < minDist) {
        minDist = dist;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  void _buildSimpleGeometry(
    NavigationRoute route,
    int currentStopIndex,
    List<DiabRutaLine> lines,
  ) {
    final geometry = route.geometry;
    if (geometry.isEmpty) return;

    final routeColor = route.backgroundColor != null
        ? Color(route.backgroundColor!)
        : Colors.blue;

    int splitIndex = 0;
    if (route.stops.isNotEmpty && currentStopIndex < route.stops.length) {
      final currentStop = route.stops[currentStopIndex];
      double minDist = double.infinity;

      for (int i = 0; i < geometry.length; i++) {
        final point = geometry[i];
        final dist = _distanceBetween(point, currentStop.position);
        if (dist < minDist) {
          minDist = dist;
          splitIndex = i;
        }
      }
    }

    if (splitIndex > 0) {
      final passedPoints = geometry.sublist(0, splitIndex + 1);
      lines.add(
        DiabRutaLine(
          id: 'passed_route',
          position: passedPoints,
          color: Colors.grey.withValues(alpha: 0.5),
          lineWidth: 4,
          layerLevel: 1,
        ),
      );
    }

    if (splitIndex < geometry.length - 1) {
      final remainingPoints = geometry.sublist(splitIndex);
      lines.add(
        DiabRutaLine(
          id: 'remaining_route',
          position: remainingPoints,
          color: routeColor,
          lineWidth: 6,
          layerLevel: 2,
        ),
      );
    }
  }

  double _distanceBetween(LatLng a, LatLng b) {
    const distance = Distance();
    return distance.as(LengthUnit.Meter, a, b);
  }
}

/// Widget for rendering the user's current location.
class _UserLocationMarker extends StatelessWidget {
  final bool isGpsWeak;

  const _UserLocationMarker({this.isGpsWeak = false});

  @override
  Widget build(BuildContext context) {
    final color = isGpsWeak ? Colors.orange : const Color(0xFF4285F4);
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(size: const Size(48, 48), painter: _RouteConePainter(color)),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteConePainter extends CustomPainter {
  const _RouteConePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.48;
    const halfAngle = 38 * math.pi / 180;
    const start = -math.pi / 2 - halfAngle;

    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        start,
        halfAngle * 2,
        false,
      )
      ..close();

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.42),
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RouteConePainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Origin marker - green circle (matches home screen style).
class _OriginMarkerWidget extends StatelessWidget {
  const _OriginMarkerWidget();

  static const _color = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

/// Destination marker - red pin icon (matches home screen style).
class _DestinationMarkerWidget extends StatelessWidget {
  const _DestinationMarkerWidget();

  static const _color = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.place_rounded,
      color: _color,
      size: 32,
      shadows: [
        Shadow(color: Colors.black38, blurRadius: 4, offset: Offset(0, 2)),
      ],
    );
  }
}


