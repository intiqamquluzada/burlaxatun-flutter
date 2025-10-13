import 'package:burla_xatun/data/contractor/doctor_reserv_contract.dart';
import 'package:burla_xatun/data/services/remote/doctor_reservation_service.dart';
import 'package:dio/src/response.dart';

class DoctorReservRepository implements DoctorReservContract {
  DoctorReservRepository(this._doctorReservationService);

  final DoctorReservationService _doctorReservationService;

  @override
  Future<Response<dynamic>> reserveDoctor({
    required int schedulingTimeId,
  }) {
    return _doctorReservationService.reserveDoctor(
      schedulingTimeId: schedulingTimeId,
    );
  }
}
