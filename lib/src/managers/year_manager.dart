import '../utils/default.dart';

class YearManager {
  final int _firstYear;
  final int _lastYear;
  final int _initialYear;

  late final List<String> _years;

  YearManager({int? firstYear, int? lastYear, int? initialYear})
      : _firstYear = firstYear ?? Default.defaultFirstYear,
        _lastYear = lastYear ?? Default.defaultLastYear,
        _initialYear = initialYear ?? DateTime.now().year {
    _years = _initializeYears;
  }

  factory YearManager.empty() => YearManager();

  List<String> get getYears => _years;

  int get getInitialYear {
    return _years.indexOf(_initialYear.toString());
  }

  List<String> get _initializeYears {
    return List.generate((_lastYear + 1) - _firstYear, (y) => (_firstYear + y).toString());
  }
}
