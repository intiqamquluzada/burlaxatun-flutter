import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../cubits/forum_detail/forum_detail_cubit.dart';
import '../../../../../widgets/custom_refresh_indicator.dart';
import '../../../../../widgets/global_appbar.dart';

class ForumCommentsPage extends StatelessWidget {
  // final int forumId;

  const ForumCommentsPage({
    super.key,
    // required this.forumId,
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
          } else if (state.forumDetailStatus == ForumDetailStatus.error) {
            return Center(child: Text('error occured'));
          } else if (state.forumDetailStatus ==
              ForumDetailStatus.networkError) {
            return Text('network error');
          }
          if (state.forumDetailStatus == ForumDetailStatus.success) {
            // final post = state.post;
            return CustomRefreshIndicator(
              onRefresh: () async {},
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ejijf',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'author:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'data noeededde found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                  // ForumCommentsCustomScroll(),
                  ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      // bottomSheet: CommentInput(),
    );
  }
}
