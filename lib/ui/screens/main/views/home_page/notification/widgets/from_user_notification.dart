import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:burla_xatun/utils/helper/time_ago_helper.dart' as PastHelper;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FromUserNotification extends StatelessWidget {
  const FromUserNotification({
    super.key,
    this.image,
    this.fullName,
    this.text,
    this.createdAt,
  });

  final String? image;
  final String? fullName;
  final String? text;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              imageUrl: '${EndpointsConstants.baseUrl}/$image',
              errorWidget: (context, url, error) => SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Icon(Icons.person),
                ),
              ),
              fadeInCurve: Curves.easeIn,
              placeholder: (context, url) {
                return Column(
                  children: [
                    CircularProgressIndicator.adaptive(),
                  ],
                );
              },
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: fullName ?? 'İstifadəçi',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Color(0xff070707),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '  sorğunuza cavab verdi',
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
                  text: text ?? 'tapılmadı',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  maxLines: 5,
                ),
              ),
              4.h,
              GlobalText(
                text: '${PastHelper.timeAgo(createdAt!)} öncə',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xff8E8E93),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
