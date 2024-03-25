import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/wheel_date_picker_theme.dart';
import '../constants/theme_constants.dart';
import '../constants/date_constants.dart';
import '../date_controller.dart';
import 'curve_scroll_wheel.dart';
import 'flat_scroll_wheel.dart';

class WheelDatePicker extends StatelessWidget {
  /// A scroll wheel date picker that has two types:
  ///
  /// `CurveScrollWheel` - Uses [ListWheelScrollView] to create a date picker with a curve perspective.
  ///
  /// `FlatScrollWheel` - Based on [ListWheelScrollView] to create a date picker with a flat perspective.
  WheelDatePicker({
    super.key,
    this.initialDate,
    this.startDate,
    this.lastDate,
    this.loopDays = true,
    this.loopMonths = true,
    this.loopYears = false,
    this.monthFormat = MonthFormat.full,
    this.onSelectedItemChanged,
    required this.theme,
  }) : _dateController = DateController(
          initialDate: initialDate,
          startDate: startDate,
          lastDate: lastDate,
        );

  /// The initial date for the [WheelDatePicker]. Defaults to [DateTime.now].
  final DateTime? initialDate;

  /// Sets the start date for the [WheelDatePicker]. Defaults to [startDate].
  final DateTime? startDate;

  /// Sets the last date for the [WheelDatePicker]. Defaults to [lastDate].
  final DateTime? lastDate;

  /// Manages the initialization and changes of the [WheelDatePicker].
  final DateController _dateController;

  /// Whether to loop through all of the items in the days scroll wheel. Defaults to `true`.
  final bool loopDays;

  /// Whether to loop through all of the items in the months scroll wheel. Defaults to `true`.
  final bool loopMonths;

  /// Whether to loop through all of the items in the years scroll wheel. Defaults to `false`.
  final bool loopYears;

  /// Format of the month in the [WheelDatePicker]. Defaults to [MonthFormat.full].
  ///
  /// [MonthFormat.full] - Shows the full name of the month.
  ///
  /// [MonthFormat.threeLetters] - Shows the three letters abbreviations of the month.
  ///
  /// [MonthFormat.twoLetters] - Shows the two letters abbreviations of the month.
  final MonthFormat monthFormat;

  /// Callback fired when an item is changed. Returns a [DateTime].
  final Function(int value)? onSelectedItemChanged;

  /// An abstract class for common themes of the [WheelDatePicker].
  ///
  /// Types of Themes supported by the [WheelDatePickerTheme].
  ///
  /// [CurveDatePickerTheme] - Theme for the [CurveScrollWheel].
  ///
  /// [FlatDatePickerTheme] - Theme for the [FlatScrollWheel].
  final WheelDatePickerTheme theme;

  /// Selects what type of scroll wheel to use based on [theme].
  Widget _scrollWidget({
    required IDateController controller,
    required Function(int value) controllerItemChanged,
    required bool looping,
  }) {
    return theme is CurveDatePickerTheme
        ? CurveScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            controllerItemChanged: controllerItemChanged,
            onSelectedItemChanged: onSelectedItemChanged,
            looping: looping,
            diameterRatio: (theme as CurveDatePickerTheme).diameterRatio,
            itemExtent: theme.itemExtent,
            overAndUnderCenterOpacity: theme.overAndUnderCenterOpacity,
            textStyle: theme.itemTextStyle,
          )
        : FlatScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            controllerItemChanged: controllerItemChanged,
            onSelectedItemChanged: onSelectedItemChanged,
            looping: looping,
            itemExtent: theme.itemExtent,
            textStyle: theme.itemTextStyle,
          );
  }

  @override
  Widget build(BuildContext context) {
    _dateController.changeMonthFormat(format: monthFormat);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: defaultItemExtent,
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
          ),
        ),
        SizedBox(
          height: defaultWheelPickerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Days
              Expanded(
                child: ListenableBuilder(
                  listenable: _dateController,
                  builder: (_, __) => _scrollWidget(
                    controller: _dateController.dayController,
                    controllerItemChanged: (value) => _dateController.changeDay(day: value),
                    looping: loopDays,
                  ),
                ),
              ),

              // Months
              Expanded(
                child: _scrollWidget(
                  controller: _dateController.monthController,
                  controllerItemChanged: (value) => _dateController.changeMonth(month: value),
                  looping: loopMonths,
                ),
              ),

              //Years
              Expanded(
                child: _scrollWidget(
                  controller: _dateController.yearController,
                  controllerItemChanged: (value) => _dateController.changeYear(year: value),
                  looping: loopYears,
                ),
              ),
            ],
          ),
        ),
        theme is FlatDatePickerTheme
            ? IgnorePointer(
                child: SizedBox(
                  height: defaultWheelPickerHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: (theme as FlatDatePickerTheme).backgroundColor.withOpacity(
                                  1.0 - theme.overAndUnderCenterOpacity.clamp(0.0, 1.0),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultItemExtent),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: (theme as FlatDatePickerTheme).backgroundColor.withOpacity(
                                  1.0 - theme.overAndUnderCenterOpacity.clamp(0.0, 1.0),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
