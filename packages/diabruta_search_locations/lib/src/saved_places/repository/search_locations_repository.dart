import 'package:diabruta_interfaces/diabruta_interfaces.dart';

/// Abstract interface for storing saved places locally.
abstract class SearchLocationsRepository {
  /// Initialize the repository and open storage.
  Future<void> loadRepository();

  /// Close the repository and release resources.
  Future<void> dispose();

  Future<List<DiabRutaLocation>> getMyPlaces();
  Future<void> saveMyPlaces(List<DiabRutaLocation> data);

  Future<List<DiabRutaLocation>> getMyDefaultPlaces();
  Future<void> saveMyDefaultPlaces(List<DiabRutaLocation> data);

  Future<List<DiabRutaLocation>> getHistoryPlaces();
  Future<void> saveHistoryPlaces(List<DiabRutaLocation> data);

  Future<List<DiabRutaLocation>> getFavoritePlaces();
  Future<void> saveFavoritePlaces(List<DiabRutaLocation> data);
}


