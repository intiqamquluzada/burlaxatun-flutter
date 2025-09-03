import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/blog_sliders/blog_sliders_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import '../article_details/all_articles.dart';
import 'widgets/blog_banner.dart';
import 'widgets/search_input.dart';

class InitialBlogPage extends StatefulWidget {
  const InitialBlogPage({super.key});

  @override
  State<InitialBlogPage> createState() => _InitialBlogPageState();
}

class _InitialBlogPageState extends State<InitialBlogPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Blog',
        onLeadingTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchInput(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            24.h,
            BlocBuilder<BlogSlidersCubit, BlogSlidersState>(
              builder: (context, state) {
                return const BlogBanner();
              },
            ),
            24.h,
            AllArticles(searchQuery: searchQuery),
          ],
        ),
      ),
    );
  }
}
