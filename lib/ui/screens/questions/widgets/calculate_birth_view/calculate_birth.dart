import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../utils/extensions/num_extensions.dart';
import '../../../../widgets/global_appbar.dart';
import 'widgets/calculate_button.dart';
import 'widgets/calculate_methods/calculation_method_widget.dart';
import 'widgets/calculate_methods/calculation_options.dart';
import 'widgets/date_selection/calendar_widget.dart';
import 'widgets/date_selection/select_date_widget.dart';

class CalculateBirth extends StatelessWidget {
  const CalculateBirth({
    super.key,
    // required this.signupCubit,
    // required this.questionsCubit,
  });
  // final SignupCubit signupCubit;
  // final QuestionsCubit questionsCubit;
  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Doğuşu hesabla',
        onLeadingTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        controller: questionsCubit.scrollController,
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
          child: Column(
            children: [
              CalculationMethodWidget(),
              BlocBuilder<QuestionsCubit, QuestionsInitial>(
                buildWhen: (previous, current) {
                  return previous.showOptions != current.showOptions;
                },
                builder: (context, state) {
                  return Visibility(
                    visible: state.showOptions,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: CalculationOptions(),
                    ),
                  );
                },
              ),
              20.h,
              SelectDateWidget(),
              BlocBuilder<QuestionsCubit, QuestionsInitial>(
                buildWhen: (previous, current) =>
                    previous.showCalendar != current.showCalendar,
                builder: (context, state) {
                  return state.showCalendar
                      ? Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: CalendarWidget(focusedDay: state.selectedDay),
                        )
                      : SizedBox.shrink();
                },
              ),
              BlocBuilder<QuestionsCubit, QuestionsInitial>(
                buildWhen: (previous, current) {
                  return previous.selectedCalculateOptionIndex !=
                      current.selectedCalculateOptionIndex;
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: questionsCubit.calculationOptions[
                        state.selectedCalculateOptionIndex ?? 0],
                  );
                },
              ),
              30.h,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 18, right: 18),
        child: CalculateButton(),
      ),
    );
  }
}
