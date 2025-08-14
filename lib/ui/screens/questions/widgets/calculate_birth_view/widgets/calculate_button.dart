import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../widgets/global_button.dart';
import 'calculation_result_dialog.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
    return BlocConsumer<QuestionsCubit, QuestionsInitial>(
      listenWhen: (previous, current) {
        return previous.stateStatus != current.stateStatus;
      },
      listener: (context, state) async {
        if (state.stateStatus == CalculateStateStatus.success) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: questionsCubit,
                child: CalculationResultDialog(),
              );
            },
          );
        } else if (state.stateStatus == CalculateStateStatus.error) {
          AppSnackbars.error(context, 'Hesablama zamanı xəta baş verdi');
        }
      },
      builder: (context, state) {
        return GlobalButton(
          buttonName: state.stateStatus == CalculateStateStatus.loading
              ? 'Hesablanır ...'
              : 'Hesabla',
          buttonColor: ColorConstants.primaryRedColor,
          textColor: Colors.white,
          onPressed: state.stateStatus == CalculateStateStatus.loading
              ? () {}
              : () async {
                  if (state.selectedCalculateOptionIndex == null) {
                    questionsCubit.stateError();
                  } else {
                    log('question one button notifier value: ${questionsCubit.questionOneButtonNotifier.value}');
                    await questionsCubit.calculate();
                  }
                },
        );
      },
    );
  }
}
