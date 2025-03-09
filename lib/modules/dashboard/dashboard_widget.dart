import 'package:flutter/material.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/modules/dashboard/screens/navigation.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  static String get linkRoute => "/";
  static String get toRoute => DashboardModule.moduleRoute + linkRoute;

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NavBar(),
    );
  }
}
