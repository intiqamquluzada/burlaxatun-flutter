// import 'package:burla_xatun/data/models/remote/response/forum_category_response.dart';
// import 'package:burla_xatun/data/services/remote/base_network_service.dart';
// import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
// import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';

// class ForumCategoryService {
//   Future<List<ForumCategoryResponse>> getForumCategory() async {
//     final endpoint = EndpointsConstants.forumCategory;

//     final response = await BaseNetwork.instance.getDio().get(endpoint);

//     if (response.statusCode.isSuccess) {
//       List<dynamic> data = response.data;
//       return data.map((cat) => ForumCategoryResponse.fromJson(cat)).toList();
//     } else if (response.statusCode.isFailure) {
//       throw Exception("Failed to load forum category");
//     }
//     throw Exception("Unable to get forum category data");
//   }
// }
