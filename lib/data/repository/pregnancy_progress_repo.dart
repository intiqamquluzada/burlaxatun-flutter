import 'package:dio/src/response.dart';

import '../contractor/pregnancy_progress_contract.dart';
import '../services/remote/pregnancy_progress_service.dart';

class PregnancyProgressRepo implements PregnancyProgressContract {
  PregnancyProgressRepo(this.pregnancyProgressService);

  final PregnancyProgressService pregnancyProgressService;

  @override
  Future<Response> getPregnancyProgress({required String week}) {
    return pregnancyProgressService.getPregnancyProgress(week: week);
  }
}
