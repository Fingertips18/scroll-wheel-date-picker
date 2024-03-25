part of 'scroll_wheel_date_picker_theme.dart';

class CurveDatePickerTheme extends ScrollWheelDatePickerTheme {
  /// Theme for the `CurveScrollWheel`. [CurveScrollWheel]
  ///
  /// [wheelPickerHeight] Actual height of the [ScrollWheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  ///
  /// [itemExtent] Maximum height of each [ScrollWheelDatePicker]'s items. Defaults to [defaultItemExtent].
  ///
  /// [overAndUnderCenterOpacity] Opacity of the items in the [ScrollWheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  ///
  /// [monthFormat] Format of the month in the [ScrollWheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [itemTextStyle] Text style of the items in the [ScrollWheelDatePicker]. Defaults to [defaultItemTextStyle].
  ///
  /// [overlay] Apply selected item's center overlay. Defaults to [ScrollWheelDatePickerOverlay.holo].
  ///
  /// [overlayColor] Selected item's center design color. Defaults to [Colors.black].
  ///
  /// [diameterRatio] A curve ratio of the [ScrollWheelDatePicker] in the main axis. Defaults to [defaultDiameterRatio]. Must be a positive number.
  CurveDatePickerTheme({
    super.wheelPickerHeight,
    this.diameterRatio = defaultDiameterRatio,
    super.itemExtent,
    super.overAndUnderCenterOpacity,
    super.monthFormat,
    super.itemTextStyle,
    super.overlay,
    super.overlayColor,
  });

  /// A curve ratio of the [ScrollWheelDatePicker] in the main axis. Defaults to [defaultDiameterRatio].
  ///
  /// Must be a positive number.
  final double diameterRatio;
}
