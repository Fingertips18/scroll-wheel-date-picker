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
    DateTime? startDate,
    DateTime? lastDate,
  })  : _dayManager = DayManager(
            selectedIndex: initialDate?.day,
            numberOfDays: Helper.getNumberOfDays(
              year: initialDate?.year ?? DateTime.now().year,
              month: initialDate?.month ?? DateTime.now().month,
            )),
        _monthManager = MonthManager(selectedIndex: initialDate?.month),
        _yearManager = YearManager(selectedIndex: initialDate?.year, startYear: startDate?.year, lastYear: lastDate?.year);

  factory DateManager.empty() => DateManager();

  DayManager get getDayManager => _dayManager;
  MonthManager get getMonthManager => _monthManager;
  YearManager get getYearManager => _yearManager;

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
