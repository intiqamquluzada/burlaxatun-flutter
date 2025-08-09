import 'package:dio/dio.dart';

import '../contractor/blog_cat_contractor.dart';
import '../services/remote/blog_cat_service.dart';

class BlogCatRepository implements BlogCatContractor {
  BlogCatRepository(this._blogCatService);

  final BlogCatService _blogCatService;

  @override
  Future<Response<dynamic>> getBlogCat() {
    return _blogCatService.getBlogCat();
  }
}
