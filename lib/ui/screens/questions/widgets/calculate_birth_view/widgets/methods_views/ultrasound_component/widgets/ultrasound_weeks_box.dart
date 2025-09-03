import 'package:burla_xatun/ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/ultrasound_component/widgets/ultrasound_weeks_bottomsheet.dart';
import 'package:burla_xatun/utils/extensions/context_extensions.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../../../../../utils/constants/asset_constants.dart';
import '../../../../../../../../widgets/global_text.dart';

class UltrasoundWeeksBox extends StatelessWidget {
  const UltrasoundWeeksBox({super.key});

  @override
  Widget build(BuildContext context) {
    final questionCubit = context.read<QuestionsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalText(
          text: "Həftə",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xff667085),
        ),
        10.h,
        GestureDetector(
          onTap: () {
            questionCubit.showWeekCount(context, UltrasoundWeeksBottomsheet());
          },
          child: SizedBox(
            height: 56,
            width: context.deviceWidth * 0.43,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(34)),
                border: Border.all(color: Color(0xffEAEAEA)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<QuestionsCubit, QuestionsInitial>(
                      builder: (context, state) {
                        return GlobalText(
                          text: state.ultrasoundWeekCount == null
                              ? 'Həftə sayı'
                              : '${state.ultrasoundWeekCount.toString()} həftə',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        );
                      },
                    ),
                    BlocBuilder<QuestionsCubit, QuestionsInitial>(
                      buildWhen: (previous, current) {
                        return previous.isShowUltrasoundWeeks !=
                            current.isShowUltrasoundWeeks;
                      },
                      builder: (context, state) {
                        return SvgPicture.asset(
                          state.isShowUltrasoundWeeks
                              ? AssetConstants.arrowUpIcon
                              : AssetConstants.arrowDownIcon,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
