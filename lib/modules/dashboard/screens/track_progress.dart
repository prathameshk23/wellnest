import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TrackProgress extends StatefulWidget {
  const TrackProgress({super.key});

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  final List<DateTime> _selectedDates = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  void _saveCycleDays() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cycle days saved: ${_selectedDates.map((d) => d.toString().split(' ')[0]).join(', ')}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  color: Colors.pink[700],
                ),
              ),
              const SizedBox(height: 12),
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => _isDateSelected(day),
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  setState(() => _calendarFormat = format);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.grey[600]),
                  defaultTextStyle: TextStyle(color: Colors.grey[800]),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink[800],
                  ),
                ),
              ),
            ],
          ),
          // Save button
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton.extended(
              onPressed: _saveCycleDays,
              icon: Icon(Icons.save),
              label: Text("Save"),
              backgroundColor: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
