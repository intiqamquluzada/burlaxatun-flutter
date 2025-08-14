import 'package:burla_xatun/ui/screens/questions/widgets/calculate_birth_view/widgets/calculate_option_bottomsheet/calculate_option_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../../../utils/constants/asset_constants.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class CalculationMethodWidget extends StatelessWidget {
  const CalculationMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GlobalText(
              text: 'Hesablama',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff667085),
            ),
          ],
        ),
        10.h,
        GestureDetector(
          onTap: () {
            questionsCubit.showCalculateMethods(
                context, CalculateOptionBottomsheet());
            // questionsCubit.showOptionsToggle();
          },
          child: SizedBox(
            height: 56,
            width: double.maxFinite,
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
                      buildWhen: (previous, current) {
                        return previous.selectedCalculateOptionString !=
                            current.selectedCalculateOptionString;
                      },
                      builder: (context, state) {
                        return GlobalText(
                          text: state.selectedCalculateOptionString,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        );
                      },
                    ),
                    BlocBuilder<QuestionsCubit, QuestionsInitial>(
                      builder: (context, state) {
                        return SvgPicture.asset(
                          state.showOptions
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
