import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
import '../../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({
    super.key,
    required this.forumId,
    required this.scrollController,
    // this.comment,
  });
  final int forumId;

  final ScrollController scrollController;
  // final Comments? comment;
  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late MainnCubit mainCubit;
  late CreateCommentCubit createCommentCubit;
  late ForumCommentsCubit forumCommentsCubit;

  @override
  void initState() {
    mainCubit = context.read<MainnCubit>();
    createCommentCubit = context.read<CreateCommentCubit>();
    forumCommentsCubit = context.read<ForumCommentsCubit>();
    mainCubit.commentInputTextController = TextEditingController();
    super.initState();
  }

  void _doAfterSuccess({bool isReplySuccess = false}) {
    mainCubit.commentInputTextController.text = '';
    isReplySuccess
        ? null
        : widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent - 30,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
    createCommentCubit.selectedComment.value = null;
  }

  @override
  void dispose() {
    mainCubit.commentInputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
        height: 89,
        width: context.deviceWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 274,
                height: 43,
                child: BlocBuilder<MainnCubit, MainInitial>(
                  buildWhen: (previous, current) {
                    return previous.userTag != current.userTag;
                  },
                  builder: (context, state) {
                    // log(mainCubit.commentInputTextController.text);
                    return ValueListenableBuilder(
                      valueListenable: createCommentCubit.selectedComment,
                      builder: (context, comment, child) {
                        return TextFormField(
                          controller: mainCubit.commentInputTextController,
                          focusNode: mainCubit.commentInputFocusNode,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              createCommentCubit.selectedComment.value = null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(245, 245, 245, 1),
                            contentPadding: EdgeInsets.only(left: 16),
                            hintText:
                                comment == null ? 'Mesajınızı qeyd edin' : null,
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0xff595959),
                              fontWeight: FontWeight.w400,
                            ),
                            // prefixIconConstraints: widget.comment == null
                            //     ? null
                            //     : BoxConstraints(
                            //         minWidth: 0,
                            //         minHeight: 0,
                            //       ),
                            prefixIcon: comment == null
                                ? null
                                : Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '@${comment.user?.fullName ?? 'user'}',
                                          style: TextStyle(
                                            color:
                                                ColorConstants.primaryRedColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: ColorConstants.enabledInputColor,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(width: 11),
              GestureDetector(
                onTap: () {
                  mainCubit.commentInputFocusNode.requestFocus();
                },
                child: SvgPicture.asset('assets/icons/edit_text_icon.svg'),
              ),
              SizedBox(width: 16),
              BlocConsumer<CreateCommentCubit, CreateCommentState>(
                buildWhen: (previous, current) {
                  return previous.createCommentStatus !=
                      current.createCommentStatus;
                },
                listener: (context, state) {
                  if (state.createCommentStatus ==
                      CreateCommentStatus.commentSuccess) {
                    _doAfterSuccess();

                    forumCommentsCubit.updateListWithSendedComment(
                      state.sendedComment!,
                    );
                  } else if (state.createCommentStatus ==
                      CreateCommentStatus.replySuccess) {
                    _doAfterSuccess(isReplySuccess: true);
                  } else if (state.createCommentStatus ==
                      CreateCommentStatus.error) {
                    AppSnackbars.error(context, 'Şərh yazarkən xəta baş verdi');
                  }
                },
                builder: (context, state) {
                  final isLoading = state.createCommentStatus ==
                          CreateCommentStatus.commentLoading ||
                      state.createCommentStatus ==
                          CreateCommentStatus.replyLoading;
                  return GestureDetector(
                    onTap: () {
                      mainCubit.commentInputFocusNode.unfocus();

                      createCommentCubit.sendComment(
                        forumId: widget.forumId,
                        text: mainCubit.commentInputTextController.text,
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/icons/send_text_icon.svg',
                      colorFilter: ColorFilter.mode(
                        isLoading
                            ? ColorConstants.disabledButtonColor
                            : ColorConstants.black800,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
