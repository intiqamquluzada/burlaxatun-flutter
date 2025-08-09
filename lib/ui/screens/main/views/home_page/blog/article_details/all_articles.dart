import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/blog_cat/blog_cat_cubit.dart';
import '../initial_blog/widgets/articles_widget.dart';

class AllArticles extends StatelessWidget {
  final String searchQuery;

  const AllArticles({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCatCubit, BlogCatState>(
      builder: (_, state) {
        if (state.status == BlogCatStatus.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state.status == BlogCatStatus.failure) {
          return Center(child: Text(state.errorMessage ?? 'Xəta baş verdi'));
        } else if (state.status == BlogCatStatus.networkError) {
          return Center(child: Text(state.errorMessage ?? 'Şəbəkəni yoxlayın'));
        } else if (state.status == BlogCatStatus.success) {
          final categoryList = state.categoryList ?? [];

          final filtered = categoryList.where((result) {
            final name = result.categoryName?.toLowerCase() ?? '';
            return name.contains(searchQuery.toLowerCase());
          }).toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (_, index) {
              final category = filtered[index];
              return ArticlesWidget(
                title: category.categoryName ?? 'Cateqoriya tapılmadı',
                itemCount: category.blogs?.length ?? 0,
                blogs: category.blogs ?? [],
                category: category,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
