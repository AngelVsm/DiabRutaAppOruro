import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:diabruta_navigation/src/presentation/layers/navigation_layer.dart';

void main() {
  test('the route heading looks along the street ahead', () {
    const user = LatLng(-17.96, -67.11);
    const east = LatLng(-17.96, -67.109);
    final heading = routeHeadingDegrees(user, const [user, east]);
    expect(heading, isNotNull);
    expect(heading!, closeTo(90, 5));
  });
}
