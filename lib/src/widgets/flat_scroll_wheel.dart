import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter/material.dart';

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
  late final InfiniteScrollController _scrollController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _scrollController = InfiniteScrollController(initialItem: widget.selectedIndex);

    _currentIndex = widget.selectedIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.position.isScrollingNotifier.addListener(() {
        if (!_scrollController.position.isScrollingNotifier.value) {
          if (widget.onIndexChanged != null) {
            widget.onIndexChanged!(_scrollController.selectedItem % widget.items.length);
          }
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant FlatScrollWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scrollController.jumpToItem(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      controller: _scrollController,
      itemCount: widget.items.length,
      itemExtent: kDefaultItemHeight,
      axisDirection: Axis.vertical,
      loop: widget.looping,
      physics: const InfiniteScrollPhysics(),
      velocityFactor: 1.0,
      onIndexChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (__, itemIndex, _) {
        return AnimatedOpacity(
          opacity: itemIndex == _currentIndex ? 1.0 : kNotActiveItemOpacity,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          child: ScrollItem(label: widget.items[itemIndex]),
        );
      },
    );
  }
}
