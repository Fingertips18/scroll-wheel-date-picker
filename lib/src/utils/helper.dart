class Helper {
  static int getNumberOfDays({required int year, required int month}) {
    bool isLeapYear = false;

    if (month + 1 == DateTime.february) {
      isLeapYear = ((year % 4 == 0) && (year % 100 != 0)) || year % 400 == 0;
    }

    final List<int> daysInMonths = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    return daysInMonths[month];
  }
}
