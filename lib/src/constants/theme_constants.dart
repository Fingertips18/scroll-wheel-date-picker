import 'package:flutter/material.dart';

import '../widgets/curve_scroll_wheel.dart';
import '../widgets/wheel_date_picker.dart';

/// Default value of [WheelDatePicker]'s height. Defaults to `180.0`.
const double defaultWheelPickerHeight = 170.0;

/// Default value of [CurveScrollWheel]'s diameter ratio. Defaults to `2.0`.
const double defaultDiameterRatio = 2.0;

/// Default value of [WheelDatePicker]'s item height. Defaults to `50.0`.
const double defaultItemExtent = 50.0;

/// Default value of [WheelDatePicker]'s offcentered items opacity. Defaults to `0.1`.
const double defaultOpacity = 0.1;

/// Default value of [WheelDatePicker]'s item textstyle.
const TextStyle defaultItemTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

/// Enum for [WheelDatePicker]'s centered overlay.
enum WheelDatePickerOverlay {
  none,
  holo,
  highlight,
  line,
}

/// Default value of [WheelDatePickerOverlay.line]'s & [WheelDatePickerOverlay.holo]'s border thickness. Defaults to `2.0`.
const double defaultModeBorderThickness = 2.0;

/// Default value of [WheelDatePickerOverlay.line]'s & [WheelDatePickerOverlay.holo]'s margin. Defaults to `8.0`.
const double defaultModeMargin = 8.0;

/// Default value of [WheelDatePickerOverlay.holo]'s line spacing. Defaults to `12.0`.
const double defaultModeSpacing = 18.0;
