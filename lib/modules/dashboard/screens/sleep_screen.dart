import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../models/sleep_track.dart';
import '../../../store/app_store.dart';
import '../services/dash_services.dart';

final kToday = DateTime.now();

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  static String get linkRoute => "/sleepScreen";
  static String get toRoute => "${DashboardModule.moduleRoute}/sleepScreen";

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final kDay = DateTime(kToday.year, kToday.month, kToday.day);
  List<SleepTrack> sleepTrack = [];
  int? selectedQuality;
  int sleepTime = 0;
  String? selectedFactor;
  final AppStore store = Modular.get<AppStore>();
  DashServices apiServices = DashServices();

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
    sleepTrack = await apiServices.getSleepTrack(store.user.id);
    selectedQuality = int.tryParse(sleepTrack[0].sleepQuality);
    sleepTime = int.tryParse(sleepTrack[0].sleepTime)!;
    toggleFactor(sleepTrack[0].sleepFacrtor);
    setState(() {});
  }

  void toggleFactor(String factor) {
    print(factor);
    setState(() {
      if (selectedFactor == factor) {
        selectedFactor = null;
      } else {
        selectedFactor = factor;
      }
    });
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
      body: SafeArea(
        child: Stack(
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
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd('en_US')
                                  .format(DateTime.parse(store.selectedDate)),
                              style: GoogleFonts.publicSans(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: R.colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Sleep",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: R.colors.black,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "💤 Sleep Quality",
                            style: GoogleFonts.publicSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: R.colors.black,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedQuality = index;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          color: R.colors.neutral300),
                                      fixedSize: const Size(30, 30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: selectedQuality == index
                                          ? Colors.blue
                                          : Colors.white,
                                      foregroundColor: selectedQuality == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    child: Text(index.toString()),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Text(
                            "🌙 Time asleep",
                            style: GoogleFonts.publicSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: R.colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (sleepTime > 0) sleepTime--;
                                  });
                                },
                                icon:
                                    const Icon(Icons.remove, color: Colors.red),
                              ),
                              Text("$sleepTime hrs",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    sleepTime++;
                                  });
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.green),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Text(
                            "🙂 Any sleep factors from last night?",
                            style: GoogleFonts.publicSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: R.colors.black,
                            ),
                          ),
                          Wrap(
                            spacing: 10,
                            children:
                                ["Early Bedtime", "Late Bedtime"].map((factor) {
                              return ElevatedButton(
                                onPressed: () => toggleFactor(factor),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: R.colors.neutral300),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: selectedFactor == factor
                                      ? Colors.blue
                                      : Colors.white,
                                  foregroundColor: selectedFactor == factor
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                child: Text(factor),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (store.selectedDate == DateFormat('yyyy-MM-dd').format(kDay))
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      goTo: () async {
                        var body = {
                          "sleep_quality": selectedQuality,
                          "sleep_factor": selectedFactor,
                          "sleep_time": sleepTime,
                          'date': DateFormat('yyyy-MM-dd').format(kDay),
                          "user": store.user.id
                        };
                        await apiServices.postSleepTrack(body);
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
                  )
                else
                  const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
