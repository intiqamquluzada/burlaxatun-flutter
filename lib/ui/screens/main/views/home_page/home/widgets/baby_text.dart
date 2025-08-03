import 'package:burla_xatun/cubits/pregnancy_progress/pregnancy_progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
        SvgPicture.asset('assets/svgs/baby_size.svg'),
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
        GlobalText(
          height: 1.2,
          textAlign: TextAlign.left,
          text: progressData?.text ?? '',
          // 'Ölçü və Forma: Embrion təxminən 4-6 mm ölçüdədir, kiçik "C" hərfinə bənzəyir. Ürək: strukturu hələ də primitiv olsa da, döyünməyə və qan vurmağa başlayır.Orqanlar: Beyin, qaraciyər, ağciyərlər və bağırsaqlar da daxil olmaqla mühüm orqanların əsasları formalaşır.',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Color(0xff656565),
        ),
        10.h,
      ],
    );
  }
}
