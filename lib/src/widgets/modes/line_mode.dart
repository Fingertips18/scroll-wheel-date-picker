import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

class LineMode extends StatelessWidget {
  /// Creates a horizontal parallel lines.
  const LineMode({
    super.key,
    required this.height,
    this.color,
  });

  /// Gap between the lines of [LineMode].
  final double height;

  /// Lines color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultModeMargin),
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: color ?? Colors.white,
            width: defaultModeBorderThickness,
          ),
          bottom: BorderSide(
            color: color ?? Colors.white,
            width: defaultModeBorderThickness,
          ),
        ),
      ),
    );
  }
}
