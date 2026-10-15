import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Degrees clockwise from magnetic north, from the phone's accelerometer
/// and magnetometer. Null when the phone is in free fall or the magnetic
/// field is too weak to trust.
///
/// This is the same pair of sensors Android uses for a compass: the
/// gyroscope alone only measures spin, not which way is north.
double? headingDegrees({
  required double ax,
  required double ay,
  required double az,
  required double mx,
  required double my,
  required double mz,
}) {
  final normsqA = ax * ax + ay * ay + az * az;
  const g = 9.81;
  if (normsqA < 0.01 * g * g) return null;

  var hx = my * az - mz * ay;
  var hy = mz * ax - mx * az;
  var hz = mx * ay - my * ax;
  final normH = math.sqrt(hx * hx + hy * hy + hz * hz);
  if (normH < 0.1) return null;
  final invH = 1.0 / normH;
  hx *= invH;
  hy *= invH;
  hz *= invH;

  final invA = 1.0 / math.sqrt(normsqA);
  final axn = ax * invA;
  final azn = az * invA;
  // East component of the rotation matrix (Android SensorManager R[4]).
  final eastY = azn * hx - axn * hz;

  var degrees = math.atan2(hy, eastY) * 180 / math.pi;
  if (degrees < 0) degrees += 360;
  return degrees;
}

/// Bearing stored on [DiabRutaCameraPosition]. The map turns that value
/// around before drawing, so a clockwise compass heading has to be flipped
/// for the top of the screen to point that way.
double cameraBearingForHeading(double clockwiseFromNorth) {
  final turns = clockwiseFromNorth % 360;
  final positive = turns < 0 ? turns + 360 : turns;
  return (360 - positive) % 360;
}

double smallestHeadingDelta(double a, double b) {
  final diff = (a - b).abs() % 360;
  return diff > 180 ? 360 - diff : diff;
}

/// Blends [next] into [previous] across the 0°/360° wrap, like Google Maps.
double blendHeading(double previous, double next, {double alpha = 0.12}) {
  var delta = next - previous;
  if (delta > 180) delta -= 360;
  if (delta < -180) delta += 360;
  var blended = previous + alpha * delta;
  blended %= 360;
  if (blended < 0) blended += 360;
  return blended;
}

double _normalizeHeading(double degrees) {
  var value = degrees % 360;
  if (value < 0) value += 360;
  return value;
}

/// High-rate compass: gyroscope for smooth motion, magnetometer for north.
///
/// Updates as fast as the sensors allow (typically 60–200 Hz) so a vsync
/// ticker can rotate the map at the display refresh rate.
class DeviceHeading extends ChangeNotifier {
  DeviceHeading({
    /// How strongly each magnetometer reading pulls toward absolute north.
    /// Low keeps the gyro-smooth motion; high snaps harder to the compass.
    this.magnetometerBlend = 0.045,
  });

  final double magnetometerBlend;

  StreamSubscription<AccelerometerEvent>? _accelerometer;
  StreamSubscription<MagnetometerEvent>? _magnetometer;
  StreamSubscription<GyroscopeEvent>? _gyroscope;
  double? _ax;
  double? _ay;
  double? _az;
  double? _mx;
  double? _my;
  double? _mz;
  double? _heading;
  bool _active = false;
  DateTime? _lastGyroAt;

  double? get heading => _heading;

  bool get isActive => _active;

  void start() {
    if (_active) return;
    _active = true;
    // Fastest rate the platform will deliver so map rotation can track
    // 60 / 120 / 144 Hz displays instead of feeling like ~15 fps.
    const period = SensorInterval.fastestInterval;
    try {
      _accelerometer = accelerometerEventStream(samplingPeriod: period).listen(
        (event) {
          _ax = event.x;
          _ay = event.y;
          _az = event.z;
        },
        onError: (_) {},
      );
      _magnetometer = magnetometerEventStream(samplingPeriod: period).listen(
        (event) {
          _mx = event.x;
          _my = event.y;
          _mz = event.z;
          _applyMagnetometer();
        },
        onError: (_) {},
      );
      _gyroscope = gyroscopeEventStream(samplingPeriod: period).listen(
        _onGyro,
        onError: (_) {},
      );
    } catch (error, stack) {
      debugPrint('Compass unavailable: $error\n$stack');
      stop();
    }
  }

  void _onGyro(GyroscopeEvent event) {
    final heading = _heading;
    final ax = _ax;
    final ay = _ay;
    final az = _az;
    if (heading == null || ax == null || ay == null || az == null) return;

    final now = DateTime.now();
    final last = _lastGyroAt;
    _lastGyroAt = now;
    if (last == null) return;
    final dt = now.difference(last).inMicroseconds / 1e6;
    if (dt <= 0 || dt > 0.05) return;

    final norm = math.sqrt(ax * ax + ay * ay + az * az);
    if (norm < 1) return;
    final nx = ax / norm;
    final ny = ay / norm;
    final nz = az / norm;
    // Yaw rate around gravity (rad/s). Negated so clockwise turns increase
    // the compass heading to match [headingDegrees].
    final yawRate = event.x * nx + event.y * ny + event.z * nz;
    _heading = _normalizeHeading(heading - yawRate * dt * 180 / math.pi);
    notifyListeners();
  }

  void _applyMagnetometer() {
    final ax = _ax;
    final ay = _ay;
    final az = _az;
    final mx = _mx;
    final my = _my;
    final mz = _mz;
    if (ax == null || ay == null || az == null) return;
    if (mx == null || my == null || mz == null) return;
    final absolute = headingDegrees(
      ax: ax,
      ay: ay,
      az: az,
      mx: mx,
      my: my,
      mz: mz,
    );
    if (absolute == null) return;

    final previous = _heading;
    if (previous == null) {
      _heading = absolute;
    } else {
      _heading = blendHeading(
        previous,
        absolute,
        alpha: magnetometerBlend,
      );
    }
    notifyListeners();
  }

  void stop() {
    _accelerometer?.cancel();
    _magnetometer?.cancel();
    _gyroscope?.cancel();
    _accelerometer = null;
    _magnetometer = null;
    _gyroscope = null;
    _active = false;
    _lastGyroAt = null;
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
