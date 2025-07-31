import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/delete_comment/delete_comment_cubit.dart';
import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../widgets/global_text.dart';
import 'comments_box.dart';

class ForumCommentsCustomScroll extends StatelessWidget {
  const ForumCommentsCustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
    // final ValueNotifier<List<Comments>> list =
    //     ValueNotifier<List<Comments>>([]);
    final forumCommentsCubit = context.read<ForumCommentsCubit>();
    final deleteCommentCubit = context.read<DeleteCommentCubit>();

    return BlocBuilder<ForumCommentsCubit, ForumCommentsState>(
      buildWhen: (previous, current) {
        return previous.comments == null;
      },
      builder: (context, state) {
        if (state.forumCommentStatus == ForumCommentStatus.loading) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state.forumCommentStatus == ForumCommentStatus.error) {
          return SliverToBoxAdapter(
            child: Center(child: Text('comments not found')),
          );
        }
        if (state.forumCommentStatus == ForumCommentStatus.success) {
          return SliverPadding(
            padding: const EdgeInsets.only(bottom: 0),
            sliver: BlocBuilder<ForumCommentsCubit, ForumCommentsState>(
              buildWhen: (previous, current) {
                return previous.comments != current.comments;
              },
              builder: (context, state) {
                // list.value = state.comments ?? [];
                return state.comments!.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: SizedBox(
                            child: GlobalText(text: 'İlk şərhi yaz'),
                          ),
                        ),
                      )
                    : BlocListener<DeleteCommentCubit, DeleteCommentState>(
                        listener: (context, state) {
                          if (state.deleteCommentStatus ==
                              DeleteCommentStatus.success) {
                            AppSnackbars.success(context, 'Şərh silindi');
                          } else if (state.deleteCommentStatus ==
                              DeleteCommentStatus.success) {
                            AppSnackbars.error(
                                context, 'Şərhi silərkən xəta baş verdi');
                          }
                        },
                        child: CommentsBox(commentList: state.comments ?? []),
                      );
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
