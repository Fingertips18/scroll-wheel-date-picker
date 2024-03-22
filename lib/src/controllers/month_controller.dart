import 'package:wheel_date_picker/src/utils/extensions.dart';

import '../constants/date_constants.dart';
import 'icontroller.dart';

List<String> generateMonths(MonthFormat monthFormat) {
  switch (monthFormat) {
    case MonthFormat.threeLetters:
      return List.generate(Month.values.length, (i) => Month.values[i].threeAbv.capitalize);
    case MonthFormat.twoLetters:
      return List.generate(Month.values.length, (i) => Month.values[i].twoAbv.capitalize);
    default:
      return List.generate(Month.values.length, (i) => Month.values[i].name.capitalize);
  }
}

class MonthController implements IController {
  final MonthFormat _monthFormat;
  final int _selectedIndex;
  final List<String> _months;

  const MonthController._({
    required MonthFormat monthFormat,
    required int selectedIndex,
    required List<String> months,
  })  : _monthFormat = monthFormat,
        _selectedIndex = selectedIndex,
        _months = months;

  factory MonthController.empty() => MonthController();

  factory MonthController({
    MonthFormat? monthFormat,
    int? selectedIndex,
  }) {
    final MonthFormat format = monthFormat ?? MonthFormat.full;

    return MonthController._(
      monthFormat: format,
      selectedIndex: selectedIndex ?? DateTime.now().month - 1,
      months: generateMonths(format),
    );
  }

  MonthFormat get getFormat => _monthFormat;
  @override
  int get getSelectedIndex => _selectedIndex;
  @override
  List<String> get getItems => _months;

  @override
  MonthController copyWith({
    MonthFormat? monthFormat,
    int? selectedIndex,
  }) =>
      MonthController(
        monthFormat: monthFormat ?? _monthFormat,
        selectedIndex: selectedIndex ?? _selectedIndex,
      );
}
