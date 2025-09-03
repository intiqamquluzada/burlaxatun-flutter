import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../../../cubits/pregnancy_progress/pregnancy_progress_cubit.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class BabyText extends StatelessWidget {
  const BabyText({super.key});

  @override
  Widget build(BuildContext context) {
    final pregnancyProgressCubit = context.read<PregnancyProgressCubit>();
    final progressData = pregnancyProgressCubit.state.progressData;
    return Column(
      children: [
        GlobalText(
          height: 1.5,
          textAlign: TextAlign.left,
          text: 'Hamiləliyin ${progressData?.week}. həftəsində nə baş verir?',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        28.h,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.27,
            //   height: MediaQuery.of(context).size.height * 0.12,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xffF1F3DB),
            //   ),
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         '${EndpointsConstants.baseUrl}${progressData?.imageLeft}',
            //     errorWidget: (context, url, error) {
            //       return Icon(Icons.error);
            //     },
            //   ),
            // ),
            CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: '${progressData?.imageLeft}',
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
              },
            ),
            SizedBox(width: 52),
            CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: '${progressData?.imageRight}',
              errorWidget: (context, url, error) {
                return Icon(Icons.error);
              },
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.27,
            //   height: MediaQuery.of(context).size.height * 0.12,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xffFEF2F2),
            //   ),
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         '${EndpointsConstants.baseUrl}${progressData?.imageLeft}',
            //     errorWidget: (context, url, error) {
            //       return Icon(Icons.error);
            //     },
            //   ),
            // ),
          ],
        ),
        28.h,
        SizedBox(
          width: context.deviceWidth * 0.9,
          child: GlobalText(
            height: 1.5,
            textAlign: TextAlign.left,
            text: '${progressData?.subTitle}',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xff656565),
          ),
        ),
        5.h,
        Html(data: progressData?.text),
        // GlobalText(
        //   height: 1.2,
        //   textAlign: TextAlign.left,
        //   text: progressData?.text ?? '',
        //   fontSize: 18,
        //   fontWeight: FontWeight.w400,
        //   color: Color(0xff656565),
        // ),
        10.h,
      ],
    );
  }
}
