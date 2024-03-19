import '../utils/helper.dart';

class DayManager {
  final int _selectedIndex;
  final int _numberOfDays;
  final List<String> _days;

  const DayManager._({
    required int selectedIndex,
    required int numberOfDays,
    required List<String> days,
  })  : _selectedIndex = selectedIndex,
        _numberOfDays = numberOfDays,
        _days = days;

  factory DayManager.empty() => DayManager();

  int get getSelectedIndex => _days.indexOf((_selectedIndex + 1).toString());
  int get getNumberOfDays => _numberOfDays;
  List<String> get getDays => _days;

  factory DayManager({int? selectedIndex, int? numberOfDays}) {
    final List<String> days = generateDays(
      daysCount: numberOfDays ?? Helper.getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month),
    );

    return DayManager._(
      selectedIndex: selectedIndex ?? DateTime.now().day - 1,
      numberOfDays: days.length,
      days: days,
    );
  }

  DayManager copyWith({
    int? selectedIndex,
    int? numberOfDays,
  }) =>
      DayManager(
        selectedIndex: selectedIndex ?? _selectedIndex,
        numberOfDays: numberOfDays ?? _numberOfDays,
      );
}

List<String> generateDays({required int daysCount}) {
  return List.generate(daysCount, (i) => (i + 1).toString());
}
