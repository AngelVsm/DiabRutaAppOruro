import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';

/// Abstract interface for the overlay manager.
///
/// Exposes both:
/// - Runtime overlay manipulation (push/pop) used by child AppOverlayManagers
///   through [AppOverlayManager.onAppReady].
/// - Provider wiring ([providers]) consumed by the app's MultiProvider so
///   the overlay manager and its child managers are auto-registered.
abstract class OverlayService {
  /// Push an overlay widget with the given configuration.
  void pushOverlay({
    required Widget child,
    required String id,
    bool dismissible = false,
  });

  /// Remove an overlay by its ID.
  void popOverlayById(String id);

  /// Check if an overlay with the given ID exists.
  bool hasOverlayWithId(String id);

  /// Providers to register for this overlay manager and all its child
  /// managers. Spread these into a MultiProvider.providers list.
  List<SingleChildWidget> get providers;
}


