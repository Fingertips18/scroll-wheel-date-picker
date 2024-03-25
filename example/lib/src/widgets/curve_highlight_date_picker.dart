import 'package:wheel_date_picker/wheel_date_picker.dart';
import 'package:flutter/material.dart';

class CurveHighlightDatePicker extends StatelessWidget {
  const CurveHighlightDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Curve Highlight",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: WheelDatePicker(
            theme: CurveDatePickerTheme(
              wheelPickerHeight: 200.0,
              mode: WheelDatePickerMode.highlight,
              monthFormat: MonthFormat.threeLetters,
            ),
          ),
        ),
      ),
    );
  }
}
