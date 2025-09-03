import 'package:burla_xatun/cubits/user_update/user_update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/constants/padding_constants.dart';
import '../../../../../utils/extensions/num_extensions.dart';
import '../../../../widgets/global_button.dart';
import '../../../../widgets/global_text.dart';

class QuestionThree extends StatefulWidget {
  const QuestionThree({
    super.key,
    this.isAddPregnancy = false,
  });

  final bool isAddPregnancy;

  @override
  State<QuestionThree> createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final questionCubit = context.read<QuestionsCubit>();
    final userUpdateCubit = context.read<UserUpdateCubit>();

    return Padding(
      padding: PaddingConstants.h20 + EdgeInsets.only(top: 56),
      child: Column(
        children: [
          GlobalText(
            text: 'İlk körpənizdi?',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          60.h,
          BlocBuilder<QuestionsCubit, QuestionsInitial>(
            builder: (context, state) {
              return GlobalButton(
                buttonName: 'Bəli',
                buttonColor: state.isFirstChild != null && state.isFirstChild!
                    ? Color(0xffFFD3E2)
                    : Colors.white,
                borderColor: state.isFirstChild != null && state.isFirstChild!
                    ? Colors.transparent
                    : ColorConstants.primaryRedColor,
                textColor: ColorConstants.primaryRedColor,
                onPressed: () {
                  questionCubit.updateQuestionThreeAnswer(true);
                  widget.isAddPregnancy
                      ? questionCubit.updateIsActiveButtonWhileAddingPregnancy()
                      : questionCubit.updateIsActiveButton();
                  // userUpdateCubit.firstChild = true;
                  // userUpdateCubit.updateUser(firstChild: true);
                },
              );
            },
          ),
          14.h,
          BlocBuilder<QuestionsCubit, QuestionsInitial>(
            builder: (context, state) {
              return GlobalButton(
                buttonName: 'Xeyr',
                buttonColor: state.isFirstChild != null && !state.isFirstChild!
                    ? Color(0xffFFD3E2)
                    : Colors.white,
                borderColor: state.isFirstChild != null && !state.isFirstChild!
                    ? Colors.transparent
                    : ColorConstants.primaryRedColor,
                textColor: ColorConstants.primaryRedColor,
                onPressed: () {
                  questionCubit.updateQuestionThreeAnswer(false);
                  widget.isAddPregnancy
                      ? questionCubit.updateIsActiveButtonWhileAddingPregnancy()
                      : questionCubit.updateIsActiveButton();
                  // userUpdateCubit.firstChild = false;
                  // userUpdateCubit.updateUser(firstChild: false);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
