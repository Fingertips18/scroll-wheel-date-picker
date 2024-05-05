import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

class CurveLineDatePicker extends StatelessWidget {
  const CurveLineDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Curve Line Overlay",
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
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: ScrollWheelDatePicker(
            theme: CurveDatePickerTheme(
              wheelPickerHeight: 200.0,
              overlay: ScrollWheelDatePickerOverlay.line,
              monthFormat: MonthFormat.twoLetters,
              overlayColor: Colors.white,
              overAndUnderCenterOpacity: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
