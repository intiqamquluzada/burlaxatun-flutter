import 'dart:developer';

import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import 'comments_box.dart';

class ForumCommentsCustomScroll extends StatelessWidget {
  const ForumCommentsCustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
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
            sliver: BlocSelector<ForumCommentsCubit, ForumCommentsState,
                List<Comments>?>(
              selector: (ForumCommentsState state) {
                return state.comments ?? [];
              },
              builder: (context, commentList) {
                log('comment count: ${commentList!.length}');

                return commentList.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: SizedBox(
                            child: GlobalText(text: 'İlk şərhi yaz'),
                          ),
                        ),
                      )
                    : CommentsBox(commentList: commentList);
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
