import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../data/models/remote/response/blog_category_model.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../utils/helper/get_blog_img_helper.dart';
import '../../../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../../../widgets/global_appbar.dart';
import '../../widgets/article_box.dart';

class SeeAllArticlesPage extends StatelessWidget {
  const SeeAllArticlesPage({super.key, required this.category});

  final BlogCategoryModel category; //

  @override
  Widget build(BuildContext context) {
    final blogs = category.blogs ?? [];

    return Scaffold(
      appBar: GlobalAppbar(
        title: category.categoryName ?? 'Blog',
        onLeadingTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              22.h,
              ...blogs.map((blog) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ArticleBox(
                      onTap: () =>
                          context.push('/article_details', extra: blog),
                      videoOrImage: CachedNetworkImage(
                        imageUrl: getBlogImageHelper(blog),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CustomCircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: CustomCircularProgressIndicator()),
                      ),
                      boxTitle: blog.name ?? '',
                      boxDescription: blog.text ?? '',
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
