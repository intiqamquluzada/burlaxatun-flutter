import 'package:burla_xatun/data/models/remote/response/notifications_model.dart';
import 'package:burla_xatun/utils/helper/past_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class NotificationBox extends StatelessWidget {
  const NotificationBox({
    super.key,
    required this.notification,
  });

  final NotificationsModel notification;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE4E7EC),
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset('assets/png/user_image.png'),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '@JeanetteGottlieb',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xff070707),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' sorğunuza cavab verdi',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Color(0xff8E8E93),
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  4.h,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: GlobalText(
                      height: 1.3,
                      textAlign: TextAlign.left,
                      text: notification.text ?? 'tapılmadı',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  4.h,
                  GlobalText(
                    text:
                        '${PastHelper.timeAgo(notification.createdAt.toString())} dəqiqə əvvəl',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff8E8E93),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
