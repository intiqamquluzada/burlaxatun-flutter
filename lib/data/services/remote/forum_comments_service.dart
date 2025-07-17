// import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';

// import '../../../utils/constants/endpoints_constants.dart';
// import '../../../utils/di/locator.dart';
// import '../../models/remote/response/forum_comments_model.dart';
// import '../local/login_token_service.dart';
// import 'base_network_service.dart';

// class ForumCommentsService {
//   final endpoint = EndpointsConstants.forumComments;

//   Future<ForumCommentsResponse> getForumComments() async {
//     final token = locator<LoginTokenService>().token;
//     if (token == null) {
//       throw Exception("Token is null. Please login first.");
//     }

//     final response =
//         await BaseNetwork.instance.getDio(token: token).get(endpoint);

//     if (response.statusCode.isSuccess) {
//       return ForumCommentsResponse.fromJson(response.data);
//     } else {
//       throw Exception('Failed to load Forum Comments from service');
//     }
//   }
// }
