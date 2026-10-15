/// Route planning for DiabRuta. Trips are calculated on the phone from the GTFS file.
library;

// ============================================
// Models
// ============================================
export 'src/models/agency.dart';
export 'src/models/itinerary.dart';
export 'src/models/itinerary_group.dart';
export 'src/models/leg.dart';
export 'src/models/place.dart';
export 'src/models/plan.dart';
export 'src/models/plan_location.dart';
export 'src/models/realtime_state.dart';
export 'src/models/route.dart';
export 'src/models/routing_location.dart';
export 'src/models/service_hours.dart';
export 'src/models/service_hours_lookup.dart';
export 'src/models/step.dart';
export 'src/models/stop.dart';
export 'src/models/transit_route.dart';
export 'src/models/transport_mode.dart';
export 'src/models/vertex_type.dart';

// ============================================
// Utilities
// ============================================
export 'src/utils/polyline_decoder.dart';

// ============================================
// ROUTING PROVIDERS - Common
// ============================================
export 'src/routing_engine_manager.dart';
export 'src/providers/routing_provider.dart';

// ============================================
// SERVICES
// ============================================
export 'src/services/itinerary_grouper.dart';
export 'src/services/itinerary_filters.dart';

// ============================================
// Widgets
// ============================================
export 'src/widgets/service_hours_indicator.dart';

// ============================================
// Localizations
// ============================================
export 'l10n/routing_localizations.dart';

// ============================================
// TRUFI PLANNER (local + remote routing)
// ============================================
export 'src/providers/trufi_planner/trufi_planner_provider.dart';
export 'src/providers/trufi_planner/trufi_planner_config.dart';
export 'src/providers/trufi_planner/trufi_planner_data_source.dart';

