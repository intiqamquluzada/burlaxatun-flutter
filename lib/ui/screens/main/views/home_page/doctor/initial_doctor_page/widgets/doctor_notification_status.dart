import 'package:flutter/material.dart';

import '../../../../../../../widgets/global_text.dart';

class DoctorNotificationStatus extends StatefulWidget {
  const DoctorNotificationStatus({
    super.key,
    required this.status,
  });
  final String? status;
  @override
  State<DoctorNotificationStatus> createState() =>
      _DoctorNotificationStatusState();
}

class _DoctorNotificationStatusState extends State<DoctorNotificationStatus> {
  late final Color boxColor;
  late final Color textColor;
  late final String notificationText;
  @override
  void initState() {
    switch (widget.status) {
      case 'pending':
        notificationText = 'Rezervasiyanız təsdiq gözləmə statusundadır';
        boxColor = Color.fromARGB(255, 203, 203, 203);
        textColor = Color(0xff667085);
        break;
      case 'approved':
        notificationText =
            'Təəssüfki, qeyd ettiyiniz tarix həkim tərəfindən qəbul edilmədi.';
        boxColor = Color(0xffD1FADF);
        textColor = Color(0xff027A48);
        break;
      case 'declined':
        notificationText =
            'Qeyd edilən tarix həkim tərəfindən qəbul edilmişdir!';
        boxColor = Color(0xffFEE4E2);
        textColor = Color(0xffF04438);
        break;
      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: GlobalText(
            height: 1.4,
            textAlign: TextAlign.left,
            text: notificationText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
