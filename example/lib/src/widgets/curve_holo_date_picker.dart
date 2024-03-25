import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

class CurveHoloDatePicker extends StatelessWidget {
  const CurveHoloDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Curve Holo Overlay",
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
          child: ScrollWheelDatePicker(
            theme: CurveDatePickerTheme(
              wheelPickerHeight: 200.0,
              overlay: ScrollWheelDatePickerOverlay.holo,
              itemTextStyle: defaultItemTextStyle.copyWith(color: Colors.black),
              overlayColor: Colors.black,
              overAndUnderCenterOpacity: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
