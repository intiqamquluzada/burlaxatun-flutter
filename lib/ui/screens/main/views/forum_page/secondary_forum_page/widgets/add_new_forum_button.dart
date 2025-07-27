import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../utils/constants/color_constants.dart';
import '../../new_forum_page/create_new_forum.dart';

class AddNewForumButton extends StatelessWidget {
  const AddNewForumButton({
    super.key,
    required this.categoryId,
  });

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => CreateNewForum(categoryId: categoryId),
          ),
        );
      },
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
