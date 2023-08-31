import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/survey/survey_question_widget.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/theme/primary_button_style.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _buttonSize = 56.0;
const _closeButtonSize = 28.0;
const _paddingButtons = EdgeInsets.only(bottom: 54.0, right: 20.0);
const _displayOrder = 1;
const _numberOfQuestions = 5;

class SurveyScreen extends StatelessWidget {
  final _pageController = PageController();

  SurveyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.dummyBackground.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          PageView.builder(
            itemCount: _numberOfQuestions,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              return const SurveyQuestionWidget(
                displayOrder: _displayOrder,
                numberOfQuestions: _numberOfQuestions,
              );
            },
            onPageChanged: (int index) {
              // TODO: handle in integrate
            },
          ),
          _buildCloseButton(context),
          _buildBottomButtons(isNext: true, context: context),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: Metrics.spacing54,
      right: Metrics.spacing16,
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          width: _closeButtonSize,
          height: _closeButtonSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Image.asset(
            Assets.images.closeButton.path,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(
      {required bool isNext, required BuildContext context}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: _paddingButtons,
        child: isNext ? _buildNextButton() : _buildSubmitButton(context),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      height: _buttonSize,
      child: ElevatedButton(
        style: PrimaryButtonStyle(
          hintTextStyle: context.textTheme.labelSmall,
        ),
        child: Text(
          context.localizations.submitText,
        ),
        onPressed: () {
          // TODO: Submit survey
        },
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: _buttonSize,
      height: _buttonSize,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black12,
        ),
        onPressed: _nextPage,
        child: Image.asset(
          Assets.images.next.path,
          color: Colors.black,
        ),
      ),
    );
  }
}
