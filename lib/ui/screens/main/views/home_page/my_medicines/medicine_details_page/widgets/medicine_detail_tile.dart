import 'package:flutter/material.dart';

import '../../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';

class MedicineDetailTile extends StatelessWidget {
  const MedicineDetailTile({
    super.key,
    required this.detailName,
    required this.detail,
  });

  final String detailName;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90,
              child: GlobalText(
                height: 1.5,
                textAlign: TextAlign.left,
                text: detailName,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff5A5A5A),
              ),
            ),
            GlobalText(
              text: detail,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff344054),
            ),
          ],
        ),
        11.h,
        ColoredBox(
          color: Color(0xffD9D9D9),
          child: SizedBox(
            height: 1,
            width: context.deviceWidth,
          ),
        )
      ],
    );
  }
}
