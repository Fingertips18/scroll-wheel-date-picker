import 'package:flutter/material.dart';

import '../constants/date_constants.dart';

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
            numberOfDays: _getNumberOfDays(
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
    final int numberOfDays = _getNumberOfDays(year: _yearController.selectedIndex, month: _monthController.selectedIndex);

    _dayController = _dayController.copyWith(numberOfDays: numberOfDays);

    notifyListeners();
  }
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
  int get selectedIndex => _days.indexOf((_selectedIndex + 1).toString());
  int get numberOfDays => _numberOfDays;
  @override
  List<String> get items => _days;

  factory _DayController({int? selectedIndex, int? numberOfDays}) {
    final List<String> days = _generateDays(
      numberOfDays: numberOfDays ?? _getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month),
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

  MonthFormat get monthFormat => _monthFormat;
  @override
  int get selectedIndex => _selectedIndex;
  @override
  List<String> get items => _months;

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
  int get selectedIndex => _selectedIndex;
  int get startYear => _startYear;
  int get lastYear => _lastYear;
  @override
  List<String> get items => _years;

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

int _getNumberOfDays({required int year, required int month}) {
  bool isLeapYear = false;

  if (month + 1 == DateTime.february) {
    isLeapYear = ((year % 4 == 0) && (year % 100 != 0)) || year % 400 == 0;
  }

  final List<int> daysInMonths = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  return daysInMonths[month];
}

List<String> _generateDays({required int numberOfDays}) {
  return List.generate(numberOfDays, (i) => (i + 1).toString());
}

List<String> _generateMonths(MonthFormat monthFormat) {
  switch (monthFormat) {
    case MonthFormat.threeLetters:
      return List.generate(Month.values.length, (i) => _capitalize(Month.values[i].threeAbv));
    case MonthFormat.twoLetters:
      return List.generate(Month.values.length, (i) => _capitalize(Month.values[i].twoAbv));
    default:
      return List.generate(Month.values.length, (i) => _capitalize(Month.values[i].name));
  }
}

List<String> _generateYears({required int startYear, required int lastYear}) {
  return List.generate((lastYear + 1) - startYear, (i) => (startYear + i).toString());
}

String _capitalize(String s) {
  return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
}

abstract interface class IController {
  IController copyWith();
  int get selectedIndex;
  List<String> get items;
}
