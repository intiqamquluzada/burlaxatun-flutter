import 'package:burla_xatun/data/models/remote/response/pregnancy_calculate_model.dart';
import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';

class PregnancyService {
  Future<PregnancyCalculateModel> calculatePregnancy({
    required int type,
    required String date,
    int? period,
    int? ivf,
    int? week,
    int? day,
  }) async {
    final endpoint = EndpointsConstants.pregnancyCalculateDetails;

    final requestBody = {
      "type": type,
      "date": date,
      "period": period,
      "ivf": ivf,
      "week": week ?? 0,
      "day": day ?? 0,
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(endpoint, data: requestBody);

    if (response.statusCode.isSuccess) {
      return PregnancyCalculateModel.fromJson(response.data);
    }
    if (response.statusCode.isFailure) {
      throw Exception("Unable to post Pregnancy Calculate Service");
    }
    throw Exception("Not available data in Pregnancy Calculate Service");
  }
}
