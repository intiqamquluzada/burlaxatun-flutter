import 'package:dio/dio.dart';

abstract class DoctorsListContractor {
  Future<Response> getSpecializations({String? url});

  Future<Response> getDoctorsList({
    int? specializationId,
    String? search,
    String? url,
  });
}
