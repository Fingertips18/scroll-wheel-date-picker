import 'package:wheel_date_picker/src/utils/extensions.dart';

import '../constants/date_constants.dart';

class MonthManager {
  final MonthFormat monthFormat;
  final int _initialMonth;

  MonthManager({
    this.monthFormat = MonthFormat.full,
    int? initialMonth,
  }) : _initialMonth = initialMonth ?? DateTime.now().month;

  factory MonthManager.empty() => MonthManager();

  int get getInitialMonthIndex => _initialMonth - 1;

  List<String> get getMonths {
    switch (monthFormat) {
      case MonthFormat.threeLetter:
        return List.generate(Month.values.length, (i) => Month.values[i].threeAbv.capitalize);
      case MonthFormat.twoLetter:
        return List.generate(Month.values.length, (i) => Month.values[i].twoAbv.capitalize);
      default:
        return List.generate(Month.values.length, (i) => Month.values[i].name.capitalize);
    }
  }
}
