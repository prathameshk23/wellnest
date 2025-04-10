import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/auth/screens/adopt_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/store/app_store.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../models/conditions.dart';
import '../../../utils/logger.dart';
import '../services/auth_service.dart';

// final List<String> conditions = [
//   "Anxiety",
//   "Headache",
//   "Migraine",
//   "Stress",
//   "Fatigue",
//   "Depression",
//   "Muscle Pain",
//   "Joint Pain",
//   "Nausea",
//   "Dizziness",
//   "Chest Pain",
//   "Stomach Pain",
//   "Back Pain",
//   "Heartburn",
//   "Menstrual Cramps",
//   "Tension Headache",
//   "Neck Pain",
//   "Skin Irritation",
//   "Burning Sensation",
//   "Restless Legs",
//   "Shivering/Chills",
//   "Breathing Difficulty",
// ];

class ConditionScreen extends StatefulWidget {
  const ConditionScreen({super.key});

  static String get linkRoute => '/condition/';
  static String get toRoute => "${AuthModule.moduleRoute}condition/";

  @override
  State<ConditionScreen> createState() => _ConditionScreenState();
}

class _ConditionScreenState extends State<ConditionScreen> {
  Map<String, bool> selectedCondition = {};
  final AppStore store = Modular.get<AppStore>();
  final int maxSelections = 6;
  final List<String> conditions = [];
  List<Symptoms> symptoms = [];
  AuthServices apiServices = AuthServices();

  void initState() {
    super.initState();
    getSymptoms();
    // logger.i(symptoms);
    // conditions = symptoms.map((e) => e.name).toList();
  }

  Future<void> getSymptoms() async {
    symptoms = await apiServices.getAllSymptoms();
    // conditions = symptoms.map((e) => e.name).toList();
    setState(() {});
  }

  // Future<Symptoms> getSymptoms() async {
  //   symptoms = await apiServices.getAllSymptoms();
  // }

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
                        color: R.colors.black,
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
                    "Do you have any of these conditions or disorders?",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: R.colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "we do not share your data. This information will help you get set up faster",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: R.colors.grey500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                symptoms.isEmpty
                    ? Text("Loading.....")
                    : Wrap(
                        spacing: 8, // Horizontal spacing between chips
                        runSpacing: 8, // Vertical spacing between rows
                        children: symptoms.map((e) {
                          String name = e.name;
                          String id = e.id;

                          bool isSelected = selectedCondition[id] ?? false;

                          return ChoiceChip(
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return BorderSide(
                                    color: R.colors.bgPrimary,
                                    width: 2,
                                  );
                                }
                                return BorderSide(
                                  color: R.colors.neutral300,
                                  width: 2,
                                );
                              },
                            ),
                            selectedColor: R.colors.bgPrimary,
                            backgroundColor: R.colors.white,
                            label: Text(
                              name,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (bool value) {
                              int selectedCount = selectedCondition.values
                                  .where((v) => v)
                                  .length;
                              if (value && selectedCount >= maxSelections) {
                                Fluttertoast.showToast(
                                  backgroundColor: R.colors.green200,
                                  msg:
                                      "You can select up to $maxSelections conditions only!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                                return;
                              }
                              setState(() {
                                selectedCondition[id] = value;
                              });
                            },
                          );
                        }).toList()),
                const Spacer(),
                CustomButton(
                  goTo: () {
                    logger.i(selectedCondition);
                    logger.i(selectedCondition.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList());
                    store.symptoms = selectedCondition.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();
                    Modular.to.pushNamed(AdoptScreen.toRoute);
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
