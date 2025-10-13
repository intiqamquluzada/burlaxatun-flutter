import 'package:burla_xatun/data/models/remote/response/my_reservations_model.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/doctor/initial_doctor_page/widgets/doctor_info.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../utils/extensions/num_extensions.dart';
import 'doctor_notification_status.dart';
import 're_registration_button.dart';

class DoctorsNotificationBoxWidget extends StatelessWidget {
  const DoctorsNotificationBoxWidget({
    super.key,
    required this.reservation,
  });

  final DoctorNotificationModel reservation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(122, 242, 244, 247),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          child: Column(
            children: [
              DoctorInfo(
                name: reservation.doctorName,
                surname: reservation.doctorSurname,
                doctorImage: reservation.doctorImage,
                workPlace: reservation.doctorWorkplace,
                position: [],
              ),
              24.h,
              DoctorNotificationStatus(status: reservation.status),
              24.h,
              Visibility(
                visible: reservation.status == 'declined',
                child: ReRegistrationButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
