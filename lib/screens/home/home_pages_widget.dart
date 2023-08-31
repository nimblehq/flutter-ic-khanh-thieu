import 'package:flutter/material.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/home/home_footer_widget.dart';
import 'package:survey_flutter/theme/app_constants.dart';

import '../../gen/assets.gen.dart';

const _imageOpacity = 0.6;

class HomePagesWidget extends StatefulWidget {
  final List<SurveyModel> surveys;
  final ValueNotifier<int> currentPage;
  final VoidCallback onNextButtonPressed;
  final bool isRefreshing;
  final VoidCallback onLoadMore;

  const HomePagesWidget({
    Key? key,
    required this.surveys,
    required this.currentPage,
    required this.onNextButtonPressed,
    required this.onLoadMore,
    required this.isRefreshing,
  }) : super(key: key);

  @override
  State<HomePagesWidget> createState() => _HomePagesWidgetState();
}

class _HomePagesWidgetState extends State<HomePagesWidget> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChanged(int index) {
    widget.currentPage.value = index;

    if (index == widget.surveys.length - 1) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRefreshing && widget.surveys.isNotEmpty) {
      _pageController.jumpToPage(0);
    }

    return PageView.builder(
      itemCount: widget.surveys.length,
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
                  image: widget.surveys[index].coverImageUrl,
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
                        survey: widget.surveys[index],
                        onNextButtonPressed: widget.onNextButtonPressed,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onPageChanged: _handlePageChanged,
    );
  }
}
