import 'dart:developer';

import 'package:burla_xatun/ui/screens/questions/widgets/calculate_birth_view/calculate_birth.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../cubits/questions_cubit/questions_state.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/global_appbar.dart';
import '../../widgets/global_dots.dart';
import 'widgets/question_views/davam_et_button.dart';
import 'widgets/questions_page_view.dart';

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
    // final signUpCubit = context.read<SignupCubit>();
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Qeydiyyat',
        leading: BlocBuilder<QuestionsCubit, QuestionsInitial>(
          buildWhen: (previous, current) {
            return previous.questionPageIndex != current.questionPageIndex;
          },
          builder: (context, state) {
            return state.questionPageIndex == 3 || state.questionPageIndex == 0
                ? SizedBox.fromSize()
                : Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xff344054),
                  );
          },
        ),
        onLeadingTap: () {
          // context.pop();
          questionsCubit.goBack();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<QuestionsCubit, QuestionsInitial>(
            builder: (_, state) {
              return state.questionPageIndex < 3
                  ? Column(
                      children: [
                        36.h,
                        GlobalDots(
                          controller: questionsCubit.pageController,
                        ),
                      ],
                    )
                  : SizedBox.shrink();
            },
          ),
          QuestionsPageView(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: BlocConsumer<QuestionsCubit, QuestionsInitial>(
              buildWhen: (previous, current) {
                return previous.isActiveButton != current.isActiveButton ||
                    previous.iDontKnow != current.iDontKnow ||
                    previous.userUpdateStatus != current.userUpdateStatus ||
                    previous.questionPageIndex != current.questionPageIndex;
              },
              listenWhen: (previous, current) {
                return previous.userUpdateStatus != current.userUpdateStatus;
              },
              listener: (BuildContext context, QuestionsInitial state) {
                if (state.userUpdateStatus == UserUpdateStatus.error) {
                  AppSnackbars.error(context, 'Xəta baş verdi');
                } else if (state.userUpdateStatus == UserUpdateStatus.success) {
                  if (state.questionPageIndex == 0) {
                    context.go('/home');
                    log('success');
                  } else if (state.isFirstChild == true) {
                    // context.go('/home');
                    log('success');
                  } else if (state.isFirstChild == false) {
                    context.go('/add_child');
                  }
                }
              },
              builder: (context, state) {
                if (state.userUpdateStatus == UserUpdateStatus.loading) {
                  return CircularProgressIndicator.adaptive();
                }
                return DavamEt(
                  isActive: state.isActiveButton,
                  onPressed: () async {
                    state.questionPageIndex != 3
                        ? state.iDontKnow
                            ? {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: questionsCubit,
                                      child: CalculateBirth(),
                                    ),
                                  ),
                                )
                                // context.push('/calculate'),
                              }
                            : await questionsCubit.nextQuestion()
                        : {
                            // await questionsCubit.nextQuestion(),
                            context.go('/home')
                          };
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
