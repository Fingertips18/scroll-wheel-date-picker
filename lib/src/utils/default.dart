import '../constants/date_constants.dart';

class Default {
  static DateTime get startDate => DateTime(kFirstYear, DateTime.january, DateTime(kFirstYear, DateTime.january).day);
  static DateTime get lastDate => DateTime(DateTime.now().year, DateTime.december, DateTime(DateTime.now().year, DateTime.december).day);
}
