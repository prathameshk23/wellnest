import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wellcare/resources/r.dart';

class CustomSlider extends StatefulWidget {
  final ValueChanged<double> onValueChanged;

  const CustomSlider({super.key, required this.onValueChanged});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0; // Initial slider value (0 to 4)
  final int divisions = 4; // Total steps

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),

        // The slider track and elements
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: R.colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _value / 4,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: R.colors.bgPrimary,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(divisions + 1, (index) {
                  return Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: index <= _value ? Colors.black : Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                thumbShape: _CustomThumbShape(),
                trackHeight: 0,
              ),
              child: Slider(
                value: _value,
                min: 0,
                max: 4,
                divisions: 4, // Allows snapping
                onChanged: (newValue) {
                  setState(() {
                    _value = newValue;
                  });
                  widget.onValueChanged(newValue);
                },
              ),
            ),
          ],
        ),

        // 🔹 Labels (Placed Outside the Container)
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Low"),
              Text("Moderate"),
              Text("High"),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Thumb
class _CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(50, 50);

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final Paint thumbPaint = Paint()..color = const Color(0xFF242E49);
    const double thumbSize = 80;
    final Rect thumbRect =
        Rect.fromCenter(center: center, width: thumbSize, height: thumbSize);
    final RRect thumbRRect =
        RRect.fromRectAndRadius(thumbRect, const Radius.circular(16));
    canvas.drawRRect(thumbRRect, thumbPaint);

    const icon = Icons.keyboard_double_arrow_right_rounded;
    final TextPainter iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 28,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconPainter.layout();
    iconPainter.paint(
        canvas,
        Offset(center.dx - iconPainter.width / 2,
            center.dy - iconPainter.height / 2));
  }
}
