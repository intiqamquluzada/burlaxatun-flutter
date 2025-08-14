import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/questions_cubit/questions_cubit.dart';

class QuestionsPageView extends StatelessWidget {
  const QuestionsPageView({
    super.key,
    required this.isAddPregnancy,
  });

  final bool isAddPregnancy;

  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
    return Expanded(
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: questionsCubit.pageController,
        itemCount: questionsCubit.questionViews.length,
        itemBuilder: (_, i) {
          return isAddPregnancy
              ? questionsCubit.addPregnancyViews[i]
              : questionsCubit.questionViews[i];
        },
      ),
    );
  }
}
