import 'package:flutter/material.dart';
import 'package:survey_flutter/screens/home/home_header_widget.dart';
import 'package:survey_flutter/screens/home/home_pages_widget.dart';
import 'package:survey_flutter/screens/home/home_page_indicator_widget.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomePagesWidget(),
        const HomeHeaderWidget(),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 220),
            child: HomePageIndicatorWidget(),
          ),
        ),
      ],
    );
  }
}
