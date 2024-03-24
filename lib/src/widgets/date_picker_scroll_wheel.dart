import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/date_controller.dart';
import '../constants/theme_constants.dart';
import 'curve_scroll_wheel.dart';
import 'flat_scroll_wheel.dart';

class DatePickerScrollWheel extends StatelessWidget {
  DatePickerScrollWheel({
    super.key,
    DateController? dateController,
    this.loopDays = true,
    this.loopMonths = true,
    this.loopYears = false,
    this.scrollWheel = ScrollWheel.curve,
    this.overAndUnderCenterOpacity = kNotActiveItemOpacity,
    this.backgroundColor,
  })  : dateController = dateController ?? DateController.empty(),
        assert(
          scrollWheel == ScrollWheel.flat && backgroundColor != null,
          "If scroll wheel is flat, specify a background color",
        );

  final DateController dateController;
  final bool loopDays;
  final bool loopMonths;
  final bool loopYears;
  final ScrollWheel scrollWheel;
  final double overAndUnderCenterOpacity;
  final Color? backgroundColor;

  Widget _scrollWidget({
    required IController controller,
    Function(int value)? onSelectedItemChanged,
    required bool looping,
  }) {
    return scrollWheel == ScrollWheel.curve
        ? CurveScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            onSelectedItemChanged: onSelectedItemChanged,
            looping: looping,
          )
        : FlatScrollWheel(
            items: controller.items,
            selectedIndex: controller.selectedIndex,
            onSelectedItemChanged: onSelectedItemChanged,
            looping: looping,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: kDefaultItemHeight,
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
          ),
        ),
        SizedBox(
          height: kDefaultWheelPickerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Days
              Expanded(
                child: ListenableBuilder(
                  listenable: dateController,
                  builder: (_, __) => _scrollWidget(
                    controller: dateController.dayController,
                    onSelectedItemChanged: (value) => dateController.changeDay(day: value),
                    looping: loopDays,
                  ),
                ),
              ),

              // Months
              Expanded(
                child: _scrollWidget(
                  controller: dateController.monthController,
                  onSelectedItemChanged: (value) => dateController.changeMonth(month: value),
                  looping: loopMonths,
                ),
              ),

              //Years
              Expanded(
                child: _scrollWidget(
                  controller: dateController.yearController,
                  onSelectedItemChanged: (value) => dateController.changeYear(year: value),
                  looping: loopYears,
                ),
              ),
            ],
          ),
        ),
        scrollWheel == ScrollWheel.flat
            ? IgnorePointer(
                child: SizedBox(
                  height: kDefaultWheelPickerHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor?.withOpacity(1.0 - overAndUnderCenterOpacity.clamp(0.0, 1.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: kDefaultItemHeight),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor?.withOpacity(1.0 - overAndUnderCenterOpacity.clamp(0.0, 1.0)),
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
