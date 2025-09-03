import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
    // this.doctor,
    this.doctorImage,
    this.name,
    this.surname,
    this.workPlace,
    this.position,
  });

  // final Result? doctor;

  final String? doctorImage;
  final String? name;
  final String? surname;
  final String? workPlace;
  final String? position;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            imageUrl: doctorImage ?? '',
            errorWidget: (context, url, error) => Icon(Icons.person),
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GlobalText(
                  text: 'Dr. $name $surname',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ],
            ),
            7.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GlobalText(
                  text: position ?? 'Tapılmadı',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(width: 4),
                GlobalText(
                  text: '• ',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(width: 4),
                GlobalText(
                  text: workPlace ?? 'Tapılmadı',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
