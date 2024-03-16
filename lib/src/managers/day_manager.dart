class DayManager {
  final int _initialDay;
  late final int _lastDay;

  late final List<String> _days;

  DayManager({int? initialDay, int? lastDay}) : _initialDay = initialDay ?? DateTime.now().day {
    _lastDay = lastDay ?? _getInitialLastDay;
    _days = _initializeDays;
  }

  factory DayManager.empty() => DayManager();

  int get getInitialDay => _initialDay - 1;

  List<String> get getDays => _days;

  int get _getInitialLastDay {
    return DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }

  List<String> get _initializeDays {
    return List.generate(_lastDay, (i) => (i + 1).toString());
  }
}
