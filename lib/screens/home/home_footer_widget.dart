import 'package:flutter/material.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

const _descriptionOpacity = 0.7;
const _contentPadding = EdgeInsets.symmetric(horizontal: 20.0);

class HomeFooterWidget extends StatelessWidget {
  const HomeFooterWidget({Key? key, required VoidCallback onNextButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _contentPadding,
          child: _buildTitle(context),
        ),
        const SizedBox(height: Metrics.defaultHeight),
        Padding(
          padding: _contentPadding,
          child: _buildDescription(context),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    // TODO: Replace with survey title
    return Text(
      "Working from home Check-In",
      style: context.textTheme.titleLarge,
      maxLines: 2,
    );
  }

  Widget _buildDescription(BuildContext context) {
    // TODO: Replace with survey description
    return Row(
      children: [
        Expanded(
          child: Text(
            "We would like to know how you feel about our work from home...",
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
      width: Metrics.primaryButtonSize,
      height: Metrics.primaryButtonSize,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black12,
        ),
        child: Image.asset(
          Assets.images.next.path,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}
