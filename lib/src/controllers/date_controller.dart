import 'package:flutter/material.dart';

import '../utils/helper.dart';
import 'month_controller.dart';
import 'year_controller.dart';
import 'day_controller.dart';

class DateController with ChangeNotifier {
  late DayController _dayManager;
  late MonthController _monthManager;
  late YearController _yearManager;

  DateController({
    DateTime? initialDate,
    DateTime? startDate,
    DateTime? lastDate,
  })  : _dayManager = DayController(
            selectedIndex: initialDate?.day,
            numberOfDays: Helper.getNumberOfDays(
              year: initialDate?.year ?? DateTime.now().year,
              month: initialDate?.month ?? DateTime.now().month,
            )),
        _monthManager = MonthController(selectedIndex: initialDate?.month),
        _yearManager = YearController(selectedIndex: initialDate?.year, startYear: startDate?.year, lastYear: lastDate?.year);

  factory DateController.empty() => DateController();

  DayController get getDayManager => _dayManager;
  MonthController get getMonthManager => _monthManager;
  YearController get getYearManager => _yearManager;

  void changeDay({required int day}) {
    _dayManager = _dayManager.copyWith(selectedIndex: day);
  }

  void changeMonth({required int month}) {
    _monthManager = _monthManager.copyWith(selectedIndex: month);
    updateNumberOfDays();
  }

  void changeYear({required int year}) {
    _yearManager = _yearManager.copyWith(selectedIndex: year);
    updateNumberOfDays();
  }

  void updateNumberOfDays() {
    final int numberOfDays = Helper.getNumberOfDays(year: _yearManager.getSelectedIndex, month: _monthManager.getSelectedIndex);

    _dayManager = _dayManager.copyWith(numberOfDays: numberOfDays);

    notifyListeners();
  }
}
