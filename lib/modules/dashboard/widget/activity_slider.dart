import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellcare/resources/r.dart';

class ActivitySlider extends StatefulWidget {
  final String sliderLabel;
  final int value;
  final ValueChanged<int> onChanged;

  const ActivitySlider({
    super.key,
    required this.sliderLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  _ActivitySliderState createState() => _ActivitySliderState();
}

class _ActivitySliderState extends State<ActivitySlider> {
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  Color _getNumberColor(int value) {
    switch (value) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.lightGreen;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.orangeAccent;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.sliderLabel,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: R.colors.black,
              ),
            ),
            Text(
              '$_currentValue',
              style: GoogleFonts.publicSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _getNumberColor(_currentValue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Slider
        Slider(
          value: _currentValue.toDouble(),
          min: 0,
          max: 4,
          divisions: 4,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey.shade300,
          onChanged: (newValue) {
            setState(() {
              _currentValue = newValue.round();
            });
            widget.onChanged(_currentValue);
          },
        ),
      ],
    );
  }
}
