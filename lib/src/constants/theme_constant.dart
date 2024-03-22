import 'package:flutter/material.dart';

const double kDefaultWheelPickerHeight = 200.0;
const double kDefaultDiameterRatio = 2.0;
const double kDefaultItemHeight = 50.0;
const double kNotActiveItemOpacity = 0.1;

const TextStyle kDefaultItemTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 24.0,
);

enum ScrollWheel {
  curve,
  flat,
}

const ScrollWheel kdefaultScrollWheel = ScrollWheel.curve;
