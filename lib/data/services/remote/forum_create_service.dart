// import 'dart:developer';

// import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';

// import '../../../utils/constants/endpoints_constants.dart';
// import 'base_network_service.dart';

// class ForumCreateService {
//   final endpoint = EndpointsConstants.forumCreate;

//   Future<bool> createForum({
//     required int category,
//     required String text,
//   }) async {
//     final requestBody = {
//       "category": category,
//       "text": text,
//     };

//     log('Forum create request body: $requestBody');

//     final response = await BaseNetwork.instance.post(
//       path: endpoint,
//       postData: requestBody,
//     );

//     log('Medicine create response: ${response.data}');

//     return response.statusCode.isSuccess;
//   }
// }
