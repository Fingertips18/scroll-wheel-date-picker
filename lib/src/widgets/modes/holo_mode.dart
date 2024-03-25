import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

class HoloMode extends StatelessWidget {
  /// Create a horizontal parallel lines separated with a space.
  const HoloMode({
    super.key,
    required this.height,
    this.color,
  });

  /// Gap between the lines of [HoloMode].
  final double height;

  /// Lines color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultModeMargin),
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Container(
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
            ),
          ),
          const SizedBox(width: defaultModeSpacing),
          Expanded(
            child: Container(
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
            ),
          ),
          const SizedBox(width: defaultModeSpacing),
          Expanded(
            child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
