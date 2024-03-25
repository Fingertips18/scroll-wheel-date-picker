import 'package:flutter/material.dart';

import 'flat_wheel_scroll_view.dart';
import 'scroll_item.dart';

class FlatScrollWheel extends StatefulWidget {
  /// `Based on [ListWheelScrollView] but with a flat perspective.`
  ///
  /// Custom physics and controller based on the [FixedExtentScrollPhysics] and [FixedExtentScrollController].
  ///
  /// [items] Total items to render for the [FlatScrollWheel].
  ///
  /// [selectedIndex] Selected index of a specific [FlatScrollWheel]'s item.
  ///
  /// [onSelectedItemChanged] Callback fired when an item is changed.
  ///
  /// [looping] Whether to create an infinite scroll loop of the items in the [FlatScrollWheel].
  ///
  /// [itemExtent] Maximum height of each [FlatScrollWheel]'s items.
  ///
  /// [textStyle] Text style of the items in the [FlatScrollWheel].
  const FlatScrollWheel({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onSelectedItemChanged,
    required this.looping,
    required this.itemExtent,
    required this.textStyle,
    required this.changeAfterAnimation,
  });

  /// Total items to render for the [FlatScrollWheel].
  final List<String> items;

  /// Selected index of a specific [FlatScrollWheel]'s item.
  final int selectedIndex;

  /// Callback fired when an item is changed.
  final Function(int value)? onSelectedItemChanged;

  /// Whether to create an infinite scroll loop of the items in the [FlatScrollWheel].
  final bool looping;

  /// Maximum height of each [FlatScrollWheel]'s items.
  final double itemExtent;

  /// Text style of the items in the [FlatScrollWheel].
  final TextStyle textStyle;

  /// Whether to call the [onSelectedItemChanged] when the scroll wheel animation is completed. Defaults to `true`.
  final bool changeAfterAnimation;

  @override
  State<FlatScrollWheel> createState() => _FlatScrollWheelState();
}

class _FlatScrollWheelState extends State<FlatScrollWheel> {
  late final FlatScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FlatScrollController(initialItem: widget.selectedIndex);

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
  void didUpdateWidget(covariant FlatScrollWheel oldWidget) {
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
    return FlatWheelScrollView(
      controller: _controller,
      physics: const FlatScrollPhysics(),
      itemExtent: widget.itemExtent,
      itemCount: widget.items.length,
      looping: widget.looping,
      onSelectedItemChanged: widget.changeAfterAnimation ? null : widget.onSelectedItemChanged,
      itemBuilder: (context, itemIndex) {
        return ScrollItem(
          label: widget.items[itemIndex],
          textStyle: widget.textStyle,
        );
      },
    );
  }
}
