import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../cubits/edit_comment/edit_comment_cubit.dart';
import '../../../../../../../cubits/report_or_block_user/report_or_block_user_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../../utils/constants/endpoints_constants.dart';
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
  final ValueNotifier<Comments?> commentValue = ValueNotifier<Comments?>(null);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final profileImage = widget.comment?.user?.image;

    final userName = widget.comment?.user?.fullName ?? 'user';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            imageUrl: profileImage ?? '',
            errorWidget: (context, url, error) => SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
                child: Icon(Icons.person),
              ),
            ),
            fadeInCurve: Curves.easeIn,
            placeholder: (context, url) {
              return Column(
                children: [
                  CircularProgressIndicator.adaptive(),
                ],
              );
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GlobalText(
                      text: '@$userName',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: GlobalText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: PastHelper.timeAgo(
                        widget.comment!.createdAt.toString(),
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              6.h,
              SizedBox(
                child: ValueListenableBuilder(
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
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            height: 1.4,
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  widget.tag != null ? '@${widget.tag}  ' : '',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: value == null
                                  ? widget.comment?.text
                                  : value.text,
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      // GlobalText(
                      //   height: 1.4,
                      //   textAlign: TextAlign.left,
                      //   text: '${value.text}forekofjoiejiofjeofoi' ??
                      //       'comment text not found',
                      //   fontSize: 13,
                      //   fontWeight: FontWeight.w400,
                      //   color: Colors.black,
                      // ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: () {
              log('${widget.comment?.text}');
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ReportCommentOrBlockUser(
                    userId: widget.comment?.user?.id,
                    commentId: widget.comment?.id,
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
