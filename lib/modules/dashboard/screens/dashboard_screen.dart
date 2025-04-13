import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wellcare/modules/dashboard/screens/home_screen.dart';
import 'package:wellcare/resources/r.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../store/app_store.dart';

final kToday = DateTime.now();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static String get linkRoute => "/dashboard";
  static String get toRoute => "/dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AppStore store = Modular.get<AppStore>();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final kFirstDay = DateTime(kToday.year - 10, kToday.month - 3, kToday.day);
  final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);
  DateTime _focusedDay = kToday;
  DateTime? _selectedDay;

  @override
  void initState() {
    setState(() {
      store.selectedDate = DateFormat('yyyy-MM-dd').format(kToday);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, context) async {
        if (didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: R.colors.white,
        appBar: AppBar(
          title: Text("Welcome ${store.user.name}"),
          automaticallyImplyLeading: false,
          backgroundColor: R.colors.bgPrimary,
          foregroundColor: R.colors.black,
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset(
                R.assets.dashPanda,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                    color: R.colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: R.colors.neutral300,
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_focusedDay.monthName()} ${_focusedDay.year}",
                            style: GoogleFonts.publicSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: R.colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TableCalendar(
                        sixWeekMonthsEnforced: true,
                        rowHeight: 40,
                        calendarStyle: CalendarStyle(
                          defaultTextStyle: GoogleFonts.publicSans(
                            fontSize: 16,
                            color: R.colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          outsideTextStyle: GoogleFonts.publicSans(
                            fontSize: 16,
                            color: R.colors.neutral400,
                            fontWeight: FontWeight.w400,
                          ),
                          todayTextStyle: GoogleFonts.publicSans(
                            fontSize: 16,
                            color: R.colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          todayDecoration: BoxDecoration(
                            color: R.colors.bgPrimary,
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: GoogleFonts.publicSans(
                            fontSize: 16,
                            color: R.colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: R.colors.bgPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: GoogleFonts.publicSans(
                            fontSize: 14,
                            color: R.colors.neutral400,
                            fontWeight: FontWeight.w400,
                          ),
                          weekendStyle: GoogleFonts.publicSans(
                            fontSize: 14,
                            color: R.colors.neutral400,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        calendarFormat: _calendarFormat,
                        focusedDay: _focusedDay,
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        headerVisible: false,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            store.selectedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDay);
                            _focusedDay = focusedDay;
                          });
                        },
                        onPageChanged: (newFocusedDay) {
                          setState(() {
                            _focusedDay = DateTime(
                                newFocusedDay.year, newFocusedDay.month, 1);
                          });
                        },
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            R.assets.startPanda,
                          ),
                          // const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "You're off to a\n great start!",
                                style: GoogleFonts.publicSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: R.colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Daily Health entry",
                                style: GoogleFonts.publicSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: R.colors.grey500,
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomButton(
                                goTo: () {
                                  Modular.to.pushNamed(HomeScreen.toRoute);
                                },
                                elevation: 0,
                                buttonText: "Start",
                                rounded: 50,
                                buttonWidth: 125.sp,
                                buttonColor: R.colors.bgPrimary,
                                textStyle: GoogleFonts.publicSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: R.colors.black,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimeExtensions on DateTime {
  String monthName() {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}
