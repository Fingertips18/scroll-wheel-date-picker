import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';

class CurveScrollWheel extends StatefulWidget {
  final List<String> items;
  final int initialIndex;

  const CurveScrollWheel({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  @override
  State<CurveScrollWheel> createState() => _CurveScrollWheelState();
}

class _CurveScrollWheelState extends State<CurveScrollWheel> {
  late final FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController(initialItem: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: _controller,
      physics: const FixedExtentScrollPhysics(),
      diameterRatio: kDefaultDiameterRatio,
      itemExtent: kDefaultItemHeight,
      overAndUnderCenterOpacity: kNotActiveItemOpacity,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.items.length,
        builder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                widget.items[index],
                style: kDefaultItemTextStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
