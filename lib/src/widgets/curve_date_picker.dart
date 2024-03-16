import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';
import '../managers/month_manager.dart';
import '../managers/year_manager.dart';
import 'curve_scroll_wheel.dart';

class CurveDatePicker extends StatelessWidget {
  final MonthManager monthManager;
  final YearManager yearManager;

  CurveDatePicker({
    super.key,
    MonthManager? monthManager,
    YearManager? yearManager,
  })  : monthManager = monthManager ?? MonthManager.empty(),
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
              const Expanded(
                child: CurveScrollWheel(
                  items: [],
                  initialIndex: 0,
                ),
              ),
              Expanded(
                child: CurveScrollWheel(
                  items: monthManager.getMonths,
                  initialIndex: monthManager.getInitialMonthIndex,
                ),
              ),
              Expanded(
                child: CurveScrollWheel(
                  items: yearManager.getYears,
                  initialIndex: yearManager.initialYearIndex,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
