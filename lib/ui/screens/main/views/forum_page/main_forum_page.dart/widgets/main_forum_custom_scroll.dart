import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/forum_category/forum_category_cubit.dart';
import '../../../../../../../cubits/forum_category_stats/forum_category_stats_cubit.dart';
import '../../../../../../../utils/di/locator.dart';
import '../../../home_page/blog/initial_blog/widgets/blog_banner.dart';
import 'main_forum_title_box.dart';

class MainForumCustomScroll extends StatelessWidget {
  const MainForumCustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumCategoryCubit, ForumCategoryState>(
      builder: (_, state) {
        if (state is ForumCategoryLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ForumCategoryError) {
          log("Forum Category UI error: ${state.message}");
          return Center(child: Text("Xəta"));
        }
        if (state is ForumCategoryNetworkError) {
          log("Forum Category UI network error: ${state.message}");
          return Center(child: Text("Şəbəkə xətası"));
        }
        if (state is ForumCategorySuccess) {
          final data = state.response;
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<ForumCategoryCubit>().getForumCategory();
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 24),
                  sliver: SliverToBoxAdapter(
                    child: BlogBanner(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: data.length,
                    (_, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24) +
                            EdgeInsets.symmetric(horizontal: 15),
                        child: BlocProvider(
                          create: (context) =>
                              locator<ForumCategoryStatsCubit>()
                                ..getCategoryStatistics(),
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
