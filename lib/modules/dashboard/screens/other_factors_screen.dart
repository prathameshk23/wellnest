import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wellcare/models/other_track.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/modules/dashboard/widget/activity_slider.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../store/app_store.dart';
import '../../../utils/logger.dart';
import '../services/dash_services.dart';

final kToday = DateTime.now();

class OtherFactorsScreen extends StatefulWidget {
  const OtherFactorsScreen({super.key});

  static String get linkRoute => "/otherFactorsScreen";
  static String get toRoute =>
      "${DashboardModule.moduleRoute}/otherFactorsScreen";

  @override
  State<OtherFactorsScreen> createState() => _OtherFactorsScreenState();
}

class _OtherFactorsScreenState extends State<OtherFactorsScreen> {
  final kDay = DateTime(kToday.year, kToday.month, kToday.day);
  List<OtherTrack> otherTrack = [];
  List<String> conditions = [];
  bool isLoading = true; // Add loading state
  Map<String, dynamic> condition = {
    "Alcohol": "11129468-ec91-4bfd-8cb6-c1547bc4a096",
    "Stress": "4568b4cd-3a11-463e-8f4e-855b8c4bb64b",
    "Energy Level": "677e686c-fb0e-4a7d-b0d6-66d7db7b4e7b"
  };
  List<Map<String, dynamic>> updates = [];
  final AppStore store = Modular.get<AppStore>();
  DashServices apiServices = DashServices();

  @override
  void initState() {
    super.initState();
    if (store.selectedDate == DateFormat('yyyy-MM-dd').format(kDay)) {
      print(true);
    } else {
      print(false);
    }
    getSymptoms();
  }

  Future<void> getSymptoms() async {
    setState(() {
      isLoading = true; // Set loading to true when starting fetch
    });

    try {
      otherTrack = await apiServices.getOtherTrack(store.user.id);

      // Debug log to check what's in otherTrack
      logger.i("OtherTrack raw data: $otherTrack");
      for (var track in otherTrack) {
        logger.i("Track name: ${track.otherFactorName}, value: ${track.value}");
      }

      if (otherTrack.isEmpty) {
        conditions = condition.keys.toList();
      } else {
        conditions = otherTrack.map((e) => e.otherFactorName).toList();
      }

      logger.i("Using conditions: $conditions");
    } catch (e) {
      logger.e("Error fetching other factors: $e");
      conditions = condition.keys.toList();
    } finally {
      // Ensure setState is called even if there's an error
      if (mounted) {
        setState(() {
          isLoading = false; // Set loading to false when fetch completes
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                          DateFormat.yMMMMd('en_US')
                              .format(DateTime.parse(store.selectedDate)),
                          style: GoogleFonts.publicSans(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: R.colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Other Factors",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: R.colors.black,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
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
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    conditions.isNotEmpty
                                        ? conditions.length
                                        : condition.length,
                                    (index) {
                                      // Get the current factor name based on whether conditions is empty
                                      String currentFactorName =
                                          conditions.isNotEmpty
                                              ? conditions[index]
                                              : condition.keys.elementAt(index);

                                      // Find the track for this factor name
                                      OtherTrack? currentTrack;
                                      try {
                                        List<OtherTrack> matchingTracks =
                                            otherTrack
                                                .where(
                                                  (track) =>
                                                      track.otherFactorName ==
                                                      currentFactorName,
                                                )
                                                .toList();

                                        logger.i(
                                            "For $currentFactorName, found ${matchingTracks.length} matching tracks");

                                        if (matchingTracks.isNotEmpty) {
                                          currentTrack = matchingTracks.first;
                                          logger.i(
                                              "Selected track with value: ${currentTrack.value}");
                                        }
                                      } catch (e) {
                                        logger.e(
                                            "Error finding track for $currentFactorName: $e");
                                        currentTrack = null;
                                      }

                                      int sliderValue = 0;
                                      if (currentTrack != null &&
                                          currentTrack.value.isNotEmpty) {
                                        try {
                                          sliderValue =
                                              int.parse(currentTrack.value);
                                          logger.i(
                                              "Parsed value $sliderValue for $currentFactorName");
                                        } catch (e) {
                                          logger.e(
                                              "Failed to parse value '${currentTrack.value}': $e");
                                          sliderValue = 0;
                                        }
                                      } else {
                                        logger.i(
                                            "No value found for $currentFactorName, using 0");
                                      }

                                      return ActivitySlider(
                                        sliderLabel: currentFactorName,
                                        value: sliderValue,
                                        onChanged: (value) {
                                          // Remove existing updates for this factor
                                          updates.removeWhere((update) =>
                                              update["otherTracking"] ==
                                              condition[currentFactorName]);

                                          // Get the otherfactor ID
                                          String otherFactorId =
                                              condition[currentFactorName];

                                          // Add new update with otherfactor ID
                                          updates.add({
                                            "value": value.toString(),
                                            'date': DateFormat('yyyy-MM-dd')
                                                .format(kDay),
                                            "otherTracking": otherFactorId,
                                            "user": store.user.id,
                                          });

                                          // Update state to refresh the UI
                                          setState(() {
                                            // Update the current track in the local list to reflect changes immediately
                                            for (int i = 0;
                                                i < otherTrack.length;
                                                i++) {
                                              if (otherTrack[i]
                                                      .otherFactorName ==
                                                  currentFactorName) {
                                                otherTrack[i].value =
                                                    value.toString();
                                                break;
                                              }
                                            }
                                          });

                                          logger.i(
                                              "Added update: value=$value, otherTracking=$otherFactorId");
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const Spacer(),
              if (store.selectedDate == DateFormat('yyyy-MM-dd').format(kDay))
                CustomButton(
                  goTo: () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      for (var i in updates) {
                        await apiServices.postOtherTrack(i);
                      }
                      // Clear updates after successful submission
                      updates.clear();
                    } catch (e) {
                      logger.e("Error posting other factors: $e");
                      // Show error message to user
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to save changes")));
                    } finally {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                      }
                    }
                  },
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
