import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter/theme/app_constants.dart';

const double _bottomPadding = 62;
const double _rectangleHeight = 20;
const double _circleSize = 36;

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.12),
      highlightColor: Colors.white24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRows(screenWidth),
          const Spacer(),
          _buildBottomRows(screenWidth),
        ],
      ),
    );
  }

  Widget _buildTopRows(double screenWidth) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerText(
              topPadding: 61,
              width: screenWidth * 0.3,
            ),
            _buildShimmerText(
              topPadding: 10,
              width: screenWidth * 0.25,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 79, right: Metrics.spacing20),
          child: Container(
            width: _circleSize,
            height: _circleSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerText({
    double? topPadding,
    double? bottomPadding,
    double? width,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: Metrics.spacing20,
        top: topPadding ?? 0,
        right: Metrics.spacing20,
        bottom: bottomPadding ?? 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_rectangleHeight / 2),
          color: Colors.black,
        ),
        width: width,
        height: _rectangleHeight,
      ),
    );
  }

  Widget _buildBottomRows(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerText(
          topPadding: 0,
          width: screenWidth * 0.1,
        ),
        _buildShimmerText(
          topPadding: Metrics.spacing16,
          width: screenWidth * 0.67,
        ),
        _buildShimmerText(
          topPadding: Metrics.spacing10,
          width: screenWidth * 0.3,
        ),
        _buildShimmerText(
          topPadding: Metrics.spacing16,
          width: screenWidth * 0.84,
        ),
        _buildShimmerText(
          topPadding: Metrics.spacing10,
          bottomPadding: _bottomPadding,
          width: screenWidth * 0.5,
        ),
      ],
    );
  }
}
