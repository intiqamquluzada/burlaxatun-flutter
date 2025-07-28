import 'dart:developer';

import 'package:burla_xatun/cubits/forum_comments/forum_comments_cubit.dart';
import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../cubits/forum_detail/forum_detail_cubit.dart';
import '../../../../../widgets/custom_refresh_indicator.dart';
import '../../../../../widgets/global_appbar.dart';
import '../widgets/forum_box.dart';
import 'widgets/comment_input.dart';
import 'widgets/forum_comments_custom_scroll.dart';

class ForumCommentsPage extends StatefulWidget {
  const ForumCommentsPage({
    super.key,
    required this.forumId,
  });

  final int forumId;

  @override
  State<ForumCommentsPage> createState() => _ForumCommentsPageState();
}

class _ForumCommentsPageState extends State<ForumCommentsPage> {
  late ScrollController scrollController;
  late ForumCommentsCubit forumCommentsCubit;
  late ValueNotifier<Comments?> selectedComment;
  @override
  void initState() {
    scrollController = ScrollController();
    forumCommentsCubit = context.read<ForumCommentsCubit>();
    selectedComment = ValueNotifier<Comments?>(null);
    _loadMoreComment();
    super.initState();
  }

  void _loadMoreComment() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await forumCommentsCubit.getForumComments(forumId: widget.forumId);
        log('load more comment');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Forum Rəyləri',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await forumCommentsCubit.getForumComments(
            isRefresh: true,
            forumId: widget.forumId,
          );
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: BlocBuilder<ForumDetailCubit, ForumDetailState>(
                  builder: (context, state) {
                    if (state.forumDetailStatus == ForumDetailStatus.loading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state.forumDetailStatus ==
                        ForumDetailStatus.error) {
                      return Center(child: Text('forum details not found'));
                    } else if (state.forumDetailStatus ==
                        ForumDetailStatus.networkError) {
                      return Text('network error');
                    }
                    if (state.forumDetailStatus == ForumDetailStatus.success) {
                      final forumDetail = state.forumDetail;
                      return ForumBox(
                        authorName: forumDetail?.user?.fullName ??
                            'user name not found',
                        forumTitle: forumDetail?.text ?? 'forum text not found',
                        likeCount: forumDetail?.likes ?? 0,
                        viewCount: forumDetail?.viewCount.toString() ?? '',
                        commentCount: '30',
                        forumId: 0,
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: ForumCommentsCustomScroll(),
            ),

            BlocBuilder<ForumCommentsCubit, ForumCommentsState>(
              buildWhen: (previous, current) {
                return current.forumCommentStatus != ForumCommentStatus.initial;
              },
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 175) +
                        EdgeInsets.only(top: 10),
                    child: Visibility(
                      visible: state.forumCommentStatus ==
                          ForumCommentStatus.loading,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
              },
            ),
            // BlocSelector<ForumCommentsCubit, ForumCommentsState,
            //     ForumCommentStatus>(
            //   selector: (ForumCommentsState state) {
            //     return state.forumCommentStatus;
            //   },
            //   builder: (context, forumCommentStatus) {
            //     return SliverToBoxAdapter(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 175) +
            //             EdgeInsets.only(top: 10),
            //         child: Visibility(
            //           visible: forumCommentStatus == ForumCommentStatus.loading,
            //           child: CircularProgressIndicator.adaptive(),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            SliverToBoxAdapter(
              child: SizedBox(height: 105),
            ),
          ],
        ),
      ),
      bottomSheet: BlocBuilder<ForumDetailCubit, ForumDetailState>(
        buildWhen: (previous, current) {
          return current.forumDetailStatus == ForumDetailStatus.success;
        },
        builder: (context, state) {
          if (state.forumDetailStatus == ForumDetailStatus.success) {
            return CommentInput(
              forumId: widget.forumId,
              scrollController: scrollController,
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
