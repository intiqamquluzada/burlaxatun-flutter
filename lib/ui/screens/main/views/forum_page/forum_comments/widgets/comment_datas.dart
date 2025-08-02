import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../cubits/edit_comment/edit_comment_cubit.dart';
import '../../../../../../../cubits/report_or_block_user/report_or_block_user_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../../utils/di/locator.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../utils/helper/past_helper.dart';
import '../../../../../../widgets/global_text.dart';
import '../../../../../../widgets/report_comment_or_block_user.dart';

class CommentDatas extends StatefulWidget {
  const CommentDatas({
    super.key,
    this.comment,
    this.tag,
  });

  final Comments? comment;
  final String? tag;

  @override
  State<CommentDatas> createState() => _CommentDatasState();
}

class _CommentDatasState extends State<CommentDatas>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    log('Build commnet data');
    final ValueNotifier<Comments> commentValue =
        ValueNotifier<Comments>(widget.comment!);
    final userName = widget.comment?.user?.fullName ?? 'user';
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
                      text: PastHelper.timeAgo(
                          widget.comment!.createdAt.toString()),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              6.h,
              Row(
                children: [
                  Visibility(
                    visible: widget.tag != null,
                    child: GlobalText(
                      height: 1.4,
                      textAlign: TextAlign.left,
                      text: '@${widget.tag}',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 7),
                  ValueListenableBuilder(
                    valueListenable: commentValue,
                    builder: (context, value, child) {
                      return BlocListener<EditCommentCubit, EditCommentState>(
                        listener: (context, state) {
                          if (state.editCommentStatus ==
                              EditCommentStatus.success) {
                            if (widget.comment?.id == state.editedComment?.id) {
                              commentValue.value = state.editedComment!;
                            }
                          } else if (state.editCommentStatus ==
                              EditCommentStatus.error) {
                            AppSnackbars.error(
                                context, 'Redaktə edərkən xəta baş verdi');
                          }
                        },
                        child: GlobalText(
                          height: 1.4,
                          textAlign: TextAlign.left,
                          text: value.text ?? 'comment text not found',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              log('${widget.comment?.text}');
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => locator<ReportOrBlockUserCubit>(),
                    child: ReportCommentOrBlockUser(
                      userId: widget.comment?.user?.id,
                      commentId: widget.comment?.id,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
