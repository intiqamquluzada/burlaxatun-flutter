import 'package:flutter/material.dart';

import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class BabyInfoBox extends StatelessWidget {
  const BabyInfoBox({
    super.key,
    required this.boxName,
    required this.boxData,
  });
  final String boxName;
  final String boxData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF1F5F8),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalText(
                text: boxName,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff8C8A8A),
              ),
              12.h,
              GlobalText(
                text: boxData,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
