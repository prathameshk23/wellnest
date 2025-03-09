import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/resources/r.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(R.assets.page2Panda),
            const SizedBox(height: 60),
            Text(
              "Why Wellnest Matters",
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: R.colors.black,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Your health is more than just numbers—it's about consistency, awareness, and mindfulness. Wellnest empowers you.",
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
