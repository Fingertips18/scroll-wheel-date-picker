import 'package:flutter/material.dart';

import 'widgets/scroll_wheel_date_picker.dart';
import 'widgets/curve_scroll_wheel.dart';
import 'widgets/flat_scroll_wheel.dart';
import 'constants/date_constants.dart';

/// Uses [ChangeNotifier] to listen to changes when the [changeMonth] or [changeYear] is called.
class DateController with ChangeNotifier {
  /// Responsible for handling the initialization & changes of the [_DayController], [_MonthController] & [_YearController].
  DateController({
    DateTime? initialDate,
    DateTime? startDate,
    DateTime? lastDate,
  }) {
    if (startDate != null && lastDate != null) {
      assert((lastDate.year - startDate.year) > 2, "The years between [startDate] and [lastDate] must be greater than or equal to 2.");
      assert(startDate.isBefore(lastDate), "[startDate] must be before `[lastDate]`");
      assert(lastDate.isAfter(startDate), "[lastDate] must be before `[startDate]`");
    }

    if (startDate != null && lastDate == null) {
      assert(startDate.isBefore(DateTime.parse(defaultLastDate)), "[startDate] must be before `[defaultLastDate]`");
    }

    if (startDate == null && lastDate != null) {
      assert(lastDate.isAfter(DateTime.parse(defaultStartDate)), "[lastDate] must be before `[defaultStartDate]`");
    }

    if (startDate != null && initialDate != null) {
      assert(initialDate.isAfter(startDate), "[initialDate] must be after the provided [startDate].");
    }

    if (startDate == null && initialDate != null) {
      assert(initialDate.isAfter(DateTime.parse(defaultStartDate)), "[initialDate] must be after the default [startDate].");
    }

    if (startDate != null && initialDate == null) {
      assert(DateTime.now().isAfter(startDate), "[startDate] must be before the [initialDate] or [DateTime.now()]");
    }

    if (lastDate != null && initialDate != null) {
      assert(initialDate.isBefore(lastDate), "[initialDate] must be before the provided [lastDate].");
    }

    if (lastDate == null && initialDate != null) {
      assert(initialDate.isBefore(DateTime.parse(defaultLastDate)), "[initialDate] must be before the default [lastDate].");
    }

    if (lastDate != null && initialDate == null) {
      assert(DateTime.now().isBefore(lastDate), "[lastDate] must be after the [initialDate] or [DateTime.now()]");
    }

    _initialDate = initialDate ?? DateTime.now();
    _startDate = startDate ?? DateTime.parse(defaultStartDate);
    _lastDate = lastDate ?? DateTime.parse(defaultLastDate);

    _dayController = _DayController(
        selectedIndex: initialDate != null ? initialDate.day - 1 : null,
        numberOfDays: _getNumberOfDays(
          year: initialDate?.year ?? DateTime.now().year,
          month: initialDate?.month ?? DateTime.now().month,
        ));

    _monthController = _MonthController(selectedIndex: initialDate != null ? initialDate.month - 1 : null);

    _yearController = _YearController(
      initialYear: initialDate?.year,
      startYear: startDate?.year,
      lastYear: lastDate?.year,
    );

    _dateTime = DateTime(
      initialDate?.year ?? DateTime.now().year,
      initialDate?.month ?? DateTime.now().month,
      initialDate?.day ?? DateTime.now().day,
    );
  }

  late _DayController _dayController;
  late _MonthController _monthController;
  late _YearController _yearController;

  /// Returns a [DateTime] value when the [onSelectedItemChanged] of the [ScrollWheelDatePicker] is used.
  late DateTime _dateTime;

  late DateTime _initialDate;
  late DateTime _startDate;
  late DateTime _lastDate;

  IDateController get dayController => _dayController;
  IDateController get monthController => _monthController;
  IDateController get yearController => _yearController;
  DateTime get dateTime => _dateTime;

  /// Called when the selected item of the days [CurveScrollWheel] or [FlatScrollWheel] changed.
  void changeDay({required int day}) {
    _dayController = _dayController.copyWith(selectedIndex: day);

    _dateTime = _dateTime.copyWith(day: day + 1);
  }

