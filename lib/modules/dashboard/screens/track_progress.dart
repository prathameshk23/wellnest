import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wellcare/models/menstrual.dart';
import 'package:wellcare/modules/dashboard/screens/dashboard_screen.dart';
import 'package:wellcare/modules/dashboard/services/dash_services.dart';
import 'package:wellcare/store/app_store.dart';
import 'package:wellcare/widgets/custom_button.dart';

import '../../../resources/r.dart';
import '../../../utils/logger.dart';

final kToday = DateTime.now();

class TrackProgress extends StatefulWidget {
  const TrackProgress({super.key});

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  AppStore store = Modular.get<AppStore>();
  DashServices apiServices = DashServices();
  final List<DateTime> _selectedDates = [];
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final kFirstDay = DateTime(kToday.year - 10, kToday.month - 3, kToday.day);
  final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);
  DateTime _focusedDay = kToday;
  String month = "";
  String year = "";
  final dateFormatter = DateFormat('dd-MM-yyyy');
  List<Menstrual> menstrual = [];

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isDateSelected(DateTime day) {
    return _selectedDates.any((d) => _isSameDay(d, day));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;

      if (_isDateSelected(selectedDay)) {
        _selectedDates.removeWhere((d) => _isSameDay(d, selectedDay));
      } else {
        if (_selectedDates.length < 5) {
          _selectedDates.add(selectedDay);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You can only select 5 days.')),
          );
        }
      }
    });
  }

  @override
  void initState() {
    getMenstrualCycle(month, year);
    // TODO: implement initState
    super.initState();
  }

  Future<void> getMenstrualCycle(String month, String year) async {
    menstrual = await apiServices.getMenstrual(store.user.id, month, year);
    _selectedDates.clear();

// Loop through each menstrual entry
    for (var entry in menstrual) {
      for (var dateStr in entry.date) {
        try {
          final parsedDate = dateFormatter.parse(dateStr);
          _selectedDates.add(parsedDate);
        } catch (e) {
          print("❌ Error parsing date: $dateStr");
        }
      }
    }

// Now setState to reflect changes in UI
    setState(() {});
    logger.i(menstrual.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        title: Text("Welcome ${store.user.name}"),
        automaticallyImplyLeading: false,
        backgroundColor: R.colors.bgPrimary,
        foregroundColor: R.colors.black,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  "Track Your Cycle",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: R.colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
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
                              color: Colors.pinkAccent,
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
                            return _selectedDates.any((d) => isSameDay(d, day));
                          },
                          calendarFormat: _calendarFormat,
                          focusedDay: _focusedDay,
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          headerVisible: false,
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              month = selectedDay.month.toString();
                              year = selectedDay.year.toString();
                              _focusedDay = focusedDay;
                              final alreadySelected = _selectedDates
                                  .any((d) => isSameDay(d, selectedDay));
                              if (alreadySelected) {
                                _selectedDates.removeWhere(
                                    (d) => isSameDay(d, selectedDay));
                              } else {
                                _selectedDates.add(selectedDay);
                              }
                            });
                          },
                          onPageChanged: (newFocusedDay) async {
                            setState(() {
                              _selectedDates.clear();
                              _focusedDay = DateTime(
                                  newFocusedDay.year, newFocusedDay.month, 1);
                            });

                            // Extract month and year as strings
                            month = newFocusedDay.month.toString(); // e.g. "4"
                            year = newFocusedDay.year.toString(); // e.g. "2025"

                            // Fetch new data
                            await getMenstrualCycle(month, year);
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
                const Spacer(),
                CustomButton(
                  goTo: () async {
                    var body = {
                      "dates": _selectedDates
                          .map((d) => dateFormatter.format(d))
                          .toList(),
                      "month": month,
                      "year": year,
                      "user": store.user.id
                    };
                    await apiServices.postMenstrual(body);
                  },
                  elevation: 0,
                  buttonText: "Save",
                  buttonWidth: double.infinity,
                  buttonColor: R.colors.bgPrimary,
                  textColor: R.colors.black,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
