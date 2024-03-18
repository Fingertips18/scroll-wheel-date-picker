import '../constants/date_constants.dart';
import 'helper.dart';

class Default {
  static DateTime get startDate => DateTime(
        kFirstYear,
        DateTime.january,
        Helper.getNumberOfDays(year: kFirstYear, month: DateTime.january - 1),
      );
  static DateTime get lastDate => DateTime(
        DateTime.now().year,
        DateTime.december,
        Helper.getNumberOfDays(year: DateTime.now().year, month: DateTime.december - 1),
      );
}
