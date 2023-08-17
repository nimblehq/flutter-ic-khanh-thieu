import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

const _opacityUnselectedColor = 0.2;
const _indicatorSize = 8.0;
const dotIndicatorSize = Size(
  _indicatorSize,
  _indicatorSize,
);

class HomePageIndicatorWidget extends StatelessWidget {
  const HomePageIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: currentItem and count handled in Integrate
    return PageViewDotIndicator(
      currentItem: 1,
      count: 3,
      selectedColor: Colors.white,
      unselectedColor: Colors.white.withOpacity(_opacityUnselectedColor),
      size: dotIndicatorSize,
      unselectedSize: dotIndicatorSize,
      alignment: Alignment.bottomLeft,
    );
  }
}
