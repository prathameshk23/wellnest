import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wellcare/models/user_symptoms.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/modules/dashboard/widget/activity_slider.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../models/symptoms_track.dart';
import '../../../store/app_store.dart';
import '../../../utils/logger.dart';
import '../services/dash_services.dart';

final kToday = DateTime.now();

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({super.key});

  static String get linkRoute => "/symptomsScreen";
  static String get toRoute => "${DashboardModule.moduleRoute}/symptomsScreen";

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  final kDay = DateTime(kToday.year, kToday.month, kToday.day);
  List<UserSymptoms> symptoms = [];
  List<SymptomsTrack> symptomsTrack = [];
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
    symptoms = await apiServices.getUserSymptoms(store.user.id);
    symptomsTrack = await apiServices.getSymptomsTrack(store.user.id);
    logger.i(symptoms);
    setState(() {});
  }

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
                  "Symptoms",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: R.colors.black,
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: SvgPicture.asset(
                    R.assets.germs,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                      child: symptoms.isEmpty
                          ? const Center(child: Text("Loading...."))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: symptoms.length,
                              itemBuilder: (context, index) {
                                final symptomId = symptoms[index].id;

                                final matchedTrack = symptomsTrack.firstWhere(
                                  (track) => track.userSymptomId == symptomId,
                                  orElse: () => SymptomsTrack(
                                    value: "0",
                                    id: '',
                                    date: DateTime.now(),
                                    userSymptomId: '',
                                    userId: '',
                                  ),
                                );

                                final sliderValue =
                                    int.tryParse(matchedTrack.value) ?? 0;

                                return ActivitySlider(
                                  sliderLabel: symptoms[index].symptom.name,
                                  value: sliderValue,
                                  onChanged: (value) {
                                    final symptomId = symptoms[index].id;

                                    updates.removeWhere((update) =>
                                        update["userSymptomId"] == symptomId);

                                    updates.add({
                                      "value": value,
                                      'date':
                                          DateFormat('yyyy-MM-dd').format(kDay),
                                      "userSymptom": symptoms[index].id,
                                      "user": symptoms[index].userId,
                                    });
                                    logger.i(updates);
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                ),
                if (store.selectedDate == DateFormat('yyyy-MM-dd').format(kDay))
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      goTo: () async {
                        for (var i in updates) {
                          await apiServices.postSymptomsTrack(i);
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
