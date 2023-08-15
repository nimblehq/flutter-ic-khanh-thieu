import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_footer_widget.dart';

class HomePagesWidget extends StatelessWidget {
  final PageController _pageController = PageController();

  HomePagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: itemCount and background image handled in integrate
    return PageView.builder(
      itemCount: 4,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                Assets.images.dummyBackground.path,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()), // Space above footer
                SafeArea(
                  bottom: true,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0, bottom: 20, right: 0),
                    child: HomeFooterWidget(
                      onNextButtonPressed: () {
                        // Handle the next button pressed event
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
