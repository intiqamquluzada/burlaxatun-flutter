import 'package:dio/src/response.dart';

import '../contractor/forum_category_stats_contract.dart';
import '../services/remote/forum_category_stats_service.dart';

class ForumCategoryStatsRepo implements ForumCategoryStatsContract {
  ForumCategoryStatsRepo(this._forumCategoryService);

  final ForumCategoryStatsService _forumCategoryService;

  @override
  Future<Response<dynamic>> getCategoryStats({String? url}) {
    return _forumCategoryService.getCategoryStats(url: url);
  }
}
