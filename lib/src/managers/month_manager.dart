import 'package:wheel_date_picker/src/utils/extensions.dart';

import '../constants/date_constants.dart';

class MonthManager {
  final MonthFormat _monthFormat;
  final int _selectedIndex;
  final List<String> _months;

  const MonthManager._({
    required MonthFormat monthFormat,
    required int selectedIndex,
    required List<String> months,
  })  : _monthFormat = monthFormat,
        _selectedIndex = selectedIndex,
        _months = months;

  factory MonthManager.empty() => MonthManager();

  factory MonthManager({
    MonthFormat? monthFormat,
    int? selectedIndex,
  }) {
    final MonthFormat format = monthFormat ?? MonthFormat.full;

    return MonthManager._(
      monthFormat: format,
      selectedIndex: selectedIndex ?? DateTime.now().month - 1,
      months: generateMonths(format),
    );
  }

  MonthFormat get getFormat => _monthFormat;
  int get getSelectedIndex => _selectedIndex;
  List<String> get getMonths => _months;

  MonthManager copyWith({
    MonthFormat? monthFormat,
    int? selectedIndex,
  }) =>
      MonthManager(
        monthFormat: monthFormat ?? _monthFormat,
        selectedIndex: selectedIndex ?? _selectedIndex,
      );
}

List<String> generateMonths(MonthFormat monthFormat) {
  switch (monthFormat) {
    case MonthFormat.threeLetters:
      return List.generate(Month.values.length, (i) => Month.values[i].threeAbv.capitalize);
    case MonthFormat.twoLetters:
      return List.generate(Month.values.length, (i) => Month.values[i].twoAbv.capitalize);
    default:
      return List.generate(Month.values.length, (i) => Month.values[i].name.capitalize);
  }
}
