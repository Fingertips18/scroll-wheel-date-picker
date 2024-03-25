part of 'wheel_date_picker_theme.dart';

class CurveDatePickerTheme extends WheelDatePickerTheme {
  /// Theme for the [CurveScrollWheel].
  ///
  /// [diameterRatio] A curve ratio of the [WheelDatePicker] in the main axis. Defaults to [defaultDiameterRatio]. Must be a positive number.
  CurveDatePickerTheme({
    this.diameterRatio = defaultDiameterRatio,
    super.itemExtent,
    super.overAndUnderCenterOpacity,
    super.itemTextStyle,
  });

  /// A curve ratio of the [WheelDatePicker] in the main axis. Defaults to [defaultDiameterRatio].
  ///
  /// Must be a positive number.
  final double diameterRatio;
}