  /// Called when the selected item of the months [CurveScrollWheel] or [FlatScrollWheel] changed.
  void changeMonth({required int month}) {
    _monthController = _monthController.copyWith(selectedIndex: month);

    _updateNumberOfDays();

    _dateTime = _dateTime.copyWith(month: month + 1);
  }

  /// Called when a [MonthFormat] is given or changed in the [ScrollWheelDatePicker] constructor.
  void changeMonthFormat({required MonthFormat format}) {
    _monthController = _monthController.copyWith(monthFormat: format);
  }

  /// Called when the selected item of the years [CurveScrollWheel] or [FlatScrollWheel] changed.
  void changeYear({required int year}) {
    _yearController = _yearController.copyWith(selectedIndex: year);

    _updateNumberOfDays();

    _dateTime = _dateTime.copyWith(year: int.parse(_yearController.items[year]));
  }

  /// Called when the [initialDate] of the [ScrollWheelDatePicker] changed.
  void changeInitialDate(DateTime initialDate) {
    assert(initialDate.isAfter(_startDate), "[initialDate] must be after the [startDate]");
    assert(initialDate.isBefore(_lastDate), "[initialDate] must be before the [lastDate]");

    _initialDate = initialDate;

    _dayController = _dayController.copyWith(
      selectedIndex: initialDate.day - 1,
      numberOfDays: _getNumberOfDays(
        year: initialDate.year,
        month: initialDate.month,
      ),
    );
    _monthController = _monthController.copyWith(selectedIndex: initialDate.month - 1);
    _yearController = _yearController.copyWith(initialYear: initialDate.year);
  }

  /// Called when the [startDate] of the [ScrollWheelDatePicker] changed.
  void changeStartDate(DateTime startDate) {
    assert(startDate.isBefore(_lastDate), "[startDate] must be before the [lastDate]");
    assert(startDate.isBefore(_initialDate), "[startDate] must be before the [initialDate]");

    _startDate = startDate;

    _yearController = _yearController.copyWith(startYear: startDate.year);
  }

  /// Called when the [lastDate] of the [ScrollWheelDatePicker] changed.
  void changeLastDate(DateTime lastDate) {
    assert(lastDate.isAfter(_startDate), "[lastDate] must be after the [startDate]");
    assert(lastDate.isAfter(_initialDate), "[lastDate] must be after the [initialDate]");

    _lastDate = lastDate;

    _yearController = _yearController.copyWith(lastYear: lastDate.year);
  }

  /// Handles the change of the total number of days base on the selected month.
  ///
  /// Responsible for updating the total number of days in the [CurveScrollWheel] or [FlatScrollWheel].
  ///
  /// Called when the [changeMonth] & [changeYear] is triggered.
  /// This is important so that the `total number of days` is updated when the month or year changes.
  void _updateNumberOfDays() {
    final int numberOfDays = _getNumberOfDays(year: _yearController.selectedIndex, month: _monthController.selectedIndex);

    final int selectedIndex = _dayController.selectedIndex >= numberOfDays ? numberOfDays - 1 : _dayController.selectedIndex;

    _dayController = _dayController.copyWith(selectedIndex: selectedIndex, numberOfDays: numberOfDays);

    notifyListeners();
  }
}

/// Responsible for the configuration of the [ScrollWheelDatePicker]'s days scroll wheel.
class _DayController implements IDateController {
  /// A private constructor is needed in order to implement a factory method without including the list of [_days].
  ///
  /// This is a factor as well to create a [copyWith] & preventing other classes from creating a new list of [_days] outside of this class.
  const _DayController._({
    required int selectedIndex,
    required int numberOfDays,
    required List<String> days,
  })  : _selectedIndex = selectedIndex,
        _numberOfDays = numberOfDays,
        _days = days;

  /// Currently selected index. Can be updated with [copyWith].
  final int _selectedIndex;

  /// Total number of days in a month. Can be updated with [copyWith].
  final int _numberOfDays;

  /// Collection of days in [String] type.
  final List<String> _days;

