import 'package:burla_xatun/data/models/remote/response/doctors_list_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';

class TimeAndPriceBox extends StatelessWidget {
  final Result doctor;

  const TimeAndPriceBox({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffE4E7EC),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    text: 'Uyğun Tarixlər',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  5.h,
                  GlobalText(
                    text: '${doctor.availableDays}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff667085),
                  ),
                  GlobalText(
                    text: '${doctor.availableTimes}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff667085),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    text: 'Müayinə Qiyməti',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  12.h,
                  GlobalText(
                    text: '${doctor.consultantPrice.toString()} Azn',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff667085),
                  ),
                  12.h,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
