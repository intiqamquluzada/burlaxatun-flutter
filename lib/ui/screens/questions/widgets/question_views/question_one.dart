import 'package:burla_xatun/cubits/user_update/user_update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../data/models/local/question_one_options_model.dart';
import '../../../../../utils/constants/padding_constants.dart';
import '../../../../../utils/extensions/num_extensions.dart';
import '../../../../widgets/global_text.dart';
import 'question_one_buttons.dart';

class QuestionOne extends StatefulWidget {
  const QuestionOne({super.key});

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final questionsCubit = context.read<QuestionsCubit>();
    final userUpdateCubit = context.read<UserUpdateCubit>();

    return Padding(
      padding: PaddingConstants.h20 + EdgeInsets.only(top: 56),
      child: Column(
        children: [
          GlobalText(
            text: 'Siz hamiləsiniz?',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          59.h,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (_, i) {
              return BlocListener<UserUpdateCubit, UserUpdateState>(
                listener: (_, state) {
                  if (i == 0) {
                    // userUpdateCubit.isPregnant = true;
                    userUpdateCubit.updateUser(isPregnant: true);
                  } else if (i == 1) {
                    // userUpdateCubit.wantToSeePeriod = true;
                    userUpdateCubit.updateUser(wantToSeePeriod: true);
                  } else if (i == 2) {
                    // userUpdateCubit.wantToBePregnant = true;
                    userUpdateCubit.updateUser(wantToBePregnant: true);
                  }
                },
                child: QuestionOneButton(
                  buttonName: QuestionOneOptionsModel.options[i].option,
                  optionIndex: i,
                  questionsCubit: questionsCubit,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
