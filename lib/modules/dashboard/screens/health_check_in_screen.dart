import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';
import 'package:wellcare/widgets/custom_textfield.dart';

class HealthCheckInScreen extends StatefulWidget {
  const HealthCheckInScreen({super.key});

  static String get linkRoute => "/healthCheckInScreen";
  static String get toRoute =>
      "${DashboardModule.moduleRoute}/healthCheckInScreen";

  @override
  State<HealthCheckInScreen> createState() => _HealthCheckInScreenState();
}

class _HealthCheckInScreenState extends State<HealthCheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings_outlined,
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
            top: -80,
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.1,
              child: SvgPicture.asset(R.assets.topVector),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              width: double.infinity,
              color: R.colors.white,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 18,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(R.assets.backIcon),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today",
                          style: GoogleFonts.publicSans(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: R.colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Health Check-In",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: R.colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: R.colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: R.colors.neutral300,
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Section with Close Button
                      Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              CustomTextField(
                                labelText: "Step Count",
                                controller: TextEditingController(),
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                labelText: "Weight",
                                controller: TextEditingController(),
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                labelText: "Heart Rate",
                                controller: TextEditingController(),
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                labelText: "Calorie Intake",
                                controller: TextEditingController(),
                              )
                            ],
                          )),
                      const SizedBox(height: 8),
                      // Text Field
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                elevation: 0,
                rounded: 50,
                buttonText: "Done",
                buttonWidth: double.infinity,
                buttonColor: R.colors.bgPrimary,
                textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  color: R.colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
