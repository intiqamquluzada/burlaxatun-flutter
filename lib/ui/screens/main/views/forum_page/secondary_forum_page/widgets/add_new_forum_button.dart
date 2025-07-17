import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../utils/constants/color_constants.dart';

class AddNewForumButton extends StatelessWidget {
  const AddNewForumButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 56,
        height: 56,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.primaryRedColor,
          ),
          child: Center(
            child: SvgPicture.asset('assets/icons/add_forum_icon.svg'),
          ),
        ),
      ),
    );
  }
}
