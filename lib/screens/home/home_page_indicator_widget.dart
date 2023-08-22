import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

const _opacityUnselectedColor = 0.2;
const _indicatorSize = 8.0;
const dotIndicatorSize = Size(
  _indicatorSize,
  _indicatorSize,
);

class HomePageIndicatorWidget extends StatelessWidget {
  final int surveysLength;
  final ValueNotifier<int> currentPage;

  const HomePageIndicatorWidget({
    Key? key,
    required this.surveysLength,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentPage,
        builder: (BuildContext context, int value, Widget? child) {
          return PageViewDotIndicator(
            currentItem: currentPage.value,
            count: surveysLength,
            selectedColor: Colors.white,
            unselectedColor: Colors.white.withOpacity(_opacityUnselectedColor),
            size: dotIndicatorSize,
            unselectedSize: dotIndicatorSize,
            alignment: Alignment.bottomLeft,
          );
        });
  }
}
