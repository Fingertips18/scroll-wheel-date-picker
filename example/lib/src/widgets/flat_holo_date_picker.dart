import 'package:wheel_date_picker/wheel_date_picker.dart';
import 'package:flutter/material.dart';

class FlatHoloDatePicker extends StatelessWidget {
  const FlatHoloDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Flat Holo Overlay",
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
            theme: FlatDatePickerTheme(
              backgroundColor: Colors.white,
              overlay: WheelDatePickerOverlay.holo,
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
