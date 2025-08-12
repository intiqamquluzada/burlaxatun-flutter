import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class BabyNamesService {
  Future<Response<dynamic>> getCountries() async {
    final url = EndpointsConstants.extraCountries;

    final response = await BaseNetwork.instance.getDio().get(url);

    if (response.statusCode == 200) {
      return response;
    }
    throw Exception('Something has happened while fetching countries data');
  }

  Future<Response<dynamic>> getNames({
    required String countryId,
    required String gender,
    String? url,
  }) async {
    url ??= EndpointsConstants.babyNames;
    final queryParams = {
      'country': countryId,
      'gender': gender,
    };

    final response = await BaseNetwork.instance
        .getDio()
        .get(url, queryParameters: queryParams);

    if (response.statusCode == 200) {
      return response;
    }
    throw Exception('Something has happened while fetching names data');
  }

  Future<Response<dynamic>> getWishListNames() async {
    final url = EndpointsConstants.wishListNames;

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance.getDio(token: token).get(url);

    if (response.statusCode == 200) {
      return response;
    }
    throw Exception('Something has happened while fetching wish list names');
  }

  Future<Response<dynamic>> removeFromWishList({
    required int babyNameId,
  }) async {
    final url = EndpointsConstants.removeFromWishList;
    final token = locator<LoginTokenService>().token;

    final postData = {
      "baby_name_id": babyNameId,
    };

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }

  Future<Response<dynamic>> addToWishList({
    required int babyNameId,
  }) async {
    final url = EndpointsConstants.addToWishList;
    final token = locator<LoginTokenService>().token;

    final postData = {
      "baby_name_id": babyNameId,
    };

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }

  // Future<NamesData> getGenderNames(String countryId) async {
  //   final token = await TokenHiveService.instance.getToken();
  //   final url = EndpointsConstants.names;
  //   final body = {
  //     "id": countryId,
  //     "limit": 10,
  //     "start": 0,
  //   };

  //   final response =
  //       await BaseNetwork.instance.getDio(token: token).post(url, data: body);

  //   if (response.statusCode == 200) {
  //     final namesData = NamesModel.fromJson(response.data);
  //     return namesData.data;
  //   }
  //   throw Exception('Something has happened while fetching names');
  // }

  // Future<List<SelectedNameData>> getSelectedNames() async {
  //   final token = await TokenHiveService.instance.getToken();
  //   final url = EndpointsConstants.selectedNames;

  //   final response = await BaseNetwork.instance.getDio(token: token).get(url);

  //   if (response.statusCode == 200) {
  //     final selectedNames = SelectedNamesModel.fromJson(response.data).data;
  //     return selectedNames;
  //   }
  //   throw Exception('Something has happened while fetching selected names');
  // }

  // Future<bool> selectName(String nameId) async {
  //   final token = await TokenHiveService.instance.getToken();
  //   final url = EndpointsConstants.selectedNames;
  //   final body = {
  //     "name_id": nameId,
  //   };

  //   final response =
  //       await BaseNetwork.instance.getDio(token: token).post(url, data: body);

  //   return response.statusCode == 200;
  // }
}
