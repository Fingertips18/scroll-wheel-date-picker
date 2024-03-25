import 'package:flutter/material.dart';

import '../widgets/curve_scroll_wheel.dart';
import '../constants/theme_constants.dart';
import '../widgets/wheel_date_picker.dart';
import '../widgets/flat_scroll_wheel.dart';

part 'curve_date_picker_theme.dart';
part 'flat_date_picker_theme.dart';

abstract class WheelDatePickerTheme {
  /// An abstract class for common themes of the [WheelDatePicker].
  ///
  /// [wheelPickerHeight] Actual height of the [WheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  /// [itemExtent] Maximum height of each [WheelDatePicker]'s items. Defaults to [defaultItemExtent].
  /// [overAndUnderCenterOpacity] Opacity of the items in the [WheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  /// [itemTextStyle] Text style of the items in the [WheelDatePicker]. Defaults to [defaultItemTextStyle].
  WheelDatePickerTheme({
    this.wheelPickerHeight = defaultWheelPickerHeight,
    this.itemExtent = defaultItemExtent,
    this.overAndUnderCenterOpacity = defaultOpacity,
    this.itemTextStyle = defaultItemTextStyle,
  });

  /// Actual height of the [WheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  final double wheelPickerHeight;

  /// Maximum height of each [WheelDatePicker]'s items. Defaults to [defaultItemExtent].
  final double itemExtent;

  /// Opacity of the items in the [WheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  final double overAndUnderCenterOpacity;

  /// Text style of the items in the [WheelDatePicker]. Defaults to [defaultItemTextStyle].
  final TextStyle itemTextStyle;
}
