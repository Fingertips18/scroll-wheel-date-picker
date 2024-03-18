import 'package:wheel_date_picker/src/utils/extensions.dart';

import '../constants/date_constants.dart';

class MonthManager {
  final MonthFormat _monthFormat;
  final int _currentMonth;
  final List<String> _months;

  const MonthManager._({
    required MonthFormat monthFormat,
    required int currentMonth,
    required List<String> months,
  })  : _monthFormat = monthFormat,
        _currentMonth = currentMonth,
        _months = months;

  factory MonthManager.empty() => MonthManager();

  factory MonthManager({
    MonthFormat? monthFormat,
    int? currentMonth,
  }) {
    final MonthFormat format = monthFormat ?? MonthFormat.full;

    return MonthManager._(
      monthFormat: format,
      currentMonth: currentMonth ?? DateTime.now().month - 1,
      months: generateMonths(format),
    );
  }

  MonthFormat get getFormat => _monthFormat;
  int get getCurrentMonth => _currentMonth;
  List<String> get getMonths => _months;

  MonthManager copyWith({
    MonthFormat? monthFormat,
    int? currentMonth,
  }) =>
      MonthManager(
        monthFormat: monthFormat ?? _monthFormat,
        currentMonth: currentMonth ?? _currentMonth,
      );
}

List<String> generateMonths(MonthFormat monthFormat) {
  switch (monthFormat) {
    case MonthFormat.threeLetter:
      return List.generate(Month.values.length, (i) => Month.values[i].threeAbv.capitalize);
    case MonthFormat.twoLetter:
      return List.generate(Month.values.length, (i) => Month.values[i].twoAbv.capitalize);
    default:
      return List.generate(Month.values.length, (i) => Month.values[i].name.capitalize);
  }
}
