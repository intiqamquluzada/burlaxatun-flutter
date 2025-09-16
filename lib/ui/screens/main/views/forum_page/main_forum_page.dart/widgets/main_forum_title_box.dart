import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/forum_category_stats/forum_category_stats_cubit.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class MainForumTitleBox extends StatefulWidget {
  const MainForumTitleBox({
    super.key,
    required this.title,
    this.onTap,
    required this.categoryIndex,
  });

  final String title;
  final int categoryIndex;
  final void Function()? onTap;

  @override
  State<MainForumTitleBox> createState() => _MainForumTitleBoxState();
}

class _MainForumTitleBoxState extends State<MainForumTitleBox> {
  late ForumCategoryStatsCubit forumCategoryStatsCubit;
  @override
  void initState() {
    // log('init statistics');
    // forumCategoryStatsCubit = context.read<ForumCategoryStatsCubit>()
    //   ..getCategoryStatistics();
    // forumCategoryStatsCubit.getCategoryStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.deviceWidth * 0.58,
                    child: GlobalText(
                      textAlign: TextAlign.left,
                      text: widget.title,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  25.h,
                  BlocBuilder<ForumCategoryStatsCubit, ForumCategoryStatsState>(
                    builder: (context, state) {
                      if (state.categoryStatsStatus ==
                          CategoryStatsStatus.loading) {
                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                width: 40,
                                height: 20,
                                color: Colors.black12,
                              ),
                            ),
                            SizedBox(width: 30),
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                width: 40,
                                height: 20,
                                color: Colors.black12,
                              ),
                            ),
                          ],
                        );
                      } else if (state.categoryStatsStatus ==
                          CategoryStatsStatus.error) {
                        return Text('melumat tapilmadi');
                      }
                      if (state.categoryStatsStatus ==
                          CategoryStatsStatus.success) {
                        final stats =
                            state.categoryStatsList?[widget.categoryIndex];
                        final totalViews = stats?.totalViews == null
                            ? 'baxış sayı tapılmadı'
                            : '${stats!.totalViews} baxış';
                        final forumCount = stats?.forumCount == null
                            ? 'forum sayı tapılmadı'
                            : '${stats!.forumCount} mövzu';
                        return Row(
                          children: [
                            GlobalText(
                              textAlign: TextAlign.left,
                              text: forumCount,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            SizedBox(width: 14),
                            GlobalText(
                              textAlign: TextAlign.left,
                              text: totalViews,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Image.asset(
                'assets/png/main_forum_png.png',
                width: 92,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
