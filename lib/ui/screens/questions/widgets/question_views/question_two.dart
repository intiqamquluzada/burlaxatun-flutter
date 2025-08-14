import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../cubits/user_update/user_update_cubit.dart';
import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/extensions/num_extensions.dart';
import '../../../../widgets/global_text.dart';

class QuestionTwo extends StatefulWidget {
  const QuestionTwo({
    super.key,
    this.isAddPregnancy = false,
  });

  final bool isAddPregnancy;

  @override
  State<QuestionTwo> createState() => _QuestionTwoState();
}

class _QuestionTwoState extends State<QuestionTwo>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final questionsCubit = context.read<QuestionsCubit>();
    // final userUpdateCubit = context.read<UserUpdateCubit>();
    return Padding(
      padding: const EdgeInsets.only(top: 56),
      child: Column(
        children: [
          GlobalText(
            textAlign: TextAlign.center,
            text: 'Neçə həftəlik hamiləsiniz?',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          36.h,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: ColoredBox(
                          color: Color(0xffFFECF2),
                          child: SizedBox(
                            height: 58,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 120),
                                  child: GlobalText(
                                    text: 'həftəlik',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffEC407A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Replaced Expanded with Positioned.fill to fill the Stack
                      Positioned.fill(
                        child: ListWheelScrollView(
                          physics: FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (i) {
                            // log(' hefte: $i');
                            questionsCubit.updateFocusedWeekIndex(i);
                            widget.isAddPregnancy
                                ? questionsCubit
                                    .updateIsActiveButtonWhileAddingPregnancy()
                                : questionsCubit.updateIsActiveButton();
                          },
                          itemExtent: 60,
                          children: [
                            for (int i = 0; i < 37; i++)
                              BlocListener<UserUpdateCubit, UserUpdateState>(
                                listener: (_, state) {
                                  // userUpdateCubit.pregnantWeek = i.toString();
                                  // userUpdateCubit.updateUser(
                                  //     pregnantWeek: i.toString());
                                },
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BlocBuilder<QuestionsCubit,
                                          QuestionsInitial>(
                                        buildWhen: (previous, current) {
                                          return previous.focusedWeekIndex !=
                                              current.focusedWeekIndex;
                                        },
                                        builder: (context, state) {
                                          // log('builded scroll wheel index: $i');
                                          return GlobalText(
                                            text: '$i',
                                            fontSize: 32,
                                            fontWeight: FontWeight.w500,
                                            color: state.focusedWeekIndex == i
                                                ? Colors.pink
                                                : Color(0xffACACAC),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28, left: 24),
              child: Row(
                children: [
                  BlocBuilder<QuestionsCubit, QuestionsInitial>(
                    buildWhen: (previous, current) {
                      return previous.iDontKnow != current.iDontKnow;
                    },
                    builder: (context, state) {
                      return Radio(
                        visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        activeColor: ColorConstants.primaryRedColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        toggleable: true,
                        splashRadius: 0,
                        value: state.iDontKnow,
                        groupValue: true,
                        onChanged: (v) {
                          questionsCubit.iDontKnowToggle(v ?? true);
                          widget.isAddPregnancy
                              ? questionsCubit
                                  .updateIsActiveButtonWhileAddingPregnancy()
                              : questionsCubit.updateIsActiveButton();
                        },
                      );
                    },
                  ),
                  SizedBox(width: 12),
                  GlobalText(
                    text: 'Bilmirəm',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
