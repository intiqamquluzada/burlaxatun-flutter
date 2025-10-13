import 'package:burla_xatun/data/contractor/indicator_contract.dart';
import 'package:burla_xatun/data/services/remote/indicator_service.dart';
import 'package:dio/src/response.dart';

class IndicatorRepo implements IndicatorContract {
  IndicatorRepo(this.indicatorService);

  final IndicatorService indicatorService;

  @override
  Future<Response> getIndicator({
    int? babyId,
    required String indicatorName,
    required String range,
  }) {
    return indicatorService.getIndicator(
      babyId: babyId,
      indicatorName: indicatorName,
      range: range,
    );
  }

  @override
  Future<Response> addIndicator({required Map<String, dynamic> postData}) {
    return indicatorService.addIndicator(postData: postData);
  }
}
