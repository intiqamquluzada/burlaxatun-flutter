import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({
    super.key,
    this.doctorImage,
    this.name,
    this.surname,
    this.workPlace,
    this.position,
  });

  final String? doctorImage;
  final String? name;
  final String? surname;
  final String? workPlace;
  final List<String>? position;

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  late String positions = '';
  @override
  void initState() {
    for (var i = 0; i < widget.position!.length; i++) {
      positions +=
          i == 0 ? '${widget.position?[i]}' : ', ${widget.position?[i]}';
    }
    // widget.position?.forEach((position) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            imageUrl:
                'https://videodoktor.az/uploads/doctors/${widget.doctorImage}',
            errorWidget: (context, url, error) => Icon(Icons.person),
            placeholder: (context, url) {
              return Container(
                color: Colors.black12,
              );
            },
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalText(
              text: 'Dr. ${widget.name} ${widget.surname}',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            7.h,
            SizedBox(
              width: MediaQuery.of(context).size.width - 108,
              child: GlobalText(
                text: positions,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
