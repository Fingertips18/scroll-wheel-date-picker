import 'package:flutter/material.dart';

import '../widgets/scroll_wheel_date_picker.dart';
import '../widgets/curve_scroll_wheel.dart';
import '../constants/theme_constants.dart';
import '../widgets/flat_scroll_wheel.dart';
import '../constants/date_constants.dart';

part 'curve_date_picker_theme.dart';
part 'flat_date_picker_theme.dart';

abstract class ScrollWheelDatePickerTheme {
  /// An abstract class for common themes of the `ScrollWheelDatePicker`. [ScrollWheelDatePicker]
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
  /// [overlayColor] Selected item's center design color.
  ScrollWheelDatePickerTheme({
    this.wheelPickerHeight = defaultWheelPickerHeight,
    this.itemExtent = defaultItemExtent,
    this.overAndUnderCenterOpacity = defaultOpacity,
    this.monthFormat = MonthFormat.full,
    this.itemTextStyle = defaultItemTextStyle,
    this.overlay = ScrollWheelDatePickerOverlay.holo,
    this.overlayColor,
  });

  /// Actual height of the [ScrollWheelDatePicker] widget. Defaults to [defaultWheelPickerHeight].
  final double wheelPickerHeight;

  /// Maximum height of each [ScrollWheelDatePicker]'s items. Defaults to [defaultItemExtent].
  final double itemExtent;

  /// Opacity of the items in the [ScrollWheelDatePicker] that are off centered. Defaults to [defaultOpacity].
  final double overAndUnderCenterOpacity;

  /// Format of the month in the [ScrollWheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [MonthFormat.full] - Shows the full name of the month.
  ///
  /// [MonthFormat.threeLetters] - Shows the three letters abbreviations of the month.
  ///
  /// [MonthFormat.twoLetters] - Shows the two letters abbreviations of the month.
  final MonthFormat monthFormat;

  /// Text style of the items in the [ScrollWheelDatePicker]. Defaults to [defaultItemTextStyle].
  final TextStyle itemTextStyle;

  /// Apply selected item's center overlay. Defaults to [ScrollWheelDatePickerOverlay.holo].
  final ScrollWheelDatePickerOverlay overlay;

  /// Selected item's center overlay color.
  ///
  /// If overlay is [ScrollWheelDatePickerOverlay.holo] then this defaults to [Colors.white].
  ///
  /// If overlay is [ScrollWheelDatePickerOverlay.highlight] then this defaults to [Colors.grey] with an opacity of `0.1`.
  ///
  /// If overlay is [ScrollWheelDatePickerOverlay.line] then this defaults to [Colors.white].
  final Color? overlayColor;
}
