part of 'scroll_wheel_date_picker_theme.dart';

class FlatDatePickerTheme extends ScrollWheelDatePickerTheme {
  /// Theme for the `FlatScrollWheel`. [FlatScrollWheel]
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
  /// [backgroundColor] Overlay color of the [ScrollWheelDatePicker] items that are off centered. Defaults to [Colors.transparent].

  FlatDatePickerTheme({
    super.wheelPickerHeight,
    super.itemExtent,
    super.monthFormat,
    super.overAndUnderCenterOpacity,
    super.itemTextStyle,
    super.overlay,
    super.overlayColor,
    required this.backgroundColor,
  });

  /// Overlay color of the [ScrollWheelDatePicker] items that are off centered. Defaults to [Colors.transparent].
  final Color backgroundColor;
}
