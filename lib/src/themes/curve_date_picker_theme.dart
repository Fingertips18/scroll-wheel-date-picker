part of 'wheel_date_picker_theme.dart';

class CurveDatePickerTheme extends WheelDatePickerTheme {
  /// Theme for the `CurveScrollWheel`. [CurveScrollWheel]
  ///
  /// [wheelPickerHeight] Actual height of the [WheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  ///
  /// [itemExtent] Maximum height of each [WheelDatePicker]'s items. Defaults to [defaultItemExtent].
  ///
  /// [overAndUnderCenterOpacity] Opacity of the items in the [WheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  ///
  /// [monthFormat] Format of the month in the [WheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [itemTextStyle] Text style of the items in the [WheelDatePicker]. Defaults to [defaultItemTextStyle].
  ///
  /// [mode] Apply selected item's center design. Defaults to [WheelDatePickerMode.holo].
  ///
  /// [modeColor] Selected item's center design color. Defaults to [Colors.black].
  ///
  /// [diameterRatio] A curve ratio of the [WheelDatePicker] in the main axis. Defaults to [defaultDiameterRatio]. Must be a positive number.
  CurveDatePickerTheme({
    super.wheelPickerHeight,
    this.diameterRatio = defaultDiameterRatio,
    super.itemExtent,
    super.overAndUnderCenterOpacity,
    super.monthFormat,
    super.itemTextStyle,
    super.mode,
    super.modeColor,
  });

  /// A curve ratio of the [WheelDatePicker] in the main axis. Defaults to [defaultDiameterRatio].
  ///
  /// Must be a positive number.
  final double diameterRatio;
}
