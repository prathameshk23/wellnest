import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/auth/screens/condition_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/store/app_store.dart';
import 'package:wellcare/utils/logger.dart';
import 'package:wellcare/widgets/custom_button.dart';
import 'package:wellcare/widgets/custom_slider.dart';

class DescribeScreen extends StatefulWidget {
  const DescribeScreen({super.key});

  static String get linkRoute => '/describe/';
  static String get toRoute => "${AuthModule.moduleRoute}describe/";

  @override
  State<DescribeScreen> createState() => _DescribeScreenState();
}

class _DescribeScreenState extends State<DescribeScreen> {
  double motivationValue = 0;
  double healthValue = 0;
  final AppStore store = Modular.get<AppStore>();

  void _handleMotivationSliderChange(double value) {
    setState(() {
      motivationValue = value;
      logger.i(motivationValue);
      store.motivationLevel = motivationValue.toString();
    });
  }

  void _handleHealthSliderChnage(double value) {
    setState(() {
      healthValue = value;
      store.healthStatus = healthValue.toString();
    });
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
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: Stack(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: R.colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: R.colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: 80,
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: R.colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: 80,
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    "How would you describe yourself?",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: R.colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🔥 Health tracking motivation level",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: R.colors.black,
                      ),
                    ),
                    Text(
                      "In how much detail are you motivated to track your health and habits in wellness",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: R.colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomSlider(
                        onValueChanged: _handleMotivationSliderChange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "💙 Health status",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: R.colors.black,
                      ),
                    ),
                    Text(
                      "Do you live with a long-term health condition? e.g. chronic pain, CFS/ME, Depression, IBD/S",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: R.colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomSlider(
                        onValueChanged: _handleHealthSliderChnage,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  goTo: () {
                    Modular.to.pushNamed(ConditionScreen.toRoute);
                  },
                  elevation: 0,
                  buttonColor: R.colors.bgPrimary,
                  buttonText: "Continue",
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
