import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../cubits/questions_cubit/questions_state.dart';
import '../../../utils/app/app_snackbars.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/global_appbar.dart';
import '../../widgets/global_dots.dart';
import 'widgets/calculate_birth_view/calculate_birth.dart';
import 'widgets/question_views/davam_et_button.dart';
import 'widgets/questions_page_view.dart';

class Questions extends StatefulWidget {
  const Questions({
    super.key,
    this.isAddPregnancy = false,
  });

  final bool isAddPregnancy;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late final QuestionsCubit questionsCubit;
  @override
  void initState() {
    questionsCubit = context.read<QuestionsCubit>();
    widget.isAddPregnancy ? questionsCubit.initializeIsAddPregnancy() : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: widget.isAddPregnancy ? 'Hamiləlik' : 'Qeydiyyat',
        leading: BlocBuilder<QuestionsCubit, QuestionsInitial>(
          buildWhen: (previous, current) {
            return previous.questionPageIndex != current.questionPageIndex;
          },
          builder: (context, state) {
            if (widget.isAddPregnancy) {
              return state.questionPageIndex == 2
                  ? SizedBox.fromSize()
                  : Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff344054),
                    );
            } else {
              return state.questionPageIndex == 3 ||
                      state.questionPageIndex == 0
                  ? SizedBox.fromSize()
                  : Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff344054),
                    );
            }
          },
        ),
        onLeadingTap: () {
          // context.pop();
          widget.isAddPregnancy && questionsCubit.state.questionPageIndex == 0
              ? context.pop()
              : questionsCubit.goBack();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<QuestionsCubit, QuestionsInitial>(
            builder: (_, state) {
              return (widget.isAddPregnancy
                      ? state.questionPageIndex < 2
                      : state.questionPageIndex < 3)
                  ? Column(
                      children: [
                        36.h,
                        GlobalDots(
                          count: widget.isAddPregnancy ? 2 : 3,
                          controller: questionsCubit.pageController,
                        ),
                      ],
                    )
                  : SizedBox.shrink();
            },
          ),
          QuestionsPageView(isAddPregnancy: widget.isAddPregnancy),
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
                    widget.isAddPregnancy ? null : context.go('/home');
                    log('success');
                  } else if (state.isFirstChild == true) {
                    log('success');
                    widget.isAddPregnancy
                        ? context.go('/success_add_pregnancy')
                        : null;
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
                    if (widget.isAddPregnancy) {
                      state.questionPageIndex != 2
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
                              : await questionsCubit.addPregnancyNextButton()
                          : {
                              context.read<MainCubit>().changeView(0),
                            };
                    } else {
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
                              context.go('/home'),
                            };
                    }
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
