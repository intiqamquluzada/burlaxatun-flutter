import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants/color_constants.dart';

class GlobalDots extends StatelessWidget {
  const GlobalDots({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: CustomizableEffect(
        spacing: 6,
        dotDecoration: DotDecoration(
          width: 37,
          color: ColorConstants.inactiveDotColor,
          borderRadius: BorderRadius.all(Radius.circular(19)),
        ),
        activeDotDecoration: DotDecoration(
          width: 16,
          color: ColorConstants.primaryRedColor,
          borderRadius: BorderRadius.all(Radius.circular(19)),
        ),
      ),
    );
  }
}
