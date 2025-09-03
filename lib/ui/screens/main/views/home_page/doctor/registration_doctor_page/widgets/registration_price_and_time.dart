import 'package:flutter/material.dart';

import '../../../../../../../../data/models/remote/response/doctor_detail_model.dart';
import '../../../../../../../../utils/extensions/num_extensions.dart';
import 'date_or_price_box.dart';

class RegistrationPriceAndTime extends StatelessWidget {
  final DoctorDetailResponse doctor;
  const RegistrationPriceAndTime({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF2F4F7),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              DateOrPriceBox(
                boxName: 'Uyğun Tarix',
                boxInfo: '${doctor.availableDays} | ${doctor.availableTimes}',
              ),
              26.h,
              DateOrPriceBox(
                boxName: 'Müayinə Qiyməti',
                boxInfo: '${doctor.consultantPrice} Azn',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
