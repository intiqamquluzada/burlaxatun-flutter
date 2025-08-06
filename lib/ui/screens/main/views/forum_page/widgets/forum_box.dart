import 'dart:developer';

import 'package:burla_xatun/ui/widgets/report_or_block_forum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/global_text.dart';

class ForumBox extends StatelessWidget {
  const ForumBox({
    super.key,
    required this.authorName,
    required this.forumTitle,
    required this.likeCount,
    required this.viewCount,
    required this.commentCount,
    required this.forumId,
    this.onTap,
  });
  final int forumId;
  final VoidCallback? onTap;
  final String authorName;
  final String forumTitle;
  final int likeCount;
  final String viewCount;
  final String commentCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffF7F7F7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GlobalText(
                      text: authorName,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      GlobalText(
                        text: 'Daha ətraflı',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff97989D),
                      ),
                      SizedBox(width: 7),
                      SvgPicture.asset(
                        'assets/icons/medicine_arrow_right_icon.svg',
                      ),
                    ],
                  ),
                ],
              ),
              8.h,
              SizedBox(
                width: context.deviceWidth * 0.62,
                child: GlobalText(
                  height: 1.4,
                  textAlign: TextAlign.left,
                  text: forumTitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              20.h,
              Row(
                spacing: 30,
                children: [
                  GlobalText(
                    textAlign: TextAlign.left,
                    text: '$viewCount Baxış',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  // GlobalText(
                  //   textAlign: TextAlign.left,
                  //   text: '$likeCount Bəyənmə',
                  //   fontSize: 10,
                  //   fontWeight: FontWeight.w400,
                  //   color: Colors.black,
                  // ),
                  GlobalText(
                    textAlign: TextAlign.left,
                    text: '$commentCount Rəy',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      log('forum id: $forumId');
                      showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        builder: (context) {
                          return ReportOrBlockForum(forumId: forumId);
                        },
                      );
                    },
                    child: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
