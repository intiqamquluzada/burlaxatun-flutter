import 'dart:developer';

import 'package:burla_xatun/data/models/remote/response/blogs_by_category_model.dart';
import 'package:burla_xatun/ui/widgets/custom_refresh_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/blogs_by_category/blogs_by_category_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import '../../widgets/article_box.dart';

class SeeAllArticlesPage extends StatefulWidget {
  const SeeAllArticlesPage({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  final String categoryName;
  final int categoryId;

  @override
  State<SeeAllArticlesPage> createState() => _SeeAllArticlesPageState();
}

class _SeeAllArticlesPageState extends State<SeeAllArticlesPage> {
  late ScrollController scrollController;
  late BlogsByCategoryCubit blogsByCategoryCubit;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    blogsByCategoryCubit = context.read<BlogsByCategoryCubit>();
    _loadMore();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log('reach end of scroll');

        await blogsByCategoryCubit.getBlogsByCategory(
          categoryId: widget.categoryId,
        );
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
    return Scaffold(
      appBar: GlobalAppbar(
        title: widget.categoryName,
        onLeadingTap: () => context.pop(),
      ),
      body: Center(
        child: BlocBuilder<BlogsByCategoryCubit, BlogsByCategoryState>(
          buildWhen: (previous, current) {
            return previous.blogsByCategory == null ||
                previous.blogsByCategory!.isEmpty;
          },
          builder: (context, state) {
            if (state.status == BlogsByCategoryStatus.loading) {
              return CircularProgressIndicator.adaptive();
            } else if (state.status == BlogsByCategoryStatus.error) {
              return Center(
                child: Text('Cateqoriyaya uyğun bloglar tapılamdı'),
              );
            } else if (state.status == BlogsByCategoryStatus.success) {
              return CustomRefreshIndicator(
                onRefresh: () async {
                  await blogsByCategoryCubit.getBlogsByCategory(
                    categoryId: widget.categoryId,
                    isRefresh: true,
                  );
                },
                child: BlocSelector<BlogsByCategoryCubit, BlogsByCategoryState,
                    List<BlogByCategory>>(
                  selector: (state) {
                    return state.blogsByCategory ?? [];
                  },
                  builder: (BuildContext context, List<BlogByCategory> blogs) {
                    // final blogs = blogList;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            itemCount: blogs.length,
                            itemBuilder: (context, i) {
                              final blog = blogs[i];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    ArticleBox(
                                      onTap: () {
                                        context.push(
                                          '/article_details',
                                          extra: blog,
                                        );
                                      },
                                      videoOrImage: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        child: SizedBox(
                                          height: 158,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CachedNetworkImage(
                                            imageUrl: blog.file ?? '',
                                            fit: BoxFit.fitWidth,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                              child: Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                      boxTitle: blog.name ?? '',
                                      boxDescription: blog.text ?? '',
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return 24.h;
                            },
                          ),
                        ),
                        BlocSelector<BlogsByCategoryCubit, BlogsByCategoryState,
                            BlogsByCategoryStatus>(
                          selector: (state) {
                            return state.status;
                          },
                          builder: (_, status) {
                            return status == BlogsByCategoryStatus.loading
                                ? CircularProgressIndicator.adaptive()
                                : SizedBox.shrink();
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
