import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';
import 'package:survey_flutter/utils/date_time_util.dart';

const _avatarSize = 36.0;

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now().fullDate.toUpperCase();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Metrics.spacing20,
          vertical: Metrics.spacing28,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderInfo(context, currentDate),
            const Spacer(),
            _buildProfileAvatar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(BuildContext context, String currentDateFormatted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentDateFormatted,
          style: context.textTheme.labelSmall,
        ),
        const SizedBox(height: Metrics.spacing4),
        Text(
          context.localizations?.today ?? "",
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      margin: const EdgeInsets.only(top: Metrics.spacing20),
      width: _avatarSize,
      height: _avatarSize,
      child: CircleAvatar(
        radius: _avatarSize,
        backgroundImage: AssetImage(Assets.images.dummyAvatar.path),
      ),
    );
  }
}
