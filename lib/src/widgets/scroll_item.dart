import 'package:flutter/material.dart';

import 'scroll_wheel_date_picker.dart';

class ScrollItem extends StatelessWidget {
  /// Item of a [ScrollWheelDatePicker] type.
  ///
  /// [label] Label of the [ScrollWheelDatePicker] item.
  ///
  /// [textStyle] Text style of the [ScrollWheelDatePicker] item.
  const ScrollItem({
    super.key,
    required this.label,
    this.textStyle,
  });

  /// Label of the [ScrollWheelDatePicker] item.
  final String label;

  /// Text style of the [ScrollWheelDatePicker] item.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
