// ignore_for_file: duplicate_import

import 'package:flutter_modular/flutter_modular.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/modules/welcome/welcome_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  // add module routes into the routes scope
  @override
  void routes(r) {
    r.module(
      AuthModule.moduleRoute,
      module: AuthModule(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      WelcomeModule.moduleRoute,
      module: WelcomeModule(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      DashboardModule.moduleRoute,
      module: DashboardModule(),
      transition: TransitionType.fadeIn,
    );
  }
}
