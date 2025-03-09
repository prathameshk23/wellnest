import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/resources/r.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset(R.assets.page3Panda),
            const SizedBox(height: 60),
            Text(
              "General Health Importance",
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: R.colors.black,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Good health is the foundation of a happy life. But in today’s busy world, it’s easy to overlook the small signals our body gives us.",
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
