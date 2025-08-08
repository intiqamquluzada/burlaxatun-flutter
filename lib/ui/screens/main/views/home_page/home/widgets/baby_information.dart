import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../cubits/pregnancy_progress/pregnancy_progress_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';
import 'baby_info_box.dart';
import 'more_details_button.dart';

class BabyInformation extends StatefulWidget {
  const BabyInformation({
    super.key,
    // required this.week,
  });

  // final String week;

  @override
  State<BabyInformation> createState() => _BabyInformationState();
}

class _BabyInformationState extends State<BabyInformation> {
  late PregnancyProgressCubit pregnancyProgressCubit;
  @override
  void initState() {
    log('init baby info box.');
    pregnancyProgressCubit = context.read<PregnancyProgressCubit>()
      ..getPregnancyProgress(date: DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: BlocBuilder<PregnancyProgressCubit, PregnancyProgressState>(
          builder: (context, state) {
            if (state.pregnancyProgressStatus ==
                PregnancyProgressStatus.loading) {
              return CircularProgressIndicator.adaptive();
            } else if (state.pregnancyProgressStatus ==
                PregnancyProgressStatus.error) {
              return Text('Körpənin məlumatları tapılmadı');
            } else if (state.pregnancyProgressStatus ==
                PregnancyProgressStatus.networkError) {
              return Text('Şəbəkəni yoxlayın');
            }
            if (state.pregnancyProgressStatus ==
                PregnancyProgressStatus.success) {
              final progressData = state.progressData;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  26.h,
                  SizedBox(
                    child: GlobalText(
                      textAlign: TextAlign.left,
                      text: '${progressData?.subTitle}',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8C8A8A),
                    ),
                  ),
                  38.h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffF1F3DB),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${progressData?.imageLeft}',
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error);
                          },
                        ),
                      ),
                      SizedBox(width: 19),
                      SvgPicture.asset(
                          'assets/icons/pregnancy_progress_arrows.svg'),
                      SizedBox(width: 19),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFEF2F2),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${progressData?.imageRight}',
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error);
                          },
                        ),
                      ),
                    ],
                  ),
                  40.h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 17,
                    children: [
                      BabyInfoBox(
                        boxName: 'Körpənin ölçüsü',
                        boxData: '${progressData?.babyHeight} cm',
                      ),
                      BabyInfoBox(
                        boxName: 'Körpənin kütləsi',
                        boxData: '${progressData?.babyWeight} gr',
                      ),
                      BabyInfoBox(
                        boxName: 'Qalan günlər',
                        boxData: '${progressData?.daysLeft} gün',
                      ),
                    ],
                  ),
                  38.h,
                  MoreDetailsButton(),
                  24.h,
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
