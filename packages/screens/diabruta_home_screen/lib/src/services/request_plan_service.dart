import 'package:diabruta_interfaces/diabruta_interfaces.dart';
import 'package:diabruta_routing/diabruta_routing.dart' as routing;

/// Abstract interface for route planning requests.
abstract class RequestPlanService {
  /// Fetch a route plan from origin to destination.
  Future<routing.Plan> fetchPlan({
    required DiabRutaLocation from,
    required DiabRutaLocation to,
    String? locale,
    required DateTime dateTime,
    bool arriveBy = false,
  });
}


