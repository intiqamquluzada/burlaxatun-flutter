import 'package:flutter/material.dart';

import '../../../../../../widgets/global_text.dart';

class FromAdminNotification extends StatelessWidget {
  const FromAdminNotification({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: GlobalText(
              height: 1.3,
              textAlign: TextAlign.left,
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xff1D2939),
              maxLines: 5,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: GlobalText(
              height: 1.3,
              textAlign: TextAlign.left,
              text: text,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff1D2939),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
