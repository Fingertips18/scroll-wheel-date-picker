import 'package:wheel_date_picker/src/utils/extensions.dart';

import '../constants/date_constants.dart';

class MonthManager {
  final MonthFormat monthFormat;
  final int _initialMonth;

  late final List<String> _months;

  MonthManager({
    this.monthFormat = MonthFormat.full,
    int? initialMonth,
  }) : _initialMonth = initialMonth ?? DateTime.now().month {
    _months = _getMonths;
  }

  factory MonthManager.empty() => MonthManager();

  List<String> get getMonths => _months;

  int get getInitialMonth => _initialMonth - 1;

  List<String> get _getMonths {
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
