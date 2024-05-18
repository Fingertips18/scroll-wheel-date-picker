import '../date_controller.dart';

/// Enum for [DateController]'s month format values.
enum Month {
  january(threeAbv: "jan", twoAbv: "ja"),
  february(threeAbv: "feb", twoAbv: "fe"),
  march(threeAbv: "mar", twoAbv: "mr"),
  april(threeAbv: "apr", twoAbv: "ap"),
  may(threeAbv: "may", twoAbv: "my"),
  june(threeAbv: "jun", twoAbv: "jn"),
  july(threeAbv: "jul", twoAbv: "jl"),
  august(threeAbv: "aug", twoAbv: "au"),
  september(threeAbv: "sep", twoAbv: "se"),
  october(threeAbv: "oct", twoAbv: "oc"),
  november(threeAbv: "nov", twoAbv: "nv"),
  december(threeAbv: "dec", twoAbv: "de");

  final String threeAbv;
  final String twoAbv;
  const Month({
    required this.threeAbv,
    required this.twoAbv,
  });
}

/// Enum for [DateController]'s month formats.
enum MonthFormat {
  full,
  threeLetters,
  twoLetters,
}

/// Default value of [DateController]'s start date.
const String defaultStartDate = "1900-01-01 00:00:00";

/// Default value of [DateController]'s last date.
const String defaultLastDate = "2100-12-31 23:59:59";
