import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

class HightlightOverlay extends StatelessWidget {
  /// Creates a rounded rectangle background with the default [CupertinoContextMenu.kOpenBorderRadius] radius.
  const HightlightOverlay({
    super.key,
    required this.height,
    this.color,
  });

  /// Actual height of the [HightlightOverlay].
  final double height;

  /// Background color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(defaultOpacity),
        borderRadius: BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
      ),
    );
  }
}
