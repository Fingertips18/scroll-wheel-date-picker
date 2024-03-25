import 'package:flutter/material.dart';

import './wheel_date_picker.dart';

class ScrollItem extends StatelessWidget {
  /// Item of a [WheelDatePicker] type.
  ///
  /// [label] Label of the [WheelDatePicker] item.
  ///
  /// [textStyle] Text style of the [WheelDatePicker] item.
  const ScrollItem({
    super.key,
    required this.label,
    required this.textStyle,
  });

  /// Label of the [WheelDatePicker] item.
  final String label;

  /// Text style of the [WheelDatePicker] item.
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
