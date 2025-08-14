import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class ChildAccountBox extends StatelessWidget {
  const ChildAccountBox({
    super.key,
    required this.babyName,
    required this.isSelected,
    this.onTap,
    this.imageUrl,
  });
  final String babyName;
  final bool isSelected;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // final UserDataCubit userDataCubit = context.read<UserDataCubit>();
    return SizedBox(
      height: 56,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? ColorConstants.primaryRedColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(42)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12) +
                EdgeInsets.only(left: 23, right: 46),
            child: Row(
              children: [
                SizedBox(width: 12),
                SizedBox(
                  width: context.deviceWidth * 0.58,
                  child: GlobalText(
                    height: 1.4,
                    textAlign: TextAlign.left,
                    text: babyName,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1D2939),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
