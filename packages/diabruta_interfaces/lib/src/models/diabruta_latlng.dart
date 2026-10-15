import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

/// Geographic coordinate representing latitude and longitude.
///
/// This is the core coordinate class used throughout diabruta_core packages.
class DiabRutaLatLng extends Equatable {
  final double latitude;
  final double longitude;

  const DiabRutaLatLng(this.latitude, this.longitude);

  factory DiabRutaLatLng.fromLatLng(LatLng latLng) {
    return DiabRutaLatLng(latLng.latitude, latLng.longitude);
  }

  factory DiabRutaLatLng.fromJson(Map<String, dynamic> json) {
    return DiabRutaLatLng(json["latitude"] as double, json["longitude"] as double);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"latitude": latitude, "longitude": longitude};
  }

  LatLng toLatLng() => LatLng(latitude, longitude);

  /// Great-circle distance to [other], in meters.
  double distanceTo(DiabRutaLatLng other) =>
      const Distance().as(LengthUnit.Meter, toLatLng(), other.toLatLng());

  static List<LatLng> toListLatLng(List<DiabRutaLatLng> listDiabRutaLatLng) {
    return listDiabRutaLatLng.map((e) => e.toLatLng()).toList();
  }

  static List<DiabRutaLatLng> fromListLatLng(List<LatLng> listDiabRutaLatLng) {
    return listDiabRutaLatLng.map((e) => DiabRutaLatLng.fromLatLng(e)).toList();
  }

  @override
  List<Object?> get props => [latitude, longitude];

  @override
  String toString() => 'DiabRutaLatLng($latitude, $longitude)';
}

