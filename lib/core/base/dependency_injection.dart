import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

/// Simple DI
class InjectorDI {
  static final InjectorDI singleton = InjectorDI._internal();

  InjectorDI._internal();


  factory InjectorDI() {
    return singleton;
  }
}
