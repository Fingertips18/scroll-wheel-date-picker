import 'package:flutter/material.dart';

import '../themes/wheel_date_picker_theme.dart';
import '../constants/theme_constants.dart';
import '../date_controller.dart';
import 'curve_scroll_wheel.dart';
import 'flat_scroll_wheel.dart';
import 'overlays/holo_overlay.dart';
import 'overlays/line_overlay.dart';
import 'overlays/highlight_overlay.dart';

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
    this.onSelectedItemChanged,
    required this.theme,
    this.listenAfterAnimation = true,
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

  /// Callback fired when an item is changed. Returns a [DateTime].
  final Function(DateTime value)? onSelectedItemChanged;

  /// An abstract class for common themes of the `WheelDatePicker`.
  ///
  /// Types of Themes supported by the [WheelDatePickerTheme].
  ///
  /// [CurveDatePickerTheme] - Theme for the [CurveScrollWheel].
  ///
  /// [FlatDatePickerTheme] - Theme for the [FlatScrollWheel].
  final WheelDatePickerTheme theme;

  /// Whether to call the [onSelectedItemChanged] when the scroll wheel animation is completed. Defaults to `true`.
  final bool listenAfterAnimation;

  /// Selects what type of scroll wheel to use based on [theme].
  Widget _scrollWidget({
    required IDateController controller,
    Function(int value)? controllerItemChanged,
    required bool looping,
  }) {
    return theme is CurveDatePickerTheme
        ? CurveScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            onSelectedItemChanged: controllerItemChanged,
            looping: looping,
            diameterRatio: (theme as CurveDatePickerTheme).diameterRatio,
            itemExtent: theme.itemExtent,
            overAndUnderCenterOpacity: theme.overAndUnderCenterOpacity,
            textStyle: theme.itemTextStyle,
            listenAfterAnimation: listenAfterAnimation,
          )
        : FlatScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            onSelectedItemChanged: controllerItemChanged,
            looping: looping,
            itemExtent: theme.itemExtent,
            textStyle: theme.itemTextStyle,
            listenAfterAnimation: listenAfterAnimation,
          );
  }

  /// Selects center overlay base on [WheelDatePickerOverlay].
  Widget _overlay() {
    switch (theme.overlay) {
      case WheelDatePickerOverlay.highlight:
        return HightlightOverlay(
          height: theme.itemExtent,
          color: theme.overlayColor,
        );
      case WheelDatePickerOverlay.holo:
        return HoloOverlay(
          height: theme.itemExtent,
          color: theme.overlayColor,
        );
      case WheelDatePickerOverlay.line:
        return LineOverlay(
          height: theme.itemExtent,
          color: theme.overlayColor,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateController.changeMonthFormat(format: theme.monthFormat);

    return Stack(
      alignment: Alignment.center,
      children: [
        _overlay(),
        SizedBox(
          height: theme.wheelPickerHeight,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.08, 0.92, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Days
                Expanded(
                  child: ListenableBuilder(
                    listenable: _dateController,
                    builder: (_, __) => _scrollWidget(
                      controller: _dateController.dayController,
                      controllerItemChanged: (value) {
                        _dateController.changeDay(day: value);
                        onSelectedItemChanged?.call(_dateController.dateTime);
                      },
                      looping: loopDays,
                    ),
                  ),
                ),

                // Months
                Expanded(
                  child: _scrollWidget(
                    controller: _dateController.monthController,
                    controllerItemChanged: (value) {
                      _dateController.changeMonth(month: value);
                      onSelectedItemChanged?.call(_dateController.dateTime);
                    },
                    looping: loopMonths,
                  ),
                ),

                //Years
                Expanded(
                  child: _scrollWidget(
                    controller: _dateController.yearController,
                    controllerItemChanged: (value) {
                      _dateController.changeYear(year: value);
                      onSelectedItemChanged?.call(_dateController.dateTime);
                    },
                    looping: loopYears,
                  ),
                ),
              ],
            ),
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
