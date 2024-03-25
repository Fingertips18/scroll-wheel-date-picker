import 'package:wheel_date_picker/wheel_date_picker.dart';
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
          "Flat Line",
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
          child: WheelDatePicker(
            theme: FlatDatePickerTheme(
              backgroundColor: Colors.black,
              mode: WheelDatePickerMode.line,
              monthFormat: MonthFormat.twoLetters,
              modeColor: Colors.white,
              overAndUnderCenterOpacity: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
