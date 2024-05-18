import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

class FlatLineDatePicker extends StatelessWidget {
  const FlatLineDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Flat Line Overlay",
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
            theme: FlatDatePickerTheme(
              backgroundColor: Colors.black,
              overlay: ScrollWheelDatePickerOverlay.line,
              itemTextStyle: defaultItemTextStyle,
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
