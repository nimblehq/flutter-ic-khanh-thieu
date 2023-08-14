import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:survey_flutter/theme/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:survey_flutter/utils/build_context_ext.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDateFormatted = _formatCurrentDate();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Metrics.spacing20,
          vertical: Metrics.spacing28,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderInfo(context, currentDateFormatted),
            _buildProfileAvatar(),
          ],
        ),
      ),
    );
  }

  String _formatCurrentDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM dd').format(now).toUpperCase();
  }

  Widget _buildHeaderInfo(BuildContext context, String currentDateFormatted) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentDateFormatted,
            style: context.textTheme.labelSmall,
          ),
          const SizedBox(height: Metrics.spacing4),
          Text(
            "Today",
            style: context.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Padding(
      padding: const EdgeInsets.only(top: Metrics.spacing20),
      child: SizedBox(
        width: Metrics.avatarSize,
        height: Metrics.avatarSize,
        child: CircleAvatar(
          radius: Metrics.avatarSize,
          backgroundImage: AssetImage(Assets.images.dummyAvatar.path),
        ),
      ),
    );
  }
}
