import 'package:diabruta_interfaces/diabruta_interfaces.dart';
import 'package:diabruta_routing/diabruta_routing.dart' as routing;

/// Abstract interface for home screen local storage.
abstract class HomeScreenRepository {
  /// Initialize the repository.
  Future<void> initialize();

  /// Dispose resources.
  Future<void> dispose();

  /// Save the origin location.
  Future<void> saveFromPlace(DiabRutaLocation? data);

  /// Get the saved origin location.
  Future<DiabRutaLocation?> getFromPlace();

  /// Save the destination location.
  Future<void> saveToPlace(DiabRutaLocation? data);

  /// Get the saved destination location.
  Future<DiabRutaLocation?> getToPlace();

  /// Save the current plan.
  Future<void> savePlan(routing.Plan? data);

  /// Get the saved plan.
  Future<routing.Plan?> getPlan();

  /// Save the selected itinerary.
  Future<void> saveSelectedItinerary(routing.Itinerary? data);

  /// Get the saved selected itinerary.
  Future<routing.Itinerary?> getSelectedItinerary();

  /// Clear all saved data.
  Future<void> clear();
}


