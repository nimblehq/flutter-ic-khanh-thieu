import 'package:flutter/material.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_footer_widget.dart';
import 'package:survey_flutter/theme/app_constants.dart';

import '../../gen/assets.gen.dart';

const _imageOpacity = 0.6;

class HomePagesWidget extends StatelessWidget {
  final List<SurveyModel> surveys;
  final ValueNotifier<int> currentPage;
  final PageController _pageController = PageController();

  HomePagesWidget({
    Key? key,
    required this.surveys,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: surveys.length,
      controller: _pageController,
      itemBuilder: (_, int index) {
        return Container(
          color: Colors.black,
          child: Stack(
            children: [
              Opacity(
                opacity: _imageOpacity,
                child: FadeInImage.assetNetwork(
                  placeholder: Assets.images.placeholder.path,
                  image: surveys[index].coverImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        bottom: Metrics.spacing20,
                        right: 0,
                      ),
                      child: HomeFooterWidget(
                        survey: surveys[index],
                        onNextButtonPressed: () {
                          if (currentPage.value < surveys.length - 1) {
                            currentPage.value = index + 1;
                            _pageController.jumpToPage(currentPage.value);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onPageChanged: (int index) {
        currentPage.value = index;
      },
    );
  }
}
