import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/models/conditions.dart';
import 'package:wellcare/modules/auth/auth_module.dart';
import 'package:wellcare/modules/auth/screens/describe_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/store/app_store.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../services/auth_service.dart';

final List<String> ages = [
  "Under 18",
  "18-24",
  "25-34",
  "35-44",
  "45-54",
  "55-64",
  "65-74",
  "75+"
];

final List<String> wellnessGoals = [
  "Better sleep",
  "Mood Tracking",
  "Medication",
  "Stress Management",
  "General Health",
  "Other"
];

class UserSetupScreen extends StatefulWidget {
  const UserSetupScreen({super.key});

  static String get linkRoute => '/user_setup/';
  static String get toRoute => "${AuthModule.moduleRoute}user_setup/";

  @override
  State<UserSetupScreen> createState() => _UserSetupScreenState();
}

class _UserSetupScreenState extends State<UserSetupScreen> {
  String dropdownValue = ages.first;
  bool isMenstrualCycle = false;
  bool isSelected = false;
  Map<String, bool> selectedGoals = {};
  late List<Symptoms> symptoms;
  final AppStore store = Modular.get<AppStore>();
  AuthServices apiServices = AuthServices();

  @override
  void initState() {
    super.initState();
    // symptoms = apiServices.getAllSymptoms();
    // getSymptoms();
    // logger.i(symptoms);
    for (String goal in wellnessGoals) {
      selectedGoals[goal] = false; // Initialize all as unselected
    }
  }

  Future<void> getSymptoms() async {
    symptoms = await apiServices.getAllSymptoms();
  }

  void function() {
    try {
      store.ageGroup = dropdownValue;
      store.trackMenstrual = isMenstrualCycle;
      store.wellnessGoals = selectedGoals.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
      print(store.wellnessGoals);
      print(store.ageGroup);
      Modular.to.pushNamed(DescribeScreen.toRoute);
    } catch (e) {
      print(e);
    }
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
        title: Text(
          "User Profile Setup",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: R.colors.black,
          ),
        ),
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
                Text(
                  "📌 Let’s Personalize Your Experience!",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "📝 Questions:",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What's your age group?",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: R.colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: R.colors.neutral300),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DropdownButton(
                        underline: Container(),
                        elevation: 0,
                        dropdownColor: R.colors.grey100,
                        borderRadius: BorderRadius.circular(9),
                        value: dropdownValue,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            ages.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Do you have any specific wellness goals?",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: R.colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 8, // Horizontal spacing between chips
                      runSpacing: 8, // Vertical spacing between rows
                      children: wellnessGoals.map((goal) {
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
                          label: Text(goal),
                          selected:
                              selectedGoals.putIfAbsent(goal, () => false),
                          onSelected: (bool value) {
                            setState(() {
                              selectedGoals[goal] = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  goTo: () {
                    function();
                    // Modular.to.pushNamed(DescribeScreen.toRoute);
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