  @override
  int get selectedIndex => _selectedIndex;
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

/// Responsible for the configuration of the [ScrollWheelDatePicker]'s months scroll wheel.
class _MonthController implements IDateController {
  /// A private constructor is needed in order to implement a factory method without including the list of [_months].
  ///
  /// This is a factor as well to create a [copyWith] & preventing other classes from creating a new list of [_months] outside of this class.
  const _MonthController._({
    required MonthFormat monthFormat,
    required int selectedIndex,
    required List<String> months,
  })  : _monthFormat = monthFormat,
        _selectedIndex = selectedIndex,
        _months = months;

  /// Currently selected index. Can be updated with [copyWith].
  final int _selectedIndex;

  /// Applies the format of the months. Can be updated with [copyWith].
  final MonthFormat _monthFormat;

  /// Collection of months in [String] type.
  final List<String> _months;

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

/// Responsible for the configuration of the [ScrollWheelDatePicker]'s years scroll wheel.
class _YearController implements IDateController {
  /// A private constructor is needed in order to implement a factory method without including the list of [_years].
  ///
  /// This is a factor as well to create a [copyWith] & preventing other classes from creating a new list of [_years] outside of this class.
  _YearController._({
    required int selectedIndex,
    required int startYear,
    required int lastYear,
    required List<String> years,
  })  : _selectedIndex = selectedIndex,
        _startYear = startYear,
        _lastYear = lastYear,
        _years = years;

  /// Currently selected index. Can be updated with [copyWith].
  final int _selectedIndex;

  /// Initial year of the items. Can be updated with [copyWith].
  final int _startYear;

  /// Max year of the items. Can be updated with [copyWith].
  final int _lastYear;

  /// Collection of years in [String] type.
  final List<String> _years;

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
    int? initialYear,
  }) {
    final int start = startYear ?? DateTime.parse(defaultStartDate).year;
    final int last = lastYear ?? DateTime.parse(defaultLastDate).year;

    final generatedYears = _generateYears(startYear: start, lastYear: last);

    if (initialYear != null) {
      selectedIndex = generatedYears.indexOf(initialYear.toString());
    } else {
      selectedIndex = generatedYears.indexOf(DateTime.now().year.toString());
    }

    return _YearController._(
      selectedIndex: selectedIndex,
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
    int? initialYear,
  }) =>
      _YearController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        startYear: startYear ?? _startYear,
        lastYear: lastYear ?? _lastYear,
        initialYear: initialYear,
      );
}

/// Responsible for getting the total number of days on a particular [month].
///
/// The [year] is needed to determine if its a leap year or not.
///
/// If it is a leap year & [month] is [DateTime.february], return `29`.
///
/// Otherwise, return `28`.
int _getNumberOfDays({required int year, required int month}) {
  bool isLeapYear = false;

  if (month + 1 == DateTime.february) {
    isLeapYear = ((year % 4 == 0) && (year % 100 != 0)) || year % 400 == 0;
  }

  final List<int> daysInMonths = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  return daysInMonths[month];
}

/// Responsible for creating the list of daays in [String] type.
///
/// Requires a [numberOfDays] to determine the total number of days to generate `from 1 to total number of days`.
List<String> _generateDays({required int numberOfDays}) {
  return List.generate(numberOfDays, (i) => (i + 1).toString());
}

/// Responsible for creating the list of months in [String] type.
///
/// Requires a [MonthFormat] to determine what type of format to use to the list of months.
///
/// [MonthFormat.full] - Returns the full name of the months.
///
/// [MonthFormat.threeLetters] - Returns the three letters abbreviation name of the months.
///
/// [MonthFormat.twoLetters] - Returns the two letter abbreviation name of the months.
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

/// Responsible for creating the list of years in [String] type.
///
/// Requires a [startYear] to determine the initial item of the list.
///
/// Requires a [lastYear] to determine the end item of the list.
List<String> _generateYears({required int startYear, required int lastYear}) {
  return List.generate((lastYear + 1) - startYear, (i) => (startYear + i).toString());
}

/// Ensures that the month's first letter is an upper case.
String _capitalize(String s) {
  return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
}

/// An abstract class for the [_DayController], [_MonthController] & [_YearController].
abstract interface class IDateController {
  IDateController copyWith();
  int get selectedIndex;
  List<String> get items;
}
