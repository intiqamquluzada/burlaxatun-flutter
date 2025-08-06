import 'package:dio/src/response.dart';

import '../contractor/ultrasound_contract.dart';
import '../services/remote/ultrasound_service.dart';

class UltrasoundRepo implements UltrasoundContract {
  UltrasoundRepo(this.ultrasoundService);

  final UltrasoundService ultrasoundService;

  @override
  Future<Response<dynamic>> getUltraSound({required int week}) {
    return ultrasoundService.getUltraSound(week: week);
  }
}
