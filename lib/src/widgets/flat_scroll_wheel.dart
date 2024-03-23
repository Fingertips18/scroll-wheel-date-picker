import 'package:flutter/material.dart';

import '../controllers/flat_scroll_wheel_view.dart';
import '../constants/theme_constant.dart';
import 'scroll_item.dart';

class FlatScrollWheel extends StatefulWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int value)? onIndexChanged;
  final bool looping;

  const FlatScrollWheel({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onIndexChanged,
    required this.looping,
  });

  @override
  State<FlatScrollWheel> createState() => _FlatScrollWheelState();
}

class _FlatScrollWheelState extends State<FlatScrollWheel> {
  late final FlatScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FlatScrollController(initialItem: widget.selectedIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.position.isScrollingNotifier.addListener(() {
        if (!_controller.position.isScrollingNotifier.value) {
          if (widget.onIndexChanged != null) {
            widget.onIndexChanged!(_controller.selectedItem % widget.items.length);
          }
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant FlatScrollWheel oldWidget) {
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
    return FlatScrollWheelView(
      controller: _controller,
      physics: const FlatScrollPhysics(),
      itemExtent: kDefaultItemHeight,
      itemCount: widget.items.length,
      itemBuilder: (context, itemIndex) {
        return ScrollItem(
          label: widget.items[itemIndex],
        );
      },
    );
  }
}
