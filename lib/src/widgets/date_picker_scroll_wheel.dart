import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/date_controller.dart';
import '../constants/theme_constant.dart';
import '../controllers/icontroller.dart';
import 'curve_scroll_wheel.dart';
import 'flat_scroll_wheel.dart';

class DatePickerScrollWheel extends StatelessWidget {
  final DateController dateController;
  final bool loopDays;
  final bool loopMonths;
  final bool loopYears;
  final ScrollWheel scrollWheel;

  DatePickerScrollWheel({
    super.key,
    DateController? dateController,
    this.loopDays = true,
    this.loopMonths = true,
    this.loopYears = false,
    this.scrollWheel = ScrollWheel.curve,
  }) : dateController = dateController ?? DateController.empty();

  Widget _scrollWidget({
    required IController controller,
    Function(int value)? onSelectedItemChanged,
    required bool looping,
  }) {
    return scrollWheel == ScrollWheel.curve
        ? CurveScrollWheel(
            items: controller.getItems,
            selectedIndex: controller.getSelectedIndex,
            onSelectedItemChanged: onSelectedItemChanged,
            looping: looping,
          )
        : FlatScrollWheel(
            items: controller.getItems,
            selectedIndex: controller.getSelectedIndex,
            onIndexChanged: onSelectedItemChanged,
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
      ],
    );
  }
}
