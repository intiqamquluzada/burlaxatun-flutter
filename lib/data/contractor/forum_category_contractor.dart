import 'package:burla_xatun/data/models/remote/response/forum_category_model.dart';

abstract class ForumCategoryContractor {
  Future<List<ForumCategory>> getForumCategory();
}
