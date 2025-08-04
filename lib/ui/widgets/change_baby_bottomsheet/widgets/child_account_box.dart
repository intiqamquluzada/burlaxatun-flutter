import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extensions.dart';
import '../../global_text.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: isSelected
                ? ColorConstants.primaryRedColor
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(42)),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12) +
              EdgeInsets.only(left: 23, right: 46),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 52,
                    height: 52,
                    imageUrl: imageUrl ?? '',
                    errorWidget: (context, url, error) {
                      return Icon(Icons.person);
                    },
                  ),
                ),
              ),
              // Image.asset(
              //   'assets/png/baby_acc_pic.png',
              // width: 52,
              // height: 52,
              // ),
              SizedBox(width: 12),
              SizedBox(
                width: context.deviceWidth * 0.58,
                child: GlobalText(
                  height: 1.4,
                  textAlign: TextAlign.left,
                  text: babyName,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff5B5B5B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
