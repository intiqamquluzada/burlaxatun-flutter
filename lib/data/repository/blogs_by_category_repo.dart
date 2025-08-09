import 'package:dio/src/response.dart';

import '../contractor/blogs_by_category_contract.dart';
import '../services/remote/blogs_by_category_service.dart';

class BlogsByCategoryRepo implements BlogsByCategoryContract {
  BlogsByCategoryRepo(this.blogsByCategoryService);

  final BlogsByCategoryService blogsByCategoryService;

  @override
  Future<Response> getBlogsByCategory({required int categoryId, String? url}) {
    return blogsByCategoryService.getBlogsByCategory(
      categoryId: categoryId,
      url: url,
    );
  }
}
