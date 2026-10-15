import 'package:diabruta_interfaces/src/service_locator.dart';

abstract class DiabRutaModule {
  String get name;
  Future<void> configure(ServiceLocator locator);
  Future<void> initialize(ServiceLocator locator);
  List<DiabRutaModule> get dependencies => [];
}

