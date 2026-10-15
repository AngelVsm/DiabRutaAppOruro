import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:diabruta_interfaces/diabruta_interfaces.dart';
import 'package:diabruta_utils/diabruta_utils.dart';

import 'search_locations_repository.dart';

/// Default local implementation of [SearchLocationsRepository].
///
/// Uses [StorageService] for persistence. By default uses [SharedPreferencesStorage],
/// but can be configured with any [StorageService] implementation for testing or
/// alternative storage backends.
class SearchLocationsRepositoryImpl implements SearchLocationsRepository {
  static const _favoritePlacesKey = 'diabruta_search_favorite_places';
  static const _historyPlacesKey = 'diabruta_search_history_places';
  static const _myDefaultPlacesKey = 'diabruta_search_my_default_places';
  static const _myPlacesKey = 'diabruta_search_my_places';

  final StorageService _storage;
  bool _isInitialized = false;

  SearchLocationsRepositoryImpl({StorageService? storage})
    : _storage = storage ?? SharedPreferencesStorage();

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'SearchLocationsRepositoryImpl not initialized. '
        'Call loadRepository() first.',
      );
    }
  }

  @override
  Future<void> loadRepository() async {
    if (_isInitialized) return;
    await _storage.initialize();
    _isInitialized = true;
  }

  @override
  Future<void> dispose() async {
    await _storage.dispose();
    _isInitialized = false;
  }

  @override
  Future<List<DiabRutaLocation>> getFavoritePlaces() async {
    return _getPlacesList(_favoritePlacesKey);
  }

  @override
  Future<List<DiabRutaLocation>> getHistoryPlaces() async {
    return _getPlacesList(_historyPlacesKey);
  }

  @override
  Future<List<DiabRutaLocation>> getMyDefaultPlaces() async {
    return _getPlacesList(_myDefaultPlacesKey);
  }

  @override
  Future<List<DiabRutaLocation>> getMyPlaces() async {
    return _getPlacesList(_myPlacesKey);
  }

  @override
  Future<void> saveFavoritePlaces(List<DiabRutaLocation> data) async {
    await _savePlacesList(_favoritePlacesKey, data);
  }

  @override
  Future<void> saveHistoryPlaces(List<DiabRutaLocation> data) async {
    await _savePlacesList(_historyPlacesKey, data);
  }

  @override
  Future<void> saveMyDefaultPlaces(List<DiabRutaLocation> data) async {
    await _savePlacesList(_myDefaultPlacesKey, data);
  }

  @override
  Future<void> saveMyPlaces(List<DiabRutaLocation> data) async {
    await _savePlacesList(_myPlacesKey, data);
  }

  // ============ Private Helpers ============

  Future<List<DiabRutaLocation>> _getPlacesList(String key) async {
    try {
      _ensureInitialized();
      final data = await _storage.read(key);
      if (data == null) return [];
      final List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
      return jsonList
          .map<DiabRutaLocation>(
            (dynamic json) =>
                DiabRutaLocation.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      debugPrint('Error loading places from $key: $e');
      return [];
    }
  }

  Future<void> _savePlacesList(String key, List<DiabRutaLocation> data) async {
    try {
      _ensureInitialized();
      await _storage.write(key, jsonEncode(data));
    } catch (e) {
      debugPrint('Error saving places to $key: $e');
    }
  }
}

