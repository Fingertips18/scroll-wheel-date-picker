import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

class ScrollItem extends StatelessWidget {
  final String label;

  const ScrollItem({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: kDefaultItemTextStyle,
        ),
      ),
    );
  }
}
