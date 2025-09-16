import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/global_text.dart';

class AdviseText extends StatelessWidget {
  final String adviceText;

  const AdviseText({
    super.key,
    required this.adviceText,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalText(
      textAlign: TextAlign.left,
      text: adviceText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorConstants.gray600,
    );
  }
}
