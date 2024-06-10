import 'package:flutter/cupertino.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

class Issue4 extends StatelessWidget {
  const Issue4({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime initialDate = DateTime(currentDate.year - 13, 1, 1);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ScrollWheelDatePicker(
                initialDate: initialDate,
                startDate: initialDate,
                lastDate: currentDate,
                theme: CurveDatePickerTheme(
                  wheelPickerHeight: 200.0,
                  overlay: ScrollWheelDatePickerOverlay.highlight,
                  monthFormat: MonthFormat.threeLetters,
                  overlayColor: Theme.of(context).colorScheme.primary,
                  overAndUnderCenterOpacity: 0.2,
                ),
                onSelectedItemChanged: (value) {
                  debugPrint("Date: ${value.toString()}");
                },
              ),
            ),
            const SizedBox(height: 32.0),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: initialDate,
                minimumDate: initialDate,
                onDateTimeChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
