import 'package:flutter/material.dart';
import 'map_engine.dart';

/// Builder function for map route widget.
typedef MapRouteBuilder =
    Widget Function(BuildContext context, dynamic asyncExecutor);

/// Builder function for choose location widget.
typedef MapChooseLocationBuilder =
    Widget Function(
      BuildContext context,
      void Function(dynamic) onCenterChanged,
    );

/// Interface for map route provider.
abstract class IMapRouteProvider {
  IDiabRutaMapController get diabrutaMapController;
  MapRouteBuilder get mapRouteBuilder;
}

/// Interface for choose location provider.
abstract class IMapChooseLocationProvider {
  IDiabRutaMapController get diabrutaMapController;
  MapChooseLocationBuilder get mapChooseLocationBuilder;
  IMapChooseLocationProvider rebuild();
}

/// Interface for the main map provider collection.
///
/// Implementations provide different map backends (DiabRutaCoreMaps, Leaflet, etc).
abstract class IDiabRutaMapProvider {
  IMapChooseLocationProvider mapChooseLocationProvider();

  IMapRouteProvider mapRouteProvider({
    Uri? shareBaseItineraryUri,
    WidgetBuilder? overlapWidget,
  });
}


