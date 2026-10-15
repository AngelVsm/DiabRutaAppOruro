import 'package:flutter_test/flutter_test.dart';
import 'package:diabruta_utils/src/device_heading.dart';

void main() {
  test('a flat phone pointed north reads 0 degrees', () {
    final heading = headingDegrees(
      ax: 0,
      ay: 0,
      az: 9.8,
      mx: 0,
      my: 30,
      mz: 0,
    );
    expect(heading, isNotNull);
    expect(heading!, closeTo(0, 0.1));
  });

  test('a flat phone pointed east reads 90 degrees', () {
    final heading = headingDegrees(
      ax: 0,
      ay: 0,
      az: 9.8,
      mx: -30,
      my: 0,
      mz: 0,
    );
    expect(heading, isNotNull);
    expect(heading!, closeTo(90, 0.1));
  });

  test('camera bearing flips a clockwise heading so the map points that way', () {
    expect(cameraBearingForHeading(0), 0);
    expect(cameraBearingForHeading(90), 270);
    expect(cameraBearingForHeading(360), 0);
  });

  test('blendHeading softens a turn and crosses the north wrap', () {
    expect(blendHeading(10, 20, alpha: 0.5), closeTo(15, 0.01));
    expect(blendHeading(350, 10, alpha: 0.5), closeTo(0, 0.01));
    expect(blendHeading(10, 350, alpha: 0.5), closeTo(0, 0.01));
  });
}
