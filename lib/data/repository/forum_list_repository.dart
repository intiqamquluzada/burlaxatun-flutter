import 'package:dio/dio.dart';

import '../contractor/forum_list_contractor.dart';
import '../services/remote/forum_list_service.dart';

class ForumListRepository implements ForumListContractor {
  ForumListRepository(this._forumListService);

  final ForumListService _forumListService;
  @override
  Future<Response<dynamic>> getForumList({int? page}) {
    return _forumListService.getForumList(page: page);
  }
}
