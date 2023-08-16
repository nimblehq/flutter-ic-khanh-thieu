import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_footer_widget.dart';
import 'package:survey_flutter/theme/app_constants.dart';

class HomePagesWidget extends StatelessWidget {
  final PageController _pageController = PageController();

  HomePagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: itemCount and background image handled in integrate
    return PageView.builder(
      itemCount: 4,
      controller: _pageController,
      itemBuilder: (_, int index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.dummyBackground.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const Spacer(), // Space above footer
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    bottom: Metrics.spacing20,
                    right: 0,
                  ),
                  child: HomeFooterWidget(
                    onNextButtonPressed: () {
                      // Handle the next button pressed event
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
