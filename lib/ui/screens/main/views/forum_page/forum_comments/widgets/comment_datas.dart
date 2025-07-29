import 'dart:developer';

import 'package:burla_xatun/cubits/report_or_block_user/report_or_block_user_cubit.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';
import '../../../../../../widgets/report_comment_or_block_user.dart';

class CommentDatas extends StatelessWidget {
  const CommentDatas({
    super.key,
    this.comment,
  });

  final Comments? comment;

  @override
  Widget build(BuildContext context) {
    final userName = comment?.user?.fullName ?? 'user';
    final text = comment?.text ?? 'comment text not found';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: '',
          errorWidget: (context, url, error) {
            return Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: Icon(Icons.person),
            );
          },
        ),
        // Image.asset(
        //   'assets/png/comment_user_pic.png',
        //   width: 44,
        //   height: 44,
        // ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlobalText(
                    text: '@$userName',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GlobalText(
                      text: '1 minute ago',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              6.h,
              GlobalText(
                height: 1.4,
                textAlign: TextAlign.left,
                text: text,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              log('tap on bloc icon');
              log('${comment?.text}');
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => locator<ReportOrBlockUserCubit>(),
                    child: ReportCommentOrBlockUser(
                      userId: comment?.user?.id,
                      commentId: comment?.id,
                    ),
                  );
                },
              );
            },
            child: Ink(
              child: InkWell(
                child: SvgPicture.asset(
                    'assets/icons/comment_report_or_block_iicon.svg'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
