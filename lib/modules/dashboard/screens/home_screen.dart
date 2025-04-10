import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wellcare/models/mood_track.dart';
import 'package:wellcare/modules/dashboard/dashboard_module.dart';
import 'package:wellcare/modules/dashboard/screens/gratitude_screen.dart';
import 'package:wellcare/modules/dashboard/screens/health_check_in_screen.dart';
import 'package:wellcare/modules/dashboard/screens/other_factors_screen.dart';
import 'package:wellcare/modules/dashboard/screens/sleep_screen.dart';
import 'package:wellcare/modules/dashboard/screens/symptoms_screen.dart';
import 'package:wellcare/modules/dashboard/widget/custom_card.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/utils/logger.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../store/app_store.dart';
import '../services/dash_services.dart';

final List<String> mood = [
  "Happy",
  "Sad",
  "Depressed",
  "Calm",
  "Excited",
  "Anxious",
  "Angry",
  "Stressed",
  "Tired",
  "Greatfull",
  "Sleepy",
  "Energetic",
];

final kToday = DateTime.now();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String get linkRoute => "/homeScreen";
  static String get toRoute => "${DashboardModule.moduleRoute}/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final kDay = DateTime(kToday.year, kToday.month, kToday.day);
  Map<String, bool> selectedMood = {};
  List<MoodTrack> moodTrack = [];

  int _selectedMoodIndex = 0;
  final PageController _pageController = PageController(
    viewportFraction: 0.4, // Show side emojis partially
    initialPage: 0,
  );

  final List<Map<String, dynamic>> _moods = [
    {"svg": R.assets.depressionIcon, "color": R.colors.blue500},
    {"svg": R.assets.sadIcon, "color": R.colors.blue500},
    {"svg": R.assets.neutralIcon, "color": R.colors.blue500},
    {"svg": R.assets.happyIcon, "color": R.colors.blue500},
    {"svg": R.assets.excitedIcon, "color": R.colors.blue500},
  ];
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
    // logger.i(symptoms);
    // conditions = symptoms.map((e) => e.name).toList();
  }

  //
  Future<void> getSymptoms() async {
    moodTrack = await apiServices.getMoodTrack(store.user.id);
    // symptomsTrack = await apiServices.getSymptomsTrack(store.user.id);

    // Set the selected mood index from moodTrack data
    _selectedMoodIndex = int.tryParse(
          moodTrack.isNotEmpty ? moodTrack.first.value : '0',
        ) ??
        0;

    // Set the selected mood tags from moodTrack data
    if (moodTrack.isNotEmpty && moodTrack.first.moods != null) {
      for (String tag in moodTrack.first.moods!) {
        selectedMood[tag] = true;
      }
    }

    // logger.i(otherTrack);
    setState(() {});
  }

  void _showMoodPicker() {
    // Set the page controller to the selected mood index
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_selectedMoodIndex);
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 20,
      backgroundColor: R.colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            int forceRebuild = 0;

            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Mood Picker (PageView)
                    SvgPicture.asset(R.assets.downArrow),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _moods.length,
                        onPageChanged: (index) {
                          setSheetState(() {
                            _selectedMoodIndex = index;
                            forceRebuild++;
                          });
                        },
                        itemBuilder: (context, index) {
                          double scale = (_selectedMoodIndex == index)
                              ? 1.3
                              : 0.9; // Scale effect
                          double opacity = (_selectedMoodIndex == index)
                              ? 1.0
                              : 0.5; // Dim side emojis

                          return AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: opacity,
                            child: Transform.scale(
                              scale: scale,
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (_selectedMoodIndex == index) ...[
                                      Container(
                                        width: 150.h,
                                        height: 150.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: _moods[index]["color"]
                                              .withOpacity(0.15),
                                        ),
                                      ),
                                      Container(
                                        width: 130.h,
                                        height: 130.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: _moods[index]["color"]
                                              .withOpacity(0.25),
                                        ),
                                      ),
                                      Container(
                                        width: 115.h,
                                        height: 115.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: _moods[index]["color"]
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                    SvgPicture.asset(
                                      _moods[index]["svg"],
                                      height: 100.h,
                                      width: 100.h,
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        _selectedMoodIndex == index
                                            ? _moods[index]["color"]
                                            : Colors.grey[500]!,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SvgPicture.asset(R.assets.upArrow),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "How are you feeling?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: mood.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5,
                        ),
                        itemBuilder: (context, index) {
                          bool isSelected = selectedMood[mood[index]] ?? false;
                          return ChoiceChip(
                            padding: const EdgeInsets.all(0),
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
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
                            label: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 75,
                              child: Text(
                                mood[index],
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (bool value) {
                              setSheetState(() {
                                forceRebuild++;
                                selectedMood[mood[index]] = value;
                              });
                            },
                          );
                        },
                      ),
                    ),
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
                      goTo: () async {
                        var body = {
                          "value": _selectedMoodIndex,
                          "moods": selectedMood.entries
                              .where((entry) => entry.value == true)
                              .map((entry) => entry.key)
                              .toList(),
                          "date": DateFormat('yyyy-MM-dd').format(kDay),
                          'user': store.user.id
                        };
                        await apiServices.postMoodTrack(body);
                      },
                      // onPressed: () {
                      //   // Save the selected mood and tags
                      //   Navigator.pop(context);
                      // },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Don't reset the _selectedMoodIndex to preserve the selection
      // _selectedMoodIndex = 0;
    });
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
                        Text(
                          "Select an option.",
                          style: GoogleFonts.publicSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                  ),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: _showMoodPicker,
                        child: const CustomCard(
                          cardEmoji: "😊",
                          cardTitle: "Mood",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(SymptomsScreen.toRoute);
                        },
                        child: const CustomCard(
                          cardEmoji: "💊",
                          cardTitle: "Symptoms",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(OtherFactorsScreen.toRoute);
                        },
                        child: const CustomCard(
                          cardEmoji: "🤘",
                          cardTitle: "Other factors",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(GratitudeScreen.toRoute);
                        },
                        child: const CustomCard(
                          cardEmoji: "✨",
                          cardTitle: "Gratitude",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(SleepScreen.toRoute);
                        },
                        child: const CustomCard(
                          cardEmoji: "😴",
                          cardTitle: "Sleep",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed(HealthCheckInScreen.toRoute);
                        },
                        child: const CustomCard(
                          cardEmoji: "💜",
                          cardTitle: "Check-in",
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
