import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/resources/r.dart';

class CustomCard extends StatelessWidget {
  final String cardEmoji;
  final String cardTitle;
  const CustomCard({
    super.key,
    required this.cardEmoji,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: R.colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: R.colors.neutral300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cardEmoji,
              style: GoogleFonts.publicSans(
                fontSize: 40,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              cardTitle,
              style: GoogleFonts.publicSans(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
