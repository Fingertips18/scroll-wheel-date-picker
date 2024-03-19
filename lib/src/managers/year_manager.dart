import 'package:wheel_date_picker/src/constants/date_constants.dart';

class YearManager {
  final int _currentYear;
  final int _startYear;
  final int _lastYear;
  final List<String> _years;

  YearManager._({
    required int currentYear,
    required int startYear,
    required int lastYear,
    required List<String> years,
  })  : _currentYear = currentYear,
        _startYear = startYear,
        _lastYear = lastYear,
        _years = years;

  factory YearManager.empty() => YearManager();

  int get getCurrentYear => _currentYear;
  int get getStartYear => _startYear;
  int get getLastYear => _lastYear;
  List<String> get getYears => _years;

  factory YearManager({
    int? startYear,
    int? lastYear,
    int? currentYear,
  }) {
    final int start = startYear ?? DateTime.parse(kStartDate).year;
    final int last = lastYear ?? DateTime.parse(kLastDate).year;

    return YearManager._(
      currentYear: currentYear ?? DateTime.now().year,
      startYear: start,
      lastYear: last,
      years: generateYears(startYear: start, lastYear: last),
    );
  }

  YearManager copyWith({
    int? currentYear,
    int? startYear,
    int? lastYear,
  }) =>
      YearManager(
        currentYear: currentYear ?? _currentYear,
        startYear: startYear ?? _startYear,
        lastYear: lastYear ?? _lastYear,
      );
}

List<String> generateYears({required int startYear, required int lastYear}) {
  return List.generate((lastYear + 1) - startYear, (i) => (startYear + i).toString());
}
