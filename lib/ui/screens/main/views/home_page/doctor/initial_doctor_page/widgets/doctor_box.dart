import 'package:burla_xatun/data/models/remote/response/doctors_list_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../utils/extensions/num_extensions.dart';
import 'doctor_info.dart';
import 'doctor_register_button.dart';
import 'time_and_price_box.dart';

class DoctorBox extends StatelessWidget {
  final Result doctor;

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
              DoctorInfo(doctor: doctor),
              24.h,
              TimeAndPriceBox(
                doctor: doctor,
              ),
              24.h,
              DoctorRegisterButton(
                slug: doctor.slug ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
