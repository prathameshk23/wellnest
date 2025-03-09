import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/welcome/screens/welcome_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

class CompanionScreen extends StatefulWidget {
  const CompanionScreen({super.key});

  static String get linkRoute => '/companion/';
  static String get toRoute => "${AuthModule.moduleRoute}companion/";

  @override
  State<CompanionScreen> createState() => _CompanionScreenState();
}

class _CompanionScreenState extends State<CompanionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            bottom: 0,
            child: Transform.scale(
              scale: 1.2,
              child: SvgPicture.asset(
                R.assets.vector,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset(R.assets.adoptPanda)),
                Text(
                  "Your health companion",
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Prathamesh is here for you",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your companion will help you to discover health\n insights which will improve the more you track.",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: R.colors.black,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  goTo: () {
                    Modular.to.pushNamedAndRemoveUntil(
                        WelcomeScreen.toRoute, (route) => false);
                  },
                  elevation: 0,
                  buttonColor: R.colors.bgPrimary,
                  buttonText: "Save",
                  buttonWidth: double.infinity,
                  rounded: 100,
                  textStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: R.colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
