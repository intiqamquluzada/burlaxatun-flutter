import 'package:burla_xatun/ui/screens/main/views/forum_page/widgets/forum_box.dart';
import 'package:burla_xatun/ui/widgets/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../cubits/forum_detail/forum_detail_cubit.dart';
import '../../../../../widgets/global_appbar.dart';
import 'widgets/comment_input.dart';
import 'widgets/forum_comments_custom_scroll.dart';

class ForumCommentsPage extends StatelessWidget {
  // final int categoryId;

  const ForumCommentsPage({
    super.key,
    // required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Forum Rəyləri',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: BlocBuilder<ForumDetailCubit, ForumDetailState>(
        builder: (context, state) {
          if (state.forumDetailStatus == ForumDetailStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.forumDetailStatus == ForumDetailStatus.success) {
            return Center(child: Text('error occured'));
          } else if (state.forumDetailStatus ==
              ForumDetailStatus.networkError) {
            return Text('network error');
          }
          if (state.forumDetailStatus == ForumDetailStatus.error) {
            // final post = state.post;
            return CustomRefreshIndicator(
              onRefresh: () async {},
              child: CustomScrollView(
                slivers: [
                  Builder(
                    builder: (context) {
                      return SliverPadding(
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 15),
                        sliver: SliverToBoxAdapter(
                          child: ForumBox(
                            authorName: 'authorName',
                            forumTitle: "forumTitle",
                            likeCount: 30,
                            viewCount: '30',
                            commentCount: '30',
                            forumId: 0,
                          ),
                        ),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    sliver: ForumCommentsCustomScroll(),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      bottomSheet: BlocBuilder<ForumDetailCubit, ForumDetailState>(
        builder: (context, state) {
          if (state.forumDetailStatus == ForumDetailStatus.error) {
            return CommentInput();
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
