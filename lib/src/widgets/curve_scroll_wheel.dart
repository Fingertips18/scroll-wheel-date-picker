import 'package:flutter/material.dart';

import '../constants/theme_constant.dart';
import 'scroll_item.dart';

class CurveScrollWheel extends StatefulWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int value)? onSelectedItemChanged;
  final bool looping;

  const CurveScrollWheel({
    super.key,
    required this.items,
    required this.selectedIndex,
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

    _controller = FixedExtentScrollController(initialItem: widget.selectedIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.position.isScrollingNotifier.addListener(() {
        if (!_controller.position.isScrollingNotifier.value) {
          if (widget.onSelectedItemChanged != null) {
            widget.onSelectedItemChanged!(_controller.selectedItem % widget.items.length);
          }
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant CurveScrollWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.jumpToItem(widget.selectedIndex);
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
      childDelegate: widget.looping
          ? ListWheelChildLoopingListDelegate(
              children: List.generate(
                widget.items.length,
                (i) {
                  return ScrollItem(
                    label: widget.items[i],
                  );
                },
              ),
            )
          : ListWheelChildBuilderDelegate(
              childCount: widget.items.length,
              builder: (_, index) {
                return ScrollItem(
                  label: widget.items[index],
                );
              },
            ),
    );
  }
}
