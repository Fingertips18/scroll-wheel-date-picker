import '../utils/helper.dart';

class DayManager {
  final int _currentDay;
  final int _numberOfDays;
  final List<String> _days;

  const DayManager._({
    required int currentDay,
    required int numberOfDays,
    required List<String> days,
  })  : _currentDay = currentDay,
        _numberOfDays = numberOfDays,
        _days = days;

  factory DayManager.empty() => DayManager();

  int get getCurrentDay => _days.indexOf((_currentDay + 1).toString());
  int get getNumberOfDays => _numberOfDays;
  List<String> get getDays => _days;

  factory DayManager({int? currentDay, int? numberOfDays}) {
    final List<String> days = generateDays(
      daysCount: numberOfDays ?? Helper.getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month),
    );

    return DayManager._(
      currentDay: currentDay ?? DateTime.now().day - 1,
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

List<String> generateDays({required int daysCount}) {
  return List.generate(daysCount, (i) => (i + 1).toString());
}
