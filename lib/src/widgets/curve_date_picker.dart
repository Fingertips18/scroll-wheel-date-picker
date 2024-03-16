import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../managers/year_manager.dart';
import 'curve_scroll_wheel.dart';

class CurveDatePicker extends StatelessWidget {
  final YearManager yearManager;

  CurveDatePicker({
    super.key,
    YearManager? yearManager,
  }) : yearManager = yearManager ?? YearManager.empty();

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
          height: MediaQuery.of(context).size.height / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: CurveScrollWheel(
                  items: [],
                  initialYearIndex: 0,
                ),
              ),
              const Expanded(
                child: CurveScrollWheel(
                  items: [],
                  initialYearIndex: 0,
                ),
              ),
              Expanded(
                child: CurveScrollWheel(
                  items: yearManager.getYears,
                  initialYearIndex: yearManager.initialYearIndex,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
