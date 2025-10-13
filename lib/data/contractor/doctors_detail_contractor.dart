import 'package:dio/dio.dart';

abstract class DoctorDetailContractor {
  Future<Response> getDoctorDetail({required int doctorId});
  Future<Response> getAvailableTimes({
    required String date,
    required int doctorId,
  });
}
