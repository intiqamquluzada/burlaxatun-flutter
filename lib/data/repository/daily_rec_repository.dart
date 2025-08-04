import 'package:dio/dio.dart';

import '../contractor/daily_rec_contractor.dart';
import '../services/remote/daily_rec_service.dart';

class DailyRecRepository implements DailyRecContractor {
  DailyRecRepository(this._dailyRecService);

  final DailyRecService _dailyRecService;

  @override
  Future<Response<dynamic>> getDailyRec() {
    return _dailyRecService.getDailyRec();
  }
}
