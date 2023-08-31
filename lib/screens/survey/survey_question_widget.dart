import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _counterOpacity = 0.5;

class SurveyQuestionWidget extends StatelessWidget {
  final int displayOrder;
  final int numberOfQuestions;

  const SurveyQuestionWidget({
    Key? key,
    required this.displayOrder,
    required this.numberOfQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Metrics.spacing54,
          horizontal: Metrics.spacing20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionCounter(context),
            const SizedBox(height: Metrics.spacing8),
            _buildQuestion(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCounter(BuildContext context) => Text(
        "$displayOrder/$numberOfQuestions",
        style: context.textTheme.headlineSmall
            ?.copyWith(color: Colors.white.withOpacity(_counterOpacity)),
      );

  Widget _buildQuestion(BuildContext context) =>
      // TODO: remove text in integrate
      Text(
        "How fulfilled did you feel during this WFH period?",
        style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        maxLines: 3,
      );
}
