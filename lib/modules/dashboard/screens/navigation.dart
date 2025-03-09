import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/dashboard/screens/dashboard_screen.dart';
import 'package:wellcare/modules/dashboard/screens/more_screen.dart';
import 'package:wellcare/modules/dashboard/screens/track_progress.dart';
import 'package:wellcare/resources/r.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  static String get linkRoute => "/navigation";
  static String get toRoute => "/navigation";

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          Modular.to.pop();
          // exit(0);
        },
        child: Scaffold(
          backgroundColor: R.colors.white,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: R.colors.white,
                boxShadow: [
                  BoxShadow(
                    color: R.colors.neutral300,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.bottomCenter,
              height: 70,
              child: TabBar(
                tabs: [
                  const Tab(
                    icon: Icon(Icons.home_rounded),
                    text: "Home",
                  ),
                  Tab(
                    icon: Transform.flip(
                      flipX: true,
                      child: Transform.rotate(
                          angle: 4.72, child: const Icon(Icons.sort_rounded)),
                    ),
                    text: "Track Progress",
                  ),
                  const Tab(
                    icon: Icon(Icons.more_horiz),
                    text: "More",
                  )
                ],
                indicatorColor: Colors.transparent,
                labelColor: R.colors.blue300,
                unselectedLabelColor: R.colors.neutral400,
                labelStyle: GoogleFonts.workSans(),
              )),
          body: const TabBarView(
            children: [
              DashboardScreen(),
              TrackProgress(),
              MoreScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
