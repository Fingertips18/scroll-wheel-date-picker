import '../utils/default.dart';

class YearManager {
  final int firstYear;
  final int lastYear;
  final int initialYear;

  late final List<String> _years;

  YearManager({int? firstYear, int? lastYear, int? initialYear})
      : firstYear = firstYear ?? Default.defaultFirstYear,
        lastYear = lastYear ?? Default.defaultLastYear,
        initialYear = initialYear ?? DateTime.now().year {
    _years = _initializeYears;
  }

  factory YearManager.empty() => YearManager();

  int get initialYearIndex {
    return _years.indexOf(initialYear.toString());
  }

  List<String> get _initializeYears {
    return List.generate((lastYear + 1) - firstYear, (y) => (firstYear + y).toString());
  }

  List<String> get getYears => _years;
}
