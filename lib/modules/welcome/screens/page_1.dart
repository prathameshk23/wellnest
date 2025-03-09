import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/resources/r.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(R.assets.page1Panda),
            const SizedBox(height: 60),
            Text(
              "Welcome to Wellnest",
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: R.colors.black,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Wellnest is your personal health companion, designed to help you track your daily wellness with ease. Using an intuitive calendar-based interface, you can log essential health data.",
              textAlign: TextAlign.center,
              style: GoogleFonts.publicSans(
                fontSize: 16,
                color: R.colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
