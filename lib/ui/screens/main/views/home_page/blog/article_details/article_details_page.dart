import 'package:flutter/material.dart';

import 'widgets/article_detail.dart';
import 'widgets/article_details_appbar.dart';

class ArticleDetailsPage extends StatefulWidget {
  const ArticleDetailsPage({
    super.key,
    required this.blog,
  });

  final dynamic blog;

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ArticleDetailsAppbar(
          imagePath: widget.blog.file ?? '',
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: ArticleDetail(
                  title: widget.blog.name ?? '',
                  text: widget.blog.text ?? '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
