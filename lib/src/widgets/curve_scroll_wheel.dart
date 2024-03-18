import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';

class CurveScrollWheel extends StatefulWidget {
  final List<String> items;
  final int initialIndex;
  final Function(int value)? onSelectedItemChanged;
  final bool looping;

  const CurveScrollWheel({
    super.key,
    required this.items,
    required this.initialIndex,
    this.onSelectedItemChanged,
    required this.looping,
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
  void didUpdateWidget(covariant CurveScrollWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialIndex != widget.initialIndex) {
      _controller.jumpToItem(widget.initialIndex);
    }
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
      onSelectedItemChanged: widget.onSelectedItemChanged,
      childDelegate: widget.looping
          ? ListWheelChildLoopingListDelegate(
              children: List.generate(
                widget.items.length,
                (i) {
                  return Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.items[i],
                        style: kDefaultItemTextStyle,
                      ),
                    ),
                  );
                },
              ),
            )
          : ListWheelChildBuilderDelegate(
              childCount: widget.items.length,
              builder: (_, index) {
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
