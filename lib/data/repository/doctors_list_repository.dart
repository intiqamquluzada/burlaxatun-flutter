import 'package:dio/src/response.dart';

import '../contractor/doctors_list_contractor.dart';
import '../services/remote/doctors_list_service.dart';

class DoctorsListRepository implements DoctorsListContractor {
  DoctorsListRepository(this._doctorsListService);

  final DoctorsListService _doctorsListService;

  @override
  Future<Response> getSpecializations({String? url}) {
    return _doctorsListService.getSpecializations(url: url);
  }

  @override
  Future<Response> getDoctorsList({
    int? specializationId,
    String? search,
    String? url,
  }) {
    return _doctorsListService.getDoctorsList(
      specializationId: specializationId,
      search: search,
      url: url,
    );
  }
}
