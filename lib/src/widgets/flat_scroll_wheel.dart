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
  ///
  /// [listenAfterAnimation] Whether to call the [onSelectedItemChanged] when the scroll wheel animation is completed. Defaults to `true`.
  const FlatScrollWheel({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onSelectedItemChanged,
    required this.looping,
    required this.itemExtent,
    this.textStyle,
    required this.listenAfterAnimation,
    this.scrollBehavior,
    this.startOffset,
    this.lastOffset,
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
  final TextStyle? textStyle;

  /// Whether to call the [onSelectedItemChanged] when the scroll wheel animation is completed. Defaults to `true`.
  final bool listenAfterAnimation;

  /// Describes how [Scrollable] widgets should behave.
  final ScrollBehavior? scrollBehavior;

  /// Add an offset to the start of the item selection list.
  final int? startOffset;

  /// Add an offset to the end of the item selection list.
  final int? lastOffset;

  @override
  State<FlatScrollWheel> createState() => _FlatScrollWheelState();
}

class _FlatScrollWheelState extends State<FlatScrollWheel> {
  late final FlatScrollController _controller;
  final List<int> _startOffsets = [];
  final List<int> _lastOffsets = [];

  @override
  void initState() {
    super.initState();

    // Initialize the controller.
    _controller = FlatScrollController(initialItem: widget.selectedIndex);

    // Check if the start offset is specified, if yes then generate a list of start offsets to disable.
    if (widget.startOffset != null) {
      _startOffsets.addAll(List.generate(widget.startOffset!, (index) => index));
    }

    // Check if the last offset is specified, if yes then generate a list of last offsets to disable.
    if (widget.lastOffset != null) {
      _lastOffsets.addAll(List.generate(widget.items.length - widget.lastOffset!, (index) => widget.lastOffset! + index));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If `listenAfterAnimation` is enabled, listen when select item is changed.
      if (widget.listenAfterAnimation) {
        _controller.position.isScrollingNotifier.addListener(_handleOnSelectedItemChanged);
      }

      // If `startOffset` is specified, listen on item changed and animate towards the nearest item that is not part of the offset items.
      if (widget.startOffset != null) {
        _controller.position.isScrollingNotifier.addListener(() => _handleOffset(_startOffsets));
      }

      if (widget.lastOffset != null) {
        _controller.position.isScrollingNotifier.addListener(() => _handleOffset(_lastOffsets));
      }
    });
  }

  @override
  void didUpdateWidget(covariant FlatScrollWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Jump to an item if the `selectedIndex` is changed or the `items lenght` is changed.
    if (oldWidget.items.length != widget.items.length || oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.jumpToItem(widget.selectedIndex);
    }

    // Resets the listener of the `_handleOnSelectedItemChanged`.
    if (oldWidget.listenAfterAnimation != widget.listenAfterAnimation && widget.listenAfterAnimation) {
      _controller.position.isScrollingNotifier.removeListener(_handleOnSelectedItemChanged);
      _controller.position.isScrollingNotifier.addListener(_handleOnSelectedItemChanged);
    }

    // Resets the listener of the start offset's `_handleOffset`.
    if (oldWidget.startOffset != widget.startOffset && widget.startOffset != null) {
      // Reset the `_startOffset` list with the new `startOffset` value.
      _startOffsets.clear();
      _startOffsets.addAll(List.generate(widget.startOffset!, (index) => index));

      // Remove the previous `_handleOffset` listener and listen again for the new `startOffset` value.
      _controller.position.isScrollingNotifier.removeListener(() => _handleOffset(_startOffsets));
      _controller.position.isScrollingNotifier.addListener(() => _handleOffset(_startOffsets));
    } else if (oldWidget.startOffset != widget.startOffset && widget.startOffset == null) {
      // If the startOffset is null, then clear the `_startOffset` list and remove the previous listener.
      _startOffsets.clear();
      _controller.position.isScrollingNotifier.removeListener(() => _handleOffset(_startOffsets));
    }

    // Resets the listener of the last offset's `_handleOffset`.
    if (oldWidget.lastOffset != widget.lastOffset && widget.lastOffset != null) {
      // Reset the `_lastOffset` list with the new `lastOffset` value.
      _lastOffsets.clear();
      _lastOffsets.addAll(List.generate(widget.items.length - widget.lastOffset!, (index) => widget.lastOffset! + index));

      // Remove the previous `_handleOffset` listener and listen again for the new `lastOffset` value.
      _controller.position.isScrollingNotifier.removeListener(() => _handleOffset(_lastOffsets));
      _controller.position.isScrollingNotifier.addListener(() => _handleOffset(_lastOffsets));
    } else if (oldWidget.lastOffset != widget.lastOffset && widget.lastOffset == null) {
      // If the lastOffset is null, then clear the `_lastOffset` list and remove the previous listener.
      _lastOffsets.clear();
      _controller.position.isScrollingNotifier.removeListener(() => _handleOffset(_lastOffsets));
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  /// Handles the call of the `onSelectedItemChanged` if it is enabled.
  void _handleOnSelectedItemChanged() {
    // If its not scrolling, then we call `onSelectedItemChanged` to update the value.
    if (!_controller.position.isScrollingNotifier.value) {
      widget.onSelectedItemChanged?.call(_controller.selectedItem % widget.items.length);
    }
  }

  /// Handles the boundary of the selection when item(s) are part of the `startOffsets` or `lastOffsets`.
  void _handleOffset(List<int> offsets) async {
    // Not do anything if it is scrolling.
    if (_controller.position.isScrollingNotifier.value) return;

    // Wait for 800 milliseconds before continuing.
    await Future.delayed(const Duration(milliseconds: 800));

    // Check whether the current selected item is in the `startOffsets` or `lastOffsets`. Return the value if its true and -1 if not.
    final value = offsets.firstWhere((i) => _controller.selectedItem % 100 == i, orElse: () => -1);

    // If it is part of the `startOffsets` or `lastOffsets`, then proceed and not do anything otherwise.
    if (value != -1) {
      // Get the half size or length of the start offset list.
      final halfSize = offsets.length ~/ 2;
      // Get the index of the value in the start offset list.
      final index = offsets.indexOf(value);
      // Check if the index is greater than or equal to the half size.
      // If so, return the difference between the offset list size minus the index.
      // Otherwise, return the index + 1 in negative value.
      // To put it simply, we are doing this to animate towards the nearest item that is outside of the offset list.
      final addOffset = index >= halfSize ? offsets.length - index : -(index + 1);

      // Using the `addOffset`, animate towards the nearest item by the adding the current selected item index with the `addOffset` value.
      _controller.animateToItem(
        _controller.selectedItem + addOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }
  }

  /// Handles the text(s) to mute that are within the `startOffset` and `lastOffset`.
  TextStyle? _handleTextStyle(int itemIndex) {
    // If `_startOffsets` or `_lastOffsets` contains the current `itemIndex`, then mute the item. Otherwise, use the default text style.
    if (_startOffsets.contains(itemIndex) || _lastOffsets.contains(itemIndex)) {
      return widget.textStyle?.copyWith(color: widget.textStyle?.color?.withOpacity(0.2));
    } else {
      return widget.textStyle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatWheelScrollView(
      controller: _controller,
      physics: const FlatScrollPhysics(),
      itemExtent: widget.itemExtent,
      itemCount: widget.items.length,
      looping: widget.looping,
      scrollBehavior: widget.scrollBehavior,
      onSelectedItemChanged: widget.listenAfterAnimation ? null : widget.onSelectedItemChanged,
      itemBuilder: (context, itemIndex) {
        return ScrollItem(
          label: widget.items[itemIndex],
          textStyle: _handleTextStyle(itemIndex),
        );
      },
    );
  }
}
