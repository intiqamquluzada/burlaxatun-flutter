import 'package:flutter/material.dart';

import '../../../../../../../../data/models/remote/response/doctors_model.dart';
import '../../../../../../../../utils/extensions/num_extensions.dart';
import 'doctor_info.dart';
import 'doctor_register_button.dart';

class DoctorBox extends StatelessWidget {
  final Doctor doctor;

  const DoctorBox({
    super.key,
    required this.doctor,
  });

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
                name: doctor.name,
                surname: doctor.surname,
                doctorImage: doctor.imageFile,
                workPlace: 'deded',
                position: doctor.specializations,
              ),
              // 24.h,
              // TimeAndPriceBox(
              //   doctor: doctor,
              // ),
              24.h,
              DoctorRegisterButton(
                doctorId: doctor.id ?? -1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
