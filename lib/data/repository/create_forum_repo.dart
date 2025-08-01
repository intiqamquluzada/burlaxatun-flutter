import 'package:burla_xatun/data/contractor/create_forum_contract.dart';
import 'package:burla_xatun/data/services/remote/create_forum_service.dart';
import 'package:dio/src/response.dart';

class CreateForumRepo implements CreateForumContract {
  CreateForumRepo(this.createForumService);

  final CreateForumService createForumService;

  @override
  Future<Response> createForum({
    required int categoryId,
    required String text,
  }) {
    return createForumService.createForum(
      categoryId: categoryId,
      text: text,
    );
  }
}
