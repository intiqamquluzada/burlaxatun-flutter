import 'dart:io';

import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../../../utils/extensions/statuscode_extension.dart';
import '../../models/remote/response/user_update_model.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class UserUpdateService {
  Future<UserUpdateResponse?> updateUser({
    String? phoneNumber,
    bool? onboardingDone,
    bool? wantToBePregnant,
    bool? wantToSeePeriod,
    bool? isPregnant,
    String? pregnantWeek,
    bool? firstChild,
    File? image,
    String? activeLanguage,
    bool? enableNotifications,
  }) async {
    final token = locator<LoginTokenService>().token;
    final endpoint = EndpointsConstants.userUpdate;

    final formData = FormData.fromMap({
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (onboardingDone != null) "onboarding_done": onboardingDone,
      if (wantToBePregnant != null) "want_to_be_pregnant": wantToBePregnant,
      if (wantToSeePeriod != null) "want_to_see_period": wantToSeePeriod,
      if (isPregnant != null) "is_pregnant": isPregnant,
      if (pregnantWeek != null || pregnantWeek != '0')
        "pregnant_week": pregnantWeek,
      if (firstChild != null) "first_child": firstChild,
      if (activeLanguage != null) "active_language": activeLanguage,
      if (enableNotifications != null)
        "enable_notifications": enableNotifications,
      if (image != null)
        "image": await MultipartFile.fromFile(image.path,
            filename: image.path.split("/").last),
    });
    // final requestBody = {};
    // if (phoneNumber != null) requestBody["phone_number"] = phoneNumber;
    // if (onboardingDone != null) requestBody["onboarding_done"] = onboardingDone;
    // if (wantToBePregnant != null) {
    //   requestBody["want_to_be_pregnant"] = wantToBePregnant;
    // }
    // if (wantToSeePeriod != null) {
    //   requestBody["want_to_see_period"] = wantToSeePeriod;
    // }
    // if (isPregnant != null) requestBody["is_pregnant"] = isPregnant;
    // if (pregnantWeek != null) requestBody["pregnant_week"] = pregnantWeek;
    // if (firstChild != null) requestBody["first_child"] = firstChild;
    // if (activeLanguage != null) requestBody["active_language"] = activeLanguage;
    // if (enableNotifications != null) {
    //   requestBody["enable_notifications"] = enableNotifications;
    // }
    // if (image != null) requestBody["image"] = image;

    final response = await BaseNetwork.instance.getDio(token: token).patch(
          endpoint,
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
        );

    if (response.statusCode.isSuccess) {
      return UserUpdateResponse.fromJson(response.data);
    }
    if (response.statusCode.isFailure) {
      throw Exception("Failed to update user: User Update Service");
    }
    throw Exception("Unhandled error is occurred in User Update Service");
  }

  Future<bool> userProfileDelete() async {
    final token = locator<LoginTokenService>().token;
    final endpoint = EndpointsConstants.userProfileDelete;

    final response = await BaseNetwork.instance.getDio(token: token).delete(
          endpoint,
        );

    if (response.statusCode.isSuccess) {
      return true;
    }
    if (response.statusCode.isFailure) {
      throw Exception("Failed to delete user profile: User Update Service");
    }
    throw Exception("Unhandled error is occurred in User Update Service");
  }
}
