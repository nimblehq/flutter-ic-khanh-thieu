import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _descriptionOpacity = 0.7;
const _buttonSize = 56.0;

class HomeFooterWidget extends StatelessWidget {
  final SurveyModel survey;
  final VoidCallback onNextButtonPressed;

  const HomeFooterWidget({
    Key? key,
    required this.survey,
    required this.onNextButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Metrics.spacing20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: Metrics.spacing16),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      survey.title,
      style: context.textTheme.titleMedium,
      maxLines: 2,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            survey.description,
            style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(_descriptionOpacity)),
            maxLines: 2,
          ),
        ),
        _buildNextButton(),
      ],
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
        onPressed: onNextButtonPressed,
        child: Image.asset(
          Assets.images.next.path,
          color: Colors.black,
        ),
      ),
    );
  }
}
