import 'package:flutter_modular/flutter_modular.dart';
import 'package:wellcare/modules/dashboard/dashboard_widget.dart';
import 'package:wellcare/modules/dashboard/screens/gratitude_screen.dart';
import 'package:wellcare/modules/dashboard/screens/health_check_in_screen.dart';
import 'package:wellcare/modules/dashboard/screens/home_screen.dart';
import 'package:wellcare/modules/dashboard/screens/other_factors_screen.dart';
import 'package:wellcare/modules/dashboard/screens/sleep_screen.dart';
import 'package:wellcare/modules/dashboard/screens/symptoms_screen.dart';

class DashboardModule extends Module {
  static String get moduleRoute => "/dashboard";

  @override
  void routes(r) {
    r.child(
      DashboardWidget.linkRoute,
      child: (context) => const DashboardWidget(),
    );

    r.child(
      HomeScreen.linkRoute,
      child: (context) => const HomeScreen(),
    );

    r.child(
      SymptomsScreen.linkRoute,
      child: (context) => const SymptomsScreen(),
    );
    r.child(
      OtherFactorsScreen.linkRoute,
      child: (context) => const OtherFactorsScreen(),
    );
    r.child(
      GratitudeScreen.linkRoute,
      child: (context) => const GratitudeScreen(),
    );
    r.child(
      SleepScreen.linkRoute,
      child: (context) => const SleepScreen(),
    );
    r.child(
      HealthCheckInScreen.linkRoute,
      child: (context) => const HealthCheckInScreen(),
    );
  }
}
