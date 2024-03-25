import 'package:flutter/material.dart';

import 'scroll_item.dart';

class CurveScrollWheel extends StatefulWidget {
  /// `A widget that uses [ListWheelScrollView] to create a scroll with a curve perspective.`
  ///
  /// [items] Total items to render for the [CurveScrollWheel].
  ///
  /// [selectedIndex] Selected index of a specific [CurveScrollWheel]'s item.
  ///
  /// [onSelectedItemChanged] Callback fired when an item is changed.
  ///
  /// [looping] Whether to create an infinite scroll loop of the items in the [CurveScrollWheel].
  ///
  /// [diameterRatio] A curve ratio of the [CurveScrollWheel] in the main axis. Must be a positive number.
  ///
  /// [itemExtent] Maximum height of each [CurveScrollWheel]'s items.
  ///
  /// [overAndUnderCenterOpacity] Opacity of the items in the [CurveScrollWheel] that are off centered.
  ///
  /// [textStyle] Text style of the items in the [CurveScrollWheel].
  const CurveScrollWheel({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onSelectedItemChanged,
    required this.looping,
    required this.diameterRatio,
    required this.itemExtent,
    required this.overAndUnderCenterOpacity,
    required this.textStyle,
    required this.changeAfterAnimation,
  });

  /// Total items to render for the [CurveScrollWheel].
  final List<String> items;

  /// Selected index of a specific [CurveScrollWheel]'s item.
  final int selectedIndex;

  /// Callback fired when an item is changed.
  final Function(int value)? onSelectedItemChanged;

  /// Whether to create an infinite scroll loop of the items in the [CurveScrollWheel].
  final bool looping;

  /// A curve ratio of the [CurveScrollWheel] in the main axis.
  ///
  /// Must be a positive number.
  final double diameterRatio;

  /// Maximum height of each [CurveScrollWheel]'s items.
  final double itemExtent;

  /// Opacity of the items in the [CurveScrollWheel] that are off centered.
  final double overAndUnderCenterOpacity;

  /// Text style of the items in the [CurveScrollWheel].
  final TextStyle textStyle;

  /// Whether to call the [onSelectedItemChanged] when the scroll wheel animation is completed. Defaults to `true`.
  final bool changeAfterAnimation;

  @override
  State<CurveScrollWheel> createState() => _CurveScrollWheelState();
}

class _CurveScrollWheelState extends State<CurveScrollWheel> {
  late final FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController(initialItem: widget.selectedIndex);

    if (widget.changeAfterAnimation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.position.isScrollingNotifier.addListener(() {
          if (!_controller.position.isScrollingNotifier.value) {
            widget.onSelectedItemChanged?.call(_controller.selectedItem % widget.items.length);
          }
        });
      });
    }
  }

  @override
  void didUpdateWidget(covariant CurveScrollWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.jumpToItem(widget.selectedIndex);
    }

    if (oldWidget.changeAfterAnimation != widget.changeAfterAnimation && widget.changeAfterAnimation) {
      _controller.removeListener(() {});
      _controller.position.isScrollingNotifier.addListener(() {
        if (!_controller.position.isScrollingNotifier.value) {
          widget.onSelectedItemChanged?.call(_controller.selectedItem % widget.items.length);
        }
      });
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
      diameterRatio: widget.diameterRatio,
      itemExtent: widget.itemExtent,
      overAndUnderCenterOpacity: widget.overAndUnderCenterOpacity,
      onSelectedItemChanged: widget.changeAfterAnimation ? null : widget.onSelectedItemChanged,
      childDelegate: widget.looping
          ? ListWheelChildLoopingListDelegate(
              children: List.generate(
                widget.items.length,
                (i) {
                  return ScrollItem(
                    label: widget.items[i],
                    textStyle: widget.textStyle,
                  );
                },
              ),
            )
          : ListWheelChildBuilderDelegate(
              childCount: widget.items.length,
              builder: (_, index) {
                return ScrollItem(
                  label: widget.items[index],
                  textStyle: widget.textStyle,
                );
              },
            ),
    );
  }
}
