import '../utils/helper.dart';
import 'icontroller.dart';

List<String> generateDays({required int numberOfDays}) {
  return List.generate(numberOfDays, (i) => (i + 1).toString());
}

class DayController implements IController {
  final int _selectedIndex;
  final int _numberOfDays;
  final List<String> _days;

  const DayController._({
    required int selectedIndex,
    required int numberOfDays,
    required List<String> days,
  })  : _selectedIndex = selectedIndex,
        _numberOfDays = numberOfDays,
        _days = days;

  factory DayController.empty() => DayController();

  @override
  int get getSelectedIndex => _days.indexOf((_selectedIndex + 1).toString());
  int get getNumberOfDays => _numberOfDays;
  @override
  List<String> get getItems => _days;

  factory DayController({int? selectedIndex, int? numberOfDays}) {
    final List<String> days = generateDays(
      numberOfDays: numberOfDays ?? Helper.getNumberOfDays(year: DateTime.now().year, month: DateTime.now().month),
    );

    return DayController._(
      selectedIndex: selectedIndex ?? DateTime.now().day - 1,
      numberOfDays: days.length,
      days: days,
    );
  }

  @override
  DayController copyWith({
    int? selectedIndex,
    int? numberOfDays,
  }) =>
      DayController(
        selectedIndex: selectedIndex ?? _selectedIndex,
        numberOfDays: numberOfDays ?? _numberOfDays,
      );
}
