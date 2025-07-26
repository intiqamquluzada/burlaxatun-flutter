import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/extensions/statuscode_extension.dart';
import '../../models/remote/response/forum_category_model.dart';
import 'base_network_service.dart';

class ForumCategoryService {
  Future<List<ForumCategory>> getForumCategory() async {
    final endpoint = EndpointsConstants.forumCategory;

    final response = await BaseNetwork.instance.getDio().get(endpoint);

    if (response.statusCode.isSuccess) {
      final data = ForumCategoryModel.fromJson(response.data);
      return data.results ?? [];
    } else if (response.statusCode.isFailure) {
      throw Exception("Failed to load forum category");
    }
    throw Exception("Unable to get forum category data");
  }
}
