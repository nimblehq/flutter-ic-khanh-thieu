import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/screens/app_route.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/theme/primary_button_style.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _buttonHeight = 56.0;

class SurveyDetailScreen extends StatelessWidget {
  final SurveyModel survey;
  SurveyDetailScreen({
    super.key,
    required this.survey,
  });

  late final _backgroundImage = FadeInImage.assetNetwork(
    placeholder: Assets.images.placeholder.path,
    image: survey.coverImageUrl,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
  );

  late final _gradientOverlay = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.8),
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(0.8),
        ],
      ),
    ),
  );

  Widget _buildTitle(BuildContext context) {
    return Text(
      survey.title,
      style: context.textTheme.titleMedium,
      maxLines: 2,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      survey.description,
      style: context.textTheme.bodyMedium,
      maxLines: 2,
    );
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      height: _buttonHeight,
      child: ElevatedButton(
        style: PrimaryButtonStyle(
          hintTextStyle: context.textTheme.labelMedium,
        ),
        child: Text(
          context.localizations.startSurveyText,
        ),
        onPressed: () {
          // TODO: Pass survey question model
          context.push(
            AppRoute.questions.path,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _backgroundImage,
          _gradientOverlay,
          Container(
            padding: const EdgeInsets.only(
              bottom: Metrics.spacing20,
              left: Metrics.spacing20,
              right: Metrics.spacing20,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(context),
                  const SizedBox(height: Metrics.spacing16),
                  _buildDescription(context),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      _buildButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
