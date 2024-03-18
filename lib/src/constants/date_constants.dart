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

enum MonthFormat {
  full,
  threeLetter,
  twoLetter,
}

const int kFirstYear = 1900;
