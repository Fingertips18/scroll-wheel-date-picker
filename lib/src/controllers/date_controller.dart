import 'package:flutter/material.dart';

import 'package:wheel_date_picker/src/utils/extensions.dart';
import '../constants/date_constants.dart';
import '../utils/helper.dart';
import 'icontroller.dart';

class DateController with ChangeNotifier {
  late _DayController _dayController;
  late _MonthController _monthController;
  late _YearController _yearController;

  DateController({
    DateTime? initialDate,
    DateTime? startDate,
    DateTime? lastDate,
  })  : _dayController = _DayController(
            selectedIndex: initialDate?.day,
            numberOfDays: Helper.getNumberOfDays(
              year: initialDate?.year ?? DateTime.now().year,
              month: initialDate?.month ?? DateTime.now().month,
            )),
        _monthController = _MonthController(selectedIndex: initialDate?.month),
        _yearController = _YearController(selectedIndex: initialDate?.year, startYear: startDate?.year, lastYear: lastDate?.year);

  factory DateController.empty() => DateController();

  IController get dayController => _dayController;
  IController get monthController => _monthController;
  IController get yearController => _yearController;

  void changeDay({required int day}) {
    _dayController = _dayController.copyWith(selectedIndex: day);
  }

  void changeMonth({required int month}) {
    _monthController = _monthController.copyWith(selectedIndex: month);
    _updateNumberOfDays();
  }

  void changeYear({required int year}) {
    _yearController = _yearController.copyWith(selectedIndex: year);
    _updateNumberOfDays();
  }

  void _updateNumberOfDays() {
    final int numberOfDays = Helper.getNumberOfDays(year: _yearController.getSelectedIndex, month: _monthController.getSelectedIndex);

    _dayController = _dayController.copyWith(numberOfDays: numberOfDays);

    notifyListeners();
  }
}

List<String> _generateDays({required int numberOfDays}) {
  return List.generate(numberOfDays, (i) => (i + 1).toString());
}

class _DayController implements IController {
  final int _selectedIndex;
  final int _numberOfDays;
  final List<String> _days;

  const _DayController._({
    required int selectedIndex,
    required int numberOfDays,
    required List<String> days,
  })  : _selectedIndex = selectedIndex,
        _numberOfDays = numberOfDays,
        _days = days;

  @override
  int get getSelectedIndex => _days.indexOf((_selectedIndex + 1).toString());
  int get getNumberOfDays => _numberOfDays;
  @override
  List<String> get getItems => _days;

  factory _DayController({int? selectedIndex, int? numberOfDays}) {
    final List<String> days = _generateDays(
      numberOfDays: numberOfDays ?? Helper.getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month),
    );

    return _DayController._(
      selectedIndex: selectedIndex ?? DateTime.now().day - 1,
      numberOfDays: days.length,
      days: days,
    );
  }

  @override
  _DayController copyWith({
    int? selectedIndex,
    int? numberOfDays,
  }) =>
      _DayController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        numberOfDays: numberOfDays ?? _numberOfDays,
      );
}

List<String> _generateMonths(MonthFormat monthFormat) {
  switch (monthFormat) {
    case MonthFormat.threeLetters:
      return List.generate(Month.values.length, (i) => Month.values[i].threeAbv.capitalize);
    case MonthFormat.twoLetters:
      return List.generate(Month.values.length, (i) => Month.values[i].twoAbv.capitalize);
    default:
      return List.generate(Month.values.length, (i) => Month.values[i].name.capitalize);
  }
}

class _MonthController implements IController {
  final MonthFormat _monthFormat;
  final int _selectedIndex;
  final List<String> _months;

  const _MonthController._({
    required MonthFormat monthFormat,
    required int selectedIndex,
    required List<String> months,
  })  : _monthFormat = monthFormat,
        _selectedIndex = selectedIndex,
        _months = months;

  factory _MonthController({
    MonthFormat? monthFormat,
    int? selectedIndex,
  }) {
    final MonthFormat format = monthFormat ?? MonthFormat.full;

    return _MonthController._(
      monthFormat: format,
      selectedIndex: selectedIndex ?? DateTime.now().month - 1,
      months: _generateMonths(format),
    );
  }

  MonthFormat get getFormat => _monthFormat;
  @override
  int get getSelectedIndex => _selectedIndex;
  @override
  List<String> get getItems => _months;

  @override
  _MonthController copyWith({
    MonthFormat? monthFormat,
    int? selectedIndex,
  }) =>
      _MonthController(
        monthFormat: monthFormat ?? _monthFormat,
        selectedIndex: selectedIndex ?? _selectedIndex,
      );
}

List<String> _generateYears({required int startYear, required int lastYear}) {
  return List.generate((lastYear + 1) - startYear, (i) => (startYear + i).toString());
}

class _YearController implements IController {
  final int _selectedIndex;
  final int _startYear;
  final int _lastYear;
  final List<String> _years;

  _YearController._({
    required int selectedIndex,
    required int startYear,
    required int lastYear,
    required List<String> years,
  })  : _selectedIndex = selectedIndex,
        _startYear = startYear,
        _lastYear = lastYear,
        _years = years;

  @override
  int get getSelectedIndex => _selectedIndex;
  int get getStartYear => _startYear;
  int get getLastYear => _lastYear;
  @override
  List<String> get getItems => _years;

  factory _YearController({
    int? startYear,
    int? lastYear,
    int? selectedIndex,
  }) {
    final int start = startYear ?? DateTime.parse(kStartDate).year;
    final int last = lastYear ?? DateTime.parse(kLastDate).year;

    final generatedYears = _generateYears(startYear: start, lastYear: last);

    return _YearController._(
      selectedIndex: selectedIndex ?? generatedYears.indexOf(DateTime.now().year.toString()),
      startYear: start,
      lastYear: last,
      years: generatedYears,
    );
  }

  @override
  _YearController copyWith({
    int? selectedIndex,
    int? startYear,
    int? lastYear,
  }) =>
      _YearController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        startYear: startYear ?? _startYear,
        lastYear: lastYear ?? _lastYear,
      );
}
