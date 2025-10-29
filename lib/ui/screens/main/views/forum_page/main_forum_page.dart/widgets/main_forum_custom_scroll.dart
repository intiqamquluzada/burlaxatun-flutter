import 'dart:developer';

import 'package:burla_xatun/data/models/remote/response/forum_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/forum_category/forum_category_cubit.dart';
import '../../../../../../../cubits/forum_category_stats/forum_category_stats_cubit.dart';
import '../../../../../../widgets/custom_refresh_indicator.dart';
import '../../../home_page/blog/initial_blog/widgets/blog_banner.dart';
import 'main_forum_title_box.dart';

class MainForumCustomScroll extends StatefulWidget {
  const MainForumCustomScroll({super.key});

  @override
  State<MainForumCustomScroll> createState() => _MainForumCustomScrollState();
}

class _MainForumCustomScrollState extends State<MainForumCustomScroll> {
  late ForumCategoryStatsCubit _forumCategoryStatsCubit;
  late ForumCategoryCubit _forumCategoryCubit;
  late ScrollController scrollController;
  @override
  void initState() {
    _forumCategoryCubit = context.read<ForumCategoryCubit>();
    _forumCategoryStatsCubit = context.read<ForumCategoryStatsCubit>();
    // ..getCategoryStatistics();
    scrollController = ScrollController();
    _loadMore();
    super.initState();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await _forumCategoryCubit.getForumCategory();
        // log('end of the page');
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
    return BlocConsumer<ForumCategoryCubit, ForumCategoryState>(
      buildWhen: (previous, current) {
        return previous.categoryList == null;
      },
      listenWhen: (previous, current) {
        return previous.forumCategoryStatus != current.forumCategoryStatus;
      },
      listener: (context, state) {
        if (state.forumCategoryStatus == ForumCategoryStatus.success) {
          _forumCategoryStatsCubit.getCategoryStatistics();
        }
      },
      builder: (_, state) {
        log('Builded category');
        if (state.forumCategoryStatus == ForumCategoryStatus.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.forumCategoryStatus == ForumCategoryStatus.error) {
          // log("Forum Category UI error: ${state.message}");
          return Center(child: Text("Xəta"));
        } else if (state.forumCategoryStatus == ForumCategoryStatus.error) {
          // log("Forum Category UI network error: ${state.message}");
          return Center(child: Text("Şəbəkə xətası"));
        } else if (state.forumCategoryStatus == ForumCategoryStatus.success) {
          return CustomRefreshIndicator(
            onRefresh: () async {
              await _forumCategoryCubit.getForumCategory();
              await _forumCategoryStatsCubit.getCategoryStatistics();
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 24),
                  sliver: SliverToBoxAdapter(
                    child: BlogBanner(),
                  ),
                ),
                BlocSelector<ForumCategoryCubit, ForumCategoryState,
                    List<ForumCategory>>(
                  selector: (state) {
                    return state.categoryList ?? [];
                  },
                  builder: (context, categoryList) {
                    final data = categoryList;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: data.length,
                        (_, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24) +
                                EdgeInsets.symmetric(horizontal: 15),
                            child: MainForumTitleBox(
                              title: data[i].name ?? 'Məlumat tapılmadı',
                              onTap: () => context.push(
                                '/secondary_forum',
                                extra: {
                                  'category_id': data[i].id,
                                  'category_name': data[i].name,
                                },
                              ),
                              categoryIndex: i,
                              categoryId: data[i].id ?? 0,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                // BlocSelector<ForumCategoryCubit, ForumCategoryState,
                //     ForumCategoryStatus>(
                //   selector: (state) {
                //     return state.forumCategoryStatus;
                //   },
                //   builder: (context, state) {
                //     return SliverToBoxAdapter(
                //       child: Visibility(
                //         visible: state == ForumCategoryStatus.loading,
                //         child: SizedBox(
                //           width: 100,
                //           height: 50,
                //           child: CircularProgressIndicator(),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
    // BlocBuilder<ForumCategoryCubit, ForumCategoryState>(
    //   buildWhen: (previous, current) {
    //     return previous.forumCategoryStatus != current.forumCategoryStatus;
    //   },
    //   builder: (_, state) {
    //     log('Builded category');
    //     if (state.forumCategoryStatus == ForumCategoryStatus.loading) {
    //       return Center(
    //         child: CircularProgressIndicator.adaptive(),
    //       );
    //     } else if (state.forumCategoryStatus == ForumCategoryStatus.error) {
    //       // log("Forum Category UI error: ${state.message}");
    //       return Center(child: Text("Xəta"));
    //     } else if (state.forumCategoryStatus == ForumCategoryStatus.error) {
    //       // log("Forum Category UI network error: ${state.message}");
    //       return Center(child: Text("Şəbəkə xətası"));
    //     } else if (state.forumCategoryStatus == ForumCategoryStatus.success) {
    //       final data = state.categoryList ?? [];
    //       return CustomRefreshIndicator(
    //         onRefresh: () async {
    //           await _forumCategoryCubit.getForumCategory();
    //           await _forumCategoryStatsCubit.getCategoryStatistics();
    //         },
    //         child: CustomScrollView(
    //           slivers: [
    //             SliverPadding(
    //               padding: EdgeInsets.only(bottom: 24),
    //               sliver: SliverToBoxAdapter(
    //                 child: BlogBanner(),
    //               ),
    //             ),
    //             SliverList(
    //               delegate: SliverChildBuilderDelegate(
    //                 childCount: data.length,
    //                 (_, i) {
    //                   return Padding(
    //                     padding: const EdgeInsets.only(bottom: 24) +
    //                         EdgeInsets.symmetric(horizontal: 15),
    //                     child: MainForumTitleBox(
    //                       title: data[i].name ?? 'Məlumat tapılmadı',
    //                       onTap: () => context.push(
    //                         '/secondary_forum',
    //                         extra: {
    //                           'category_id': data[i].id,
    //                           'category_name': data[i].name,
    //                         },
    //                       ),
    //                       categoryIndex: i,
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //             // BlocSelector<ForumCategoryCubit, ForumCategoryState,
    //             //     ForumCategoryStatus>(
    //             //   selector: (state) {
    //             //     return state.forumCategoryStatus;
    //             //   },
    //             //   builder: (context, state) {
    //             //     return SliverToBoxAdapter(
    //             //       child: Visibility(
    //             //         visible: state == ForumCategoryStatus.loading,
    //             //         child: SizedBox(
    //             //           width: 100,
    //             //           height: 50,
    //             //           child: CircularProgressIndicator(),
    //             //         ),
    //             //       ),
    //             //     );
    //             //   },
    //             // ),
    //           ],
    //         ),
    //       );
    //     }
    //     return SizedBox.shrink();
    //   },
    // );
  }
}
