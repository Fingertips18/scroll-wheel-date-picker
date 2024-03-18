import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';
import '../managers/date_manager.dart';
import 'curve_scroll_wheel.dart';

class CurveDatePicker extends StatelessWidget {
  final DateManager dateManager;

  CurveDatePicker({
    super.key,
    DateManager? dateManager,
  }) : dateManager = dateManager ?? DateManager.empty();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 50,
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
                  listenable: dateManager,
                  builder: (context, child) {
                    return CurveScrollWheel(
                      items: dateManager.getDayManager.getDays,
                      currentIndex: dateManager.getDayManager.getCurrentDay,
                      onSelectedItemChanged: (value) => dateManager.changeDay(day: value),
                    );
                  },
                ),
              ),

              // Months
              Expanded(
                child: CurveScrollWheel(
                  items: dateManager.getMonthManager.getMonths,
                  currentIndex: dateManager.getMonthManager.getCurrentMonth,
                  onSelectedItemChanged: (value) => dateManager.changeMonth(month: value),
                ),
              ),

              //Years
              Expanded(
                child: CurveScrollWheel(
                  items: dateManager.getYearManager.getYears,
                  currentIndex: dateManager.getYearManager.getCurrentYear,
                  onSelectedItemChanged: (value) => dateManager.changeYear(year: value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
