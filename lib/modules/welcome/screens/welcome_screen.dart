import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wellcare/modules/dashboard/screens/dashboard_screen.dart';
import 'package:wellcare/modules/welcome/screens/page_1.dart';
import 'package:wellcare/modules/welcome/screens/page_2.dart';
import 'package:wellcare/modules/welcome/screens/page_3.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String get linkRoute => '/welcome';
  static String get toRoute => '/welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  void goToNextPage() {
    if (_controller.hasClients) {
      _controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.hasClients) {
                _controller.jumpToPage(3);
              }
            },
            child: Text(
              "Skip",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: R.colors.black,
              ),
            ),
          ),
        ],
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: const [
                  Page1(),
                  Page2(),
                  Page3(),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(
                dotColor: const Color(0xFF363636),
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: R.colors.bgPrimary,
              ),
            ),
            CustomButton(
              goTo: _currentPage == 2
                  ? () {
                      Modular.to.pushNamedAndRemoveUntil(
                          DashboardScreen.toRoute, (route) => false);
                    }
                  : goToNextPage,
              elevation: 0,
              buttonColor: R.colors.bgPrimary,
              buttonText: _currentPage == 2 ? "Get Started" : "Next",
              buttonWidth: double.infinity,
              rounded: 100,
              textStyle: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: R.colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
