import 'dart:developer';

import 'package:burla_xatun/cubits/create_comment/create_comment_cubit.dart';
import 'package:burla_xatun/cubits/delete_comment/delete_comment_cubit.dart';
import 'package:burla_xatun/cubits/edit_comment/edit_comment_cubit.dart';
import 'package:burla_xatun/cubits/forum_comments/forum_comments_cubit.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/forum_detail/forum_detail_cubit.dart';
import '../../../../../../../cubits/forum_list/forum_list_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_list_model.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../utils/di/locator.dart';
import '../../../../../../widgets/custom_refresh_indicator.dart';
import '../../../../../../widgets/global_button.dart';
import '../../forum_comments/forum_comments_page.dart';
import '../../widgets/forum_box.dart';
import 'add_new_forum_button.dart';
import 'forum_title.dart';

class SecondaryForumPageCustomScroll extends StatefulWidget {
  const SecondaryForumPageCustomScroll({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final int categoryId;
  final String categoryName;

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
        await forumListCubit.getForumList(categoryid: widget.categoryId);
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
                      await forumListCubit.getForumList(
                        isRefresh: true,
                        categoryid: widget.categoryId,
                      );
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
          // final categoryName = state.forumList?.first.category?.name ??
          //     'Category name not found';
          log('${state.forumList?.isEmpty}');

          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomRefreshIndicator(
                onRefresh: () async {
                  await forumListCubit.getForumList(
                    isRefresh: true,
                    categoryid: widget.categoryId,
                  );
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 22, bottom: 18),
                      sliver: SliverToBoxAdapter(
                        child: ForumTitle(
                          title: widget.categoryName,
                        ),
                      ),
                    ),
                    BlocSelector<ForumListCubit, ForumListState, List<Forum>>(
                      selector: (state) {
                        return state.forumList!;
                      },
                      builder: (context, forumList) {
                        return forumList.isEmpty
                            ? SliverToBoxAdapter(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: GlobalText(text: 'İlk forumu yarat'),
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount: forumList.length,
                                  (_, i) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 18),
                                      child: ForumBox(
                                        forumId: forumList[i].id ?? -1,
                                        authorName:
                                            forumList[i].user?.fullName ??
                                                'data not found',
                                        forumTitle: forumList[i].text ??
                                            'data not found',
                                        likeCount: 23,
                                        viewCount:
                                            forumList[i].viewCount.toString(),
                                        commentCount: '10',
                                        onTap: () {
                                          final forumSlug =
                                              forumList[i].slug ?? '';
                                          final forumId = forumList[i].id ?? -1;

                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (_) => MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        locator<
                                                            ForumDetailCubit>()
                                                          ..getForumDetail(
                                                              forumSlug),
                                                  ),
                                                  BlocProvider(
                                                    create: (context) => locator<
                                                        ForumCommentsCubit>()
                                                      ..getForumComments(
                                                        forumId: forumId,
                                                      ),
                                                  ),
                                                  BlocProvider(
                                                    create: (context) => locator<
                                                        CreateCommentCubit>(),
                                                  ),
                                                  BlocProvider(
                                                    create: (context) => locator<
                                                        DeleteCommentCubit>(),
                                                  ),
                                                  BlocProvider(
                                                    create: (context) =>
                                                        locator<
                                                            EditCommentCubit>(),
                                                  ),
                                                ],
                                                child: ForumCommentsPage(
                                                  forumId: forumId,
                                                ),
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
                child: AddNewForumButton(categoryId: widget.categoryId),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
