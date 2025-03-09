import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/r.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double? buttonWidth;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final double? rounded;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final Function()? goTo;
  final double elevation;
  const CustomButton(
      {super.key,
      this.fontSize,
      this.elevation = 2,
      this.textStyle,
      this.rounded,
      this.buttonWidth,
      required this.buttonText,
      this.fontWeight,
      this.goTo,
      this.textColor,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(rounded ?? 10.sp),
        color: buttonColor ?? R.colors.black,
        child: MaterialButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          padding: EdgeInsets.fromLTRB(18.sp, 0.sp, 18.sp, 0.sp),
          minWidth: buttonWidth,
          height: 30,
          onPressed: goTo,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: textStyle ??
                GoogleFonts.publicSans(
                  fontSize: fontSize ?? 16.sp,
                  color: textColor ?? R.colors.white,
                  fontWeight: fontWeight ?? FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
