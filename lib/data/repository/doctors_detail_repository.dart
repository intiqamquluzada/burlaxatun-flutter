import 'package:dio/dio.dart';

import '../contractor/doctors_detail_contractor.dart';
import '../services/remote/doctors_detail_service.dart';

class DoctorDetailRepository implements DoctorDetailContractor {
  DoctorDetailRepository(this._doctorDetailService);

  final DoctorDetailService _doctorDetailService;

  @override
  Future<Response> getDoctorDetail({required int doctorId}) {
    return _doctorDetailService.getDoctorDetail(doctorId: doctorId);
  }

  @override
  Future<Response> getAvailableTimes({
    required String date,
    required int doctorId,
  }) {
    return _doctorDetailService.getAvailableTimes(
      date: date,
      doctorId: doctorId,
    );
  }
}
