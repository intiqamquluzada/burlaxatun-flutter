import 'package:dio/dio.dart';

import '../contractor/forum_category_contractor.dart';
import '../services/remote/forum_category_service.dart';

class ForumCategoryRepository implements ForumCategoryContractor {
  ForumCategoryRepository(this._categoryService);

  final ForumCategoryService _categoryService;

  @override
  Future<Response> getForumCategory({String? url}) {
    return _categoryService.getForumCategory(url: url);
  }
}
