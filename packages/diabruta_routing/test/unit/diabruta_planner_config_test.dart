import 'package:flutter_test/flutter_test.dart';
import 'package:diabruta_routing/diabruta_routing.dart';

void main() {
  group('DiabRutaPlannerConfig transfer knobs', () {
    test(
      'local mode defaults match the planner (100 m, 3 routes per name)',
      () {
        const config = DiabRutaPlannerConfig.local(gtfsAsset: 'assets/gtfs.zip');
        expect(config.isLocal, isTrue);
        expect(config.transferRadiusMeters, 100);
        expect(config.sameNameRouteLimit, 3);
      },
    );

    test('local mode exposes both knobs', () {
      const config = DiabRutaPlannerConfig.local(
        gtfsAsset: 'assets/gtfs.zip',
        transferRadiusMeters: 0,
        sameNameRouteLimit: 1 << 30,
      );
      expect(config.transferRadiusMeters, 0);
      expect(config.sameNameRouteLimit, 1 << 30);
    });

    test('remote mode leaves them to the server (fixed defaults)', () {
      const config = DiabRutaPlannerConfig.remote(serverUrl: 'https://p.example');
      expect(config.isRemote, isTrue);
      expect(config.transferRadiusMeters, 100);
      expect(config.sameNameRouteLimit, 3);
    });
  });

  group('DiabRutaPlannerConfig fallback vehicle speed (#997)', () {
    test('local mode defaults to 20 km/h and exposes the knob', () {
      const config = DiabRutaPlannerConfig.local(gtfsAsset: 'assets/gtfs.zip');
      expect(config.fallbackVehicleSpeedKmh, 20);
      const custom = DiabRutaPlannerConfig.local(
        gtfsAsset: 'assets/gtfs.zip',
        fallbackVehicleSpeedKmh: 32,
      );
      expect(custom.fallbackVehicleSpeedKmh, 32);
    });

    test('a non-positive speed fails the assertion', () {
      expect(
        () => DiabRutaPlannerConfig.local(
          gtfsAsset: 'assets/gtfs.zip',
          fallbackVehicleSpeedKmh: 0,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('remote mode leaves it to the server (fixed default)', () {
      const config = DiabRutaPlannerConfig.remote(serverUrl: 'https://p.example');
      expect(config.fallbackVehicleSpeedKmh, 20);
    });
  });

  group('DiabRutaPlannerConfig persisted index (#993)', () {
    test('local mode persists by default and can opt out', () {
      const on = DiabRutaPlannerConfig.local(gtfsAsset: 'assets/gtfs.zip');
      expect(on.persistIndex, isTrue);
      const off = DiabRutaPlannerConfig.local(
        gtfsAsset: 'assets/gtfs.zip',
        persistIndex: false,
      );
      expect(off.persistIndex, isFalse);
    });

    test('remote mode has nothing to persist', () {
      const config = DiabRutaPlannerConfig.remote(serverUrl: 'https://p.example');
      expect(config.persistIndex, isFalse);
    });
  });
}


