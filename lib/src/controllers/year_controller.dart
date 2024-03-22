import 'package:wheel_date_picker/src/constants/date_constants.dart';

import 'icontroller.dart';

List<String> generateYears({required int startYear, required int lastYear}) {
  return List.generate((lastYear + 1) - startYear, (i) => (startYear + i).toString());
}

class YearController implements IController {
  final int _selectedIndex;
  final int _startYear;
  final int _lastYear;
  final List<String> _years;

  YearController._({
    required int selectedIndex,
    required int startYear,
    required int lastYear,
    required List<String> years,
  })  : _selectedIndex = selectedIndex,
        _startYear = startYear,
        _lastYear = lastYear,
        _years = years;

  factory YearController.empty() => YearController();

  @override
  int get getSelectedIndex => _selectedIndex;
  int get getStartYear => _startYear;
  int get getLastYear => _lastYear;
  @override
  List<String> get getItems => _years;

  factory YearController({
    int? startYear,
    int? lastYear,
    int? selectedIndex,
  }) {
    final int start = startYear ?? DateTime.parse(kStartDate).year;
    final int last = lastYear ?? DateTime.parse(kLastDate).year;

    final generatedYears = generateYears(startYear: start, lastYear: last);

    return YearController._(
      selectedIndex: selectedIndex ?? generatedYears.indexOf(DateTime.now().year.toString()),
      startYear: start,
      lastYear: last,
      years: generatedYears,
    );
  }

  @override
  YearController copyWith({
    int? selectedIndex,
    int? startYear,
    int? lastYear,
  }) =>
      YearController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        startYear: startYear ?? _startYear,
        lastYear: lastYear ?? _lastYear,
      );
}
