import 'package:flutter/material.dart';

import '../utils/helper.dart';
import 'month_manager.dart';
import 'year_manager.dart';
import 'day_manager.dart';

class DateManager with ChangeNotifier {
  late DayManager _dayManager;
  late MonthManager _monthManager;
  late YearManager _yearManager;

  DateManager({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  })  : _dayManager = DayManager(
            currentDay: initialDate?.day,
            numberOfDays: Helper.getNumberOfDays(
              year: initialDate?.year ?? DateTime.now().year,
              month: initialDate?.month ?? DateTime.now().month,
            )),
        _monthManager = MonthManager(currentMonth: initialDate?.month),
        _yearManager = YearManager(currentYear: initialDate?.year, startYear: firstDate?.year, lastYear: lastDate?.year);

  factory DateManager.empty() => DateManager();

  DayManager get getDayManager => _dayManager;
  MonthManager get getMonthManager => _monthManager;
  YearManager get getYearManager => _yearManager;

  void changeDay({required int day}) {
    _dayManager = _dayManager.copyWith(currentDay: day);
  }

  void changeMonth({required int month}) {
    _monthManager = _monthManager.copyWith(currentMonth: month);
    updateNumberOfDays();
  }

  void changeYear({required int year}) {
    _yearManager = _yearManager.copyWith(currentYear: year);
    updateNumberOfDays();
  }

  void updateNumberOfDays() {
    _dayManager = _dayManager.copyWith(numberOfDays: Helper.getNumberOfDays(year: _yearManager.getCurrentYear, month: _monthManager.getCurrentMonth));
    notifyListeners();
  }
}
