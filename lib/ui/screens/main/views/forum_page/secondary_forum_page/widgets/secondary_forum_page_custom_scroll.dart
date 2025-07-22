import 'dart:developer';

import 'package:burla_xatun/cubits/forum_detail/forum_detail_cubit.dart';
import 'package:burla_xatun/ui/screens/main/views/profil_page/initial_profile/widgets/delete_profile_button.dart';
import 'package:burla_xatun/ui/widgets/global_button.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/forum_list/forum_list_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_list_model.dart';
import '../../../../../../widgets/custom_refresh_indicator.dart';
import '../../forum_comments/forum_comments_page.dart';
import '../../widgets/forum_box.dart';
import 'add_new_forum_button.dart';
import 'secondary_forum_search_input.dart';

class SecondaryForumPageCustomScroll extends StatefulWidget {
  const SecondaryForumPageCustomScroll({super.key});

  @override
  State<SecondaryForumPageCustomScroll> createState() =>
      _SecondaryForumPageCustomScrollState();
}

class _SecondaryForumPageCustomScrollState
    extends State<SecondaryForumPageCustomScroll> {
  late ForumListCubit forumListCubit;
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    forumListCubit = context.read<ForumListCubit>();

    _loadMore();
    super.initState();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await forumListCubit.getForumList();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumListCubit, ForumListState>(
      buildWhen: (previous, current) {
        return previous.forumList == null;
        // previous.forumList != current.forumList
        // &&
        // previous.forumListStatus != current.forumListStatus;
      },
      builder: (context, state) {
        if (state.forumListStatus == ForumListStatus.loading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state.forumListStatus == ForumListStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                Text(
                  'Xəta baş verdi',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GlobalButton(
                    onPressed: () async {
                      await forumListCubit.getForumList(isRefresh: true);
                    },
                    buttonName: 'Yenidən cəhd et',
                    buttonColor: ColorConstants.primaryRedColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }
        if (state.forumListStatus == ForumListStatus.success) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomRefreshIndicator(
                onRefresh: () async {
                  await forumListCubit.getForumList(isRefresh: true);
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // SliverPadding(
                    //   padding: const EdgeInsets.only(top: 22, bottom: 18),
                    //   sliver: SliverToBoxAdapter(
                    //     child: ForumTitle(
                    //       title: 'deidoejio',
                    //     ),
                    //   ),
                    // ),
                    // SliverPadding(
                    //   padding: const EdgeInsets.only(bottom: 18),
                    //   sliver: SliverToBoxAdapter(
                    //     child: SecondaryForumSearchInput(),
                    //   ),
                    // ),
                    BlocSelector<ForumListCubit, ForumListState, List<Thread>>(
                      selector: (state) {
                        return state.forumList ?? [];
                      },
                      builder: (context, forumList) {
                        log('${forumList.length}');
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: forumList.length,
                            (_, i) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: ForumBox(
                                  forumId: 20,
                                  authorName:
                                      forumList[i].author ?? 'data not found',
                                  forumTitle:
                                      forumList[i].subject ?? 'data not found',
                                  likeCount: 23,
                                  viewCount: forumList[i]?.views.toString() ??
                                      'data not found',
                                  commentCount:
                                      forumList?[i].replies.toString() ??
                                          'data not found',
                                  onTap: () {
                                    final postId = forumList[i].post?.id ?? 0;
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider(
                                          create: (context) =>
                                              locator<ForumDetailCubit>()
                                                ..getForumDetail(postId),
                                          child: ForumCommentsPage(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    BlocSelector<ForumListCubit, ForumListState,
                        ForumListStatus>(
                      selector: (state) {
                        return state.forumListStatus!;
                      },
                      builder: (context, status) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Visibility(
                              visible: status == ForumListStatus.loading,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 160),
                                child: SizedBox(
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 24,
                child: AddNewForumButton(),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
