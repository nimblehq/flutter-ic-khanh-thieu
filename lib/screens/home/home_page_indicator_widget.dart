import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

const _opacityUnselectedColor = 0.2;

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
      size: const Size(
        Metrics.homePageIndicatorSize,
        Metrics.homePageIndicatorSize,
      ),
      unselectedSize: const Size(
        Metrics.homePageIndicatorSize,
        Metrics.homePageIndicatorSize,
      ),
      alignment: Alignment.bottomLeft,
    );
  }
}
