part of 'wheel_date_picker_theme.dart';

class FlatDatePickerTheme extends WheelDatePickerTheme {
  /// Theme for the `FlatScrollWheel`. [FlatScrollWheel]
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
  /// [backgroundColor] Overlay color of the [WheelDatePicker] items that are off centered. Defaults to [Colors.transparent].

  FlatDatePickerTheme({
    super.wheelPickerHeight,
    super.itemExtent,
    super.monthFormat,
    super.overAndUnderCenterOpacity,
    super.itemTextStyle,
    super.mode,
    super.modeColor,
    required this.backgroundColor,
  });

  /// Overlay color of the [WheelDatePicker] items that are off centered. Defaults to [Colors.transparent].
  final Color backgroundColor;
}
