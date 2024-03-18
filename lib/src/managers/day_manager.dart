import '../utils/helper.dart';

class DayManager {
  final int _currentDay;
  final int _numberOfDays;
  final List<String> _days;

  const DayManager._({
    required int currentDay,
    required int numberOfDays,
    required List<String> days,
  })  : _days = days,
        _numberOfDays = numberOfDays,
        _currentDay = currentDay;

  factory DayManager.empty() => DayManager();

  int get getCurrentDay => _currentDay;
  int get getNumberOfDays => _numberOfDays;
  List<String> get getDays => _days;

  factory DayManager({int? currentDay, int? numberOfDays}) {
    final List<String> days = List.generate(
      numberOfDays ?? Helper.getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month),
      (i) => (i + 1).toString(),
    );

    return DayManager._(
      currentDay: (currentDay ?? DateTime.now().day) - 1,
      numberOfDays: days.length,
      days: days,
    );
  }

  DayManager copyWith({
    int? currentDay,
    int? numberOfDays,
  }) =>
      DayManager(
        currentDay: currentDay ?? _currentDay,
        numberOfDays: numberOfDays ?? _numberOfDays,
      );
}
