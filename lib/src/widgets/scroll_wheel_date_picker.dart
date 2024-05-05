import 'package:flutter/material.dart';

import '../themes/scroll_wheel_date_picker_theme.dart';
import '../constants/theme_constants.dart';
import '../date_controller.dart';
import 'curve_scroll_wheel.dart';
import 'flat_scroll_wheel.dart';
import 'overlays/holo_overlay.dart';
import 'overlays/line_overlay.dart';
import 'overlays/highlight_overlay.dart';

class ScrollWheelDatePicker extends StatefulWidget {
  /// A scroll wheel date picker that has two types:
  ///
  /// `CurveScrollWheel` - Uses [ListWheelScrollView] to create a date picker with a curve perspective.
  ///
  /// `FlatScrollWheel` - Based on [ListWheelScrollView] to create a date picker with a flat perspective.
  const ScrollWheelDatePicker({
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
  });

  /// The initial date for the [ScrollWheelDatePicker]. Defaults to [DateTime.now].
  final DateTime? initialDate;

  /// Sets the start date for the [ScrollWheelDatePicker]. Defaults to [startDate].
  final DateTime? startDate;

  /// Sets the last date for the [ScrollWheelDatePicker]. Defaults to [lastDate].
  final DateTime? lastDate;



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
  /// Types of Themes supported by the [ScrollWheelDatePickerTheme].
  ///
  /// [CurveDatePickerTheme] - Theme for the [CurveScrollWheel].
  ///
  /// [FlatDatePickerTheme] - Theme for the [FlatScrollWheel].
  final ScrollWheelDatePickerTheme theme;

  /// Whether to call the [onSelectedItemChanged] when the scroll wheel animation is completed. Defaults to `true`.
  final bool listenAfterAnimation;

  @override
  State<ScrollWheelDatePicker> createState() => _ScrollWheelDatePickerState();
}

class _ScrollWheelDatePickerState extends State<ScrollWheelDatePicker> {
  /// Manages the initialization and changes of the [ScrollWheelDatePicker].
  late final DateController _dateController;

  @override
  void initState() {
    _dateController = DateController(
      initialDate: widget.initialDate,
      startDate: widget.startDate,
      lastDate: widget.lastDate,
    );
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }


  /// Selects what type of scroll wheel to use based on [widget.theme].
  Widget _scrollWidget({
    required IDateController controller,
    Function(int value)? controllerItemChanged,
    required bool looping,
  }) {
    return widget.theme is CurveDatePickerTheme
        ? CurveScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            onSelectedItemChanged: controllerItemChanged,
            looping: looping,
            diameterRatio: (widget.theme as CurveDatePickerTheme).diameterRatio,
            itemExtent: widget.theme.itemExtent,
            overAndUnderCenterOpacity: widget.theme.overAndUnderCenterOpacity,
            textStyle: widget.theme.itemTextStyle,
            listenAfterAnimation: widget.listenAfterAnimation,
          )
        : FlatScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            onSelectedItemChanged: controllerItemChanged,
            looping: looping,
            itemExtent: widget.theme.itemExtent,
            textStyle: widget.theme.itemTextStyle,
            listenAfterAnimation: widget.listenAfterAnimation,
          );
  }

  /// Selects center overlay base on [ScrollWheelDatePickerOverlay].
  Widget _overlay() {
    switch (widget.theme.overlay) {
      case ScrollWheelDatePickerOverlay.highlight:
        return HightlightOverlay(
          height: widget.theme.itemExtent,
          color: widget.theme.overlayColor,
        );
      case ScrollWheelDatePickerOverlay.holo:
        return HoloOverlay(
          height: widget.theme.itemExtent,
          color: widget.theme.overlayColor,
        );
      case ScrollWheelDatePickerOverlay.line:
        return LineOverlay(
          height: widget.theme.itemExtent,
          color: widget.theme.overlayColor,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateController.changeMonthFormat(format: widget.theme.monthFormat);

    return Stack(
      alignment: Alignment.center,
      children: [
        _overlay(),
        SizedBox(
          height: widget.theme.wheelPickerHeight,
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
                    listenable:_dateController,
                    builder: (_, __) => _scrollWidget(
                      controller: _dateController.dayController,
                      controllerItemChanged: (value) {
                        _dateController.changeDay(day: value);
                        widget.onSelectedItemChanged?.call(_dateController.dateTime);
                      },
                      looping: widget.loopDays,
                    ),
                  ),
                ),

                // Months
                Expanded(
                  child: _scrollWidget(
                    controller: _dateController.monthController,
                    controllerItemChanged: (value) {
                      _dateController.changeMonth(month: value);
                      widget.onSelectedItemChanged?.call(_dateController.dateTime);
                    },
                    looping: widget.loopMonths,
                  ),
                ),

                //Years
                Expanded(
                  child: _scrollWidget(
                    controller: _dateController.yearController,
                    controllerItemChanged: (value) {
                      _dateController.changeYear(year: value);
                      widget.onSelectedItemChanged?.call(_dateController.dateTime);
                    },
                    looping: widget.loopYears,
                  ),
                ),
              ],
            ),
          ),
        ),
        widget.theme is FlatDatePickerTheme
            ? IgnorePointer(
                child: SizedBox(
                  height: defaultWheelPickerHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: (widget.theme as FlatDatePickerTheme).backgroundColor.withOpacity(
                                  1.0 - widget.theme.overAndUnderCenterOpacity.clamp(0.0, 1.0),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultItemExtent),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: (widget.theme as FlatDatePickerTheme).backgroundColor.withOpacity(
                                  1.0 - widget.theme.overAndUnderCenterOpacity.clamp(0.0, 1.0),
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
