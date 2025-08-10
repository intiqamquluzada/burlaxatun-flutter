import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../../widgets/global_text.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({
    super.key,
    required this.time,
    required this.isSelected,
  });

  final String time;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffFDECF2) : Color(0xffE8E8E8),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: GlobalText(
              text: time,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? ColorConstants.primaryRedColor
                  : Color(0xff98A2B3),
            ),
          ),
        ),
      ),
    );
  }
}
