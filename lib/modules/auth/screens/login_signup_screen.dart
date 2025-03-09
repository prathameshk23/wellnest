import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/auth/screens/signin_screen.dart';
import 'package:wellcare/modules/auth/screens/signup_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

class SignUpLoginScreen extends StatefulWidget {
  const SignUpLoginScreen({super.key});

  static String get linkRoute => '/';
  static String get toRoute => AuthModule.moduleRoute;

  @override
  State<SignUpLoginScreen> createState() => _SignUpLoginScreenState();
}

class _SignUpLoginScreenState extends State<SignUpLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.bgPrimary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(R.assets.loginPanda),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Track Your Wellness",
              style: GoogleFonts.publicSans(
                fontSize: 38,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "One Day at a Time.",
              style: GoogleFonts.publicSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  goTo: () {
                    Modular.to.pushNamed(SignupScreen.toRoute);
                  },
                  buttonText: "Start Your Wellness Journey",
                  rounded: 14,
                  textStyle: GoogleFonts.publicSans(
                    fontSize: 12,
                    color: R.colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomButton(
                  goTo: () {
                    Modular.to.pushNamed(SigninScreen.toRoute);
                  },
                  buttonText: "Already a Member",
                  rounded: 14,
                  textStyle: GoogleFonts.publicSans(
                    fontSize: 12,
                    color: R.colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
