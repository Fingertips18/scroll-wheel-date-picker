import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';
import '../managers/month_manager.dart';
import '../managers/year_manager.dart';
import '../managers/day_manager.dart';
import 'curve_scroll_wheel.dart';

class CurveDatePicker extends StatelessWidget {
  final DayManager dayManager;
  final MonthManager monthManager;
  final YearManager yearManager;

  CurveDatePicker({
    super.key,
    DayManager? dayManager,
    MonthManager? monthManager,
    YearManager? yearManager,
  })  : dayManager = dayManager ?? DayManager.empty(),
        monthManager = monthManager ?? MonthManager.empty(),
        yearManager = yearManager ?? YearManager.empty();

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
              Expanded(
                child: CurveScrollWheel(
                  items: dayManager.getDays,
                  initialIndex: dayManager.getInitialDay,
                ),
              ),
              Expanded(
                child: CurveScrollWheel(
                  items: monthManager.getMonths,
                  initialIndex: monthManager.getInitialMonth,
                ),
              ),
              Expanded(
                child: CurveScrollWheel(
                  items: yearManager.getYears,
                  initialIndex: yearManager.getInitialYear,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
