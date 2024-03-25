part of 'wheel_date_picker_theme.dart';

class FlatDatePickerTheme extends WheelDatePickerTheme {
  /// Theme for the [FlatScrollWheel].
  ///
  /// [backgroundColor] Overlay color of the [WheelDatePicker] items that are off centered. Defaults to [Colors.transparent].
  FlatDatePickerTheme({
    super.itemExtent,
    super.overAndUnderCenterOpacity,
    super.itemTextStyle,
    required this.backgroundColor,
  });

  /// Overlay color of the [WheelDatePicker] items that are off centered. Defaults to [Colors.transparent].
  final Color backgroundColor;
}
