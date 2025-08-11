// import 'dart:async';
// import 'dart:developer';

// import 'package:burla_xatun/data/models/remote/response/pregnancy_calculate_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../data/services/remote/pregnancy_service.dart';
// import '../../ui/screens/main/views/home_page/home/home_page.dart';
// import '../../ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/first_day_of_last_period_component/first_day_of_last_period.dart';
// import '../../ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/ivf_component/ivf.dart';
// import '../../ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/ultrasound_component/ultrasound.dart';
// import '../../ui/screens/questions/widgets/question_views/add_your_child.dart';
// import '../../ui/screens/questions/widgets/question_views/question_one.dart';
// import '../../ui/screens/questions/widgets/question_views/question_three.dart';
// import '../../ui/screens/questions/widgets/question_views/question_two.dart';
// import '../../ui/screens/questions/widgets/question_views/register_success.dart';
// import 'questions_state.dart';

// enum CalculateStateStatus { initial, success, error, loading }

// class QuestionsCubit extends Cubit<QuestionsInitial> {
//   QuestionsCubit()
//       : super(
//           QuestionsInitial(
//             currentQuestionOneOptionIndex: null,
//             selectedCalculateOptionIndex: null,
//             questionPageIndex: 0,
//             focusedWeekIndex: 0,
//             iDontKnow: false,
//             showOptions: false,
//             showDays: false,
//             showCalendar: false,
//             selectedCalculateOptionString: 'Hesablama üsulunu seçin...',
//             selectedPeriodTimeString: 'Period muddetini secin...',
//             birthDateString: 'Dogum tarixini qeyd edinn',
//             selectedDay: DateTime.now(),
//             isActiveButton: false,
//             isFirstChild: null,
//             initialDateTime: DateTime(DateTime.now().year - 10,
//                 DateTime.now().month, DateTime.now().day),
//             ivfRadioValue: -1,
//             ultrasoundDayCount: null,
//             ultrasoundWeekCount: null,
//             isShowUltrasoundDays: false,
//             isShowUltrasoundWeeks: false,
//             stateStatus: CalculateStateStatus.initial,
//           ),
//         );

//   final pageController = PageController();
//   final scrollController = ScrollController();
//   final childNameFocusNode = FocusNode();
//   final childWeightFocusNode = FocusNode();
//   final childHeightFocusNode = FocusNode();
//   final ValueNotifier<int?> questionOneButtonNotifier =
//       ValueNotifier<int?>(null);
//   final PregnancyService pregnancyService = PregnancyService();

//   final List questionViews = [
//     QuestionOne(),
//     QuestionTwo(),
//     QuestionThree(),
//     RegisterSuccess(),
//     AddYourChild(),
//   ];

//   final List calculationOptions = [
//     SizedBox.shrink(),
//     FirstDayOfLastPeriod(),
//     Ivf(),
//     Ultrasound(),
//   ];

//   void stateLoading() {
//     emit(state.copyWith(stateStatus: CalculateStateStatus.loading));
//   }

//   void stateInitial() {
//     emit(state.copyWith(stateStatus: CalculateStateStatus.initial));
//   }

//   void stateError() {
//     emit(state.copyWith(stateStatus: CalculateStateStatus.error));
//     stateInitial();
//   }

//   late PregnancyCalculateModel calculatedData;

//   Future<void> calculate() async {
//     try {
//       calculatedData = await pregnancyService.calculatePregnancy(
//         type: (state.selectedCalculateOptionIndex ?? 0),
//         date: state.birthDateString,
//         period: state.focusedWeekIndex,
//         ivf: state.ivfRadioValue,
//         week: state.ultrasoundWeekCount,
//         day: state.ultrasoundDayCount,
//       );
//       emit(state.copyWith(stateStatus: CalculateStateStatus.success));
//       stateInitial();
//     } catch (e, s) {
//       log('Stack Trace: $s');
//       log('calculation error: $e');
//       stateError();
//       throw Exception('calculated error: $e');
//     }
//   }

//   void scrollBottom() {
//     if (!state.showDays) {
//       showDaysToggle();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         scrollController.animateTo(
//           scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.ease,
//         );
//       });
//     } else {
//       showDaysToggle();
//     }
//   }

//   void scrollBottomCalendar() {
//     if (!state.showDays) {
//       showCalendarToggle();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         scrollController.animateTo(
//           scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.ease,
//         );
//       });
//     } else {
//       showCalendarToggle();
//     }
//   }

//   void updateRadioValue(int v) {
//     emit(state.copyWith(ultrasoundRadioValue: v));
//   }

//   void updateIsActiveButton({int? v}) {
//     switch (state.questionPageIndex) {
//       case 0:
//         if (questionOneButtonNotifier.value != null) {
//           emit(state.copyWith(
//             isActiveButton: true,
//           ));
//         }
//         break;
//       case 1:
//         if (state.iDontKnow || state.focusedWeekIndex != 0) {
//           emit(state.copyWith(isActiveButton: true));
//         } else {
//           emit(state.copyWith(isActiveButton: false));
//         }
//         break;
//       case 2:
//         if (state.isFirstChild != null) {
//           emit(state.copyWith(isActiveButton: true));
//         }
//         break;
//       default:
//         log('default');
//     }
//   }

//   void updateCurrentQuestionOneOption(int v) {
//     emit(state.copyWith(currentQuestionOneOptionIndex: v));
//   }

//   void updateSelectedDay(DateTime v) {
//     emit(state.copyWith(selectedDay: v));
//   }

//   void updateQuestionThreeAnswer(bool v) {
//     emit(state.copyWith(isFirstChild: v));
//   }

//   void updatePeriodTime(String v) {
//     emit(state.copyWith(selectedPeriodTimeString: v));
//   }

//   void updateFocusedWeekIndex(int v) {
//     emit(state.copyWith(focusedWeekIndex: v));
//   }

//   void nextQuestion() {
//     if (state.questionPageIndex <= 2) {
//       emit(state.copyWith(questionPageIndex: state.questionPageIndex + 1));

//       if (state.questionPageIndex < 3) {
//         pageController.animateToPage(
//           state.questionPageIndex,
//           duration: Durations.medium2,
//           curve: Curves.linear,
//         );
//         emit(state.copyWith(isActiveButton: false));
//       } else if (state.isFirstChild! && state.questionPageIndex < 4) {
//         pageController.jumpToPage(state.questionPageIndex);
//       } else if (!state.isFirstChild! && state.questionPageIndex < 4) {
//         emit(state.copyWith(questionPageIndex: state.questionPageIndex + 1));
//         pageController.jumpToPage(state.questionPageIndex);
//       }
//     } else if (state.questionPageIndex == 3) {
//       log('THIS WAS SUCCESS REGISTER AND GO TO MAIN PAGE');
//     } else {
//       log('THIS WAS ADD UR CHILD AND GO TO MAIN PAGE');
//     }
//   }

//   void goBack() {
//     if (state.questionPageIndex == 0) {
//       log('back');
//     } else {
//       emit(state.copyWith(questionPageIndex: state.questionPageIndex - 1));
//       pageController.animateToPage(
//         state.questionPageIndex,
//         duration: Durations.medium2,
//         curve: Curves.linear,
//       );
//     }
//   }

//   void davamEtButton(BuildContext context) {
//     log('${state.isActiveButton}');

//     // state.isActiveButton
//     //     ? state.iDontKnow
//     //         ? Navigator.push(
//     //             context,
//     //             MaterialPageRoute(
//     //               builder: (context) => BlocProvider(
//     //                 create: (context) => QuestionsCubit(),
//     //                 child: CalculateBirth(),
//     //               ),
//     //             ),
//     //           )
//     //         : nextQuestion()
//     //     : null;
//   }

//   void iDontKnowToggle(bool v) {
//     emit(state.copyWith(iDontKnow: !v));
//   }

//   void showOptionsToggle() {
//     log('${state.showOptions}');
//     emit(state.copyWith(
//       showOptions: !state.showOptions,
//       showDays: false,
//       showCalendar: false,
//     ));
//   }

//   void showCalendarToggle() {
//     emit(state.copyWith(
//       showOptions: false,
//       showDays: false,
//       showCalendar: !state.showCalendar,
//     ));
//   }

//   void showDaysToggle() {
//     emit(state.copyWith(
//       showOptions: false,
//       showDays: !state.showDays,
//       showCalendar: false,
//     ));
//   }

//   void selectCalculateOption(int v) {
//     emit(state.copyWith(selectedCalculateOptionIndex: v));
//   }

//   void updateCalculateOptionName(String v) {
//     emit(state.copyWith(selectedCalculateOptionString: v));
//   }

//   void showWeekCount(BuildContext context, Widget widget) {
//     emit(state.copyWith(isShowUltrasoundWeeks: !state.isShowUltrasoundWeeks));
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return BlocProvider.value(
//           value: context.read<QuestionsCubit>(),
//           child: widget,
//         );
//       },
//     ).then((onValue) {
//       emit(state.copyWith(isShowUltrasoundWeeks: !state.isShowUltrasoundWeeks));
//     });
//   }

//   void updateUltrasoundWeekCount(int v) {
//     emit(state.copyWith(ultrasoundWeekCount: v));
//   }

//   void showDayCount(BuildContext context, Widget widget) {
//     emit(state.copyWith(isShowUltrasoundDays: !state.isShowUltrasoundDays));
//     showModalBottomSheet(
//       useRootNavigator: true,
//       context: context,
//       builder: (_) {
//         return BlocProvider.value(
//           value: context.read<QuestionsCubit>(),
//           child: widget,
//         );
//       },
//     ).then((onValue) {
//       emit(state.copyWith(isShowUltrasoundDays: !state.isShowUltrasoundDays));
//     });
//   }

//   void updateUltrasoundDaysCount(int v) {
//     emit(state.copyWith(ultrasoundDayCount: v));
//   }

//   void showBirthDateBottomSheet(BuildContext context, Widget widget) {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return BlocProvider.value(
//           value: context.read<QuestionsCubit>(),
//           child: widget,
//         );
//       },
//     ).then((onValue) {
//       updateBirthDate(onValue[0], onValue[1]);
//     });
//   }

//   void updateBirthDate(String v, DateTime initialTime) {
//     emit(state.copyWith(birthDateString: v, initialDateTime: initialTime));
//     log('${state.initialDateTime}');
//   }

//   void goToMainPage(context) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (_) => HomePage(),
//       ),
//       (route) => false,
//     );
//   }

//   @override
//   Future<void> close() {
//     pageController.dispose();
//     scrollController.dispose();
//     childHeightFocusNode.dispose();
//     childWeightFocusNode.dispose();
//     childNameFocusNode.dispose();
//     questionOneButtonNotifier.dispose();
//     return super.close();
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'package:burla_xatun/cubits/user_update/user_update_cubit.dart';
import 'package:burla_xatun/data/contractor/user_update_contractor.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:burla_xatun/data/models/remote/response/pregnancy_calculate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/remote/pregnancy_service.dart';
import '../../ui/screens/main/views/home_page/home/home_page.dart';
import '../../ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/first_day_of_last_period_component/first_day_of_last_period.dart';
import '../../ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/ivf_component/ivf.dart';
import '../../ui/screens/questions/widgets/calculate_birth_view/widgets/methods_views/ultrasound_component/ultrasound.dart';
import '../../ui/screens/add_child/add_your_child.dart';
import '../../ui/screens/questions/widgets/question_views/question_one.dart';
import '../../ui/screens/questions/widgets/question_views/question_three.dart';
import '../../ui/screens/questions/widgets/question_views/question_two.dart';
import '../../ui/screens/questions/widgets/question_views/register_success.dart';
import 'questions_state.dart';

enum CalculateStateStatus { initial, success, error, loading }

enum UserUpdateStatus { initial, success, error, loading, networkError }

class QuestionsCubit extends Cubit<QuestionsInitial> {
  QuestionsCubit({this.userUpdateContractor})
      : super(
          QuestionsInitial(
            currentQuestionOneOptionIndex: null,
            selectedCalculateOptionIndex: null,
            questionPageIndex: 0,
            focusedWeekIndex: 0,
            iDontKnow: false,
            showOptions: false,
            showDays: false,
            showCalendar: false,
            selectedCalculateOptionString: 'Hesablama üsulunu seçin...',
            selectedPeriodTimeString: 'Period muddetini secin...',
            birthDateString: 'Tarixi seçin...',
            selectedDay: DateTime.now(),
            isActiveButton: false,
            isFirstChild: null,
            initialDateTime: DateTime(DateTime.now().year - 10,
                DateTime.now().month, DateTime.now().day),
            ivfRadioValue: -1,
            ultrasoundDayCount: null,
            ultrasoundWeekCount: null,
            isShowUltrasoundDays: false,
            isShowUltrasoundWeeks: false,
            stateStatus: CalculateStateStatus.initial,
            userUpdateStatus: UserUpdateStatus.initial,
          ),
        );

  final UserUpdateContractor? userUpdateContractor;

  final pageController = PageController();
  final scrollController = ScrollController();
  final childNameFocusNode = FocusNode();
  final childWeightFocusNode = FocusNode();
  final childHeightFocusNode = FocusNode();
  final ValueNotifier<int?> questionOneButtonNotifier =
      ValueNotifier<int?>(null);
  final PregnancyService pregnancyService = PregnancyService();

  final List questionViews = [
    BlocProvider<UserUpdateCubit>(
      create: (context) => locator<UserUpdateCubit>(),
      child: QuestionOne(),
    ),
    BlocProvider<UserUpdateCubit>(
      create: (context) => locator<UserUpdateCubit>(),
      child: QuestionTwo(),
    ),
    BlocProvider<UserUpdateCubit>(
      create: (context) => locator<UserUpdateCubit>(),
      child: QuestionThree(),
    ),
    RegisterSuccess(),
    AddYourChild(),
  ];

  final List calculationOptions = [
    SizedBox.shrink(),
    FirstDayOfLastPeriod(),
    Ivf(),
    Ultrasound(),
  ];

  void stateLoading() {
    emit(state.copyWith(stateStatus: CalculateStateStatus.loading));
  }

  void stateInitial() {
    emit(state.copyWith(stateStatus: CalculateStateStatus.initial));
  }

  void stateError() {
    emit(state.copyWith(stateStatus: CalculateStateStatus.error));
    stateInitial();
  }

  late PregnancyCalculateModel calculatedData;

  Future<void> calculate() async {
    try {
      stateLoading();
      emit(state.copyWith(focusedWeekIndex: null));

      // Ensure we have a properly formatted date string (YYYY-MM-DD)
      String dateToSend = state.birthDateString;
      if (dateToSend == 'Dogum tarixini qeyd edinn') {
        dateToSend = DateFormat('yyyy-MM-dd').format(state.selectedDay);
      }

      log('Sending date: $dateToSend');

      calculatedData = await pregnancyService.calculatePregnancy(
        type: (state.selectedCalculateOptionIndex ?? 0),
        date: dateToSend,
        period: state.focusedWeekIndex,
        ivf: state.ivfRadioValue,
        week: state.ultrasoundWeekCount ?? 0,
        day: state.ultrasoundDayCount ?? 0,
      );
      emit(state.copyWith(
        focusedWeekIndex: calculatedData.data?.weeks ?? 0,
        stateStatus: CalculateStateStatus.success,
      ));
      await updateUser();
      stateInitial();
    } catch (e, s) {
      log('Stack Trace: $s');
      log('calculation error: $e');
      stateError();
      throw Exception('calculated error: $e');
    }
  }

  void scrollBottom() {
    if (!state.showDays) {
      showDaysToggle();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    } else {
      showDaysToggle();
    }
  }

  void scrollBottomCalendar() {
    if (!state.showCalendar) {
      showCalendarToggle();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    } else {
      showCalendarToggle();
    }
  }

  void updateRadioValue(int v) {
    emit(state.copyWith(ultrasoundRadioValue: v));
  }

  void updateIsActiveButton({int? v}) {
    switch (state.questionPageIndex) {
      case 0:
        if (questionOneButtonNotifier.value != null) {
          emit(state.copyWith(
            isActiveButton: true,
          ));
        }
        break;
      case 1:
        if (state.iDontKnow || state.focusedWeekIndex != 0) {
          emit(state.copyWith(isActiveButton: true));
        } else {
          emit(state.copyWith(isActiveButton: false));
        }
        break;
      case 2:
        if (state.isFirstChild != null) {
          emit(state.copyWith(isActiveButton: true));
        }
        break;
      default:
        log('default');
    }
  }

  void updateCurrentQuestionOneOption(int v) {
    emit(state.copyWith(currentQuestionOneOptionIndex: v));
  }

  void updateSelectedDay(DateTime v) {
    // Automatically update birthDateString when selected day changes
    String formattedDate = DateFormat('yyyy-MM-dd').format(v);
    emit(state.copyWith(
      selectedDay: v,
      birthDateString: formattedDate,
    ));
    log('Selected date updated: $formattedDate');
  }

  void updateQuestionThreeAnswer(bool v) {
    emit(state.copyWith(isFirstChild: v));
  }

  void updatePeriodTime(String v) {
    emit(state.copyWith(selectedPeriodTimeString: v));
  }

  void updateFocusedWeekIndex(int v) {
    emit(state.copyWith(focusedWeekIndex: v));
  }

  Future<void> updateUser({
    String? phoneNumber,
    bool? onboardingDone,
    bool? wantToBePregnant,
    bool? wantToSeePeriod,
    bool? isPregnant,
    String? pregnantWeek,
    bool? firstChild,
    String? activeLanguage,
    bool? enableNotifications,
  }) async {
    try {
      emit(state.copyWith(userUpdateStatus: UserUpdateStatus.loading));
      log("User Update Loading");

      final inseminationDate =
          DateTime.now().subtract(Duration(days: state.focusedWeekIndex * 7));
      final formattedInseminationDate =
          DateFormat('yyyy-MM-dd').format(inseminationDate);
      await userUpdateContractor!.updateUser(
        isPregnant: questionOneButtonNotifier.value == 0,
        inseminationDate: formattedInseminationDate,
        firstChild: state.isFirstChild,
        phoneNumber: phoneNumber,
        pregnantWeek: state.focusedWeekIndex.toString(),
      );
      emit(state.copyWith(userUpdateStatus: UserUpdateStatus.success));
    } on DioException catch (e, s) {
      emit(state.copyWith(userUpdateStatus: UserUpdateStatus.networkError));
      log("User Update Dio Exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(state.copyWith(userUpdateStatus: UserUpdateStatus.error));
      log("User Update Unknown Error: $e", stackTrace: s);
    }
  }

  Future<void> nextQuestion() async {
    if (state.questionPageIndex < 2) {
      if (state.questionPageIndex < 3 && questionOneButtonNotifier.value == 0) {
        emit(state.copyWith(
          questionPageIndex: state.questionPageIndex + 1,
        ));
        pageController.animateToPage(
          state.questionPageIndex,
          duration: Durations.medium2,
          curve: Curves.linear,
        );
        if (state.questionPageIndex == 1) {
          emit(state.copyWith(
            isActiveButton: state.focusedWeekIndex == 0 ? false : true,
          ));
        } else if (state.questionPageIndex == 2) {
          emit(state.copyWith(
            isActiveButton: state.isFirstChild == null ? false : true,
          ));
        }
      } else {
        // log('this is first questions request');
        await updateUser(isPregnant: false);
      }
    } else if (state.questionPageIndex == 2) {
      log('this question three request');
      await updateUser();
      if (state.isFirstChild!) {
        emit(state.copyWith(
          questionPageIndex: state.questionPageIndex + 1,
        ));
        pageController.jumpToPage(state.questionPageIndex);
      }
    }
  }

  void goBack() {
    emit(state.copyWith(
      iDontKnow: state.iDontKnow ? false : null,
      isActiveButton: true,
    ));
    if (state.questionPageIndex == 0) {
      log('back');
    } else {
      emit(state.copyWith(questionPageIndex: state.questionPageIndex - 1));
      pageController.animateToPage(
        state.questionPageIndex,
        duration: Durations.medium2,
        curve: Curves.linear,
      );
    }
  }

  void davamEtButton(BuildContext context) {
    log('${state.isActiveButton}');

    // state.isActiveButton
    //     ? state.iDontKnow
    //         ? Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => BlocProvider(
    //                 create: (context) => QuestionsCubit(),
    //                 child: CalculateBirth(),
    //               ),
    //             ),
    //           )
    //         : nextQuestion()
    //     : null;
  }

  void iDontKnowToggle(bool v) {
    emit(state.copyWith(
      focusedWeekIndex: v == false ? 0 : state.focusedWeekIndex,
      iDontKnow: !v,
    ));
  }

  void showOptionsToggle() {
    log('${state.showOptions}');
    emit(state.copyWith(
      showOptions: !state.showOptions,
      showDays: false,
      showCalendar: false,
    ));
  }

  void showCalendarToggle() {
    emit(state.copyWith(
      showOptions: false,
      showDays: false,
      showCalendar: !state.showCalendar,
    ));
  }

  void showDaysToggle() {
    emit(state.copyWith(
      showOptions: false,
      showDays: !state.showDays,
      showCalendar: false,
    ));
  }

  void selectCalculateOption(int v) {
    emit(state.copyWith(selectedCalculateOptionIndex: v));
  }

  void updateCalculateOptionName(String v) {
    emit(state.copyWith(selectedCalculateOptionString: v));
  }

  void showWeekCount(BuildContext context, Widget widget) {
    emit(state.copyWith(isShowUltrasoundWeeks: !state.isShowUltrasoundWeeks));
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<QuestionsCubit>(),
          child: widget,
        );
      },
    ).then((onValue) {
      emit(state.copyWith(isShowUltrasoundWeeks: !state.isShowUltrasoundWeeks));
    });
  }

  void updateUltrasoundWeekCount(int v) {
    emit(state.copyWith(ultrasoundWeekCount: v));
  }

  void showDayCount(BuildContext context, Widget widget) {
    emit(state.copyWith(isShowUltrasoundDays: !state.isShowUltrasoundDays));
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<QuestionsCubit>(),
          child: widget,
        );
      },
    ).then((onValue) {
      emit(state.copyWith(isShowUltrasoundDays: !state.isShowUltrasoundDays));
    });
  }

  void updateUltrasoundDaysCount(int v) {
    emit(state.copyWith(ultrasoundDayCount: v));
  }

  void showBirthDateBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<QuestionsCubit>(),
          child: widget,
        );
      },
    ).then((onValue) {
      if (onValue != null && onValue is List) {
        updateBirthDate(onValue[0], onValue[1]);
      }
    });
  }

  void updateBirthDate(String v, DateTime initialTime) {
    // Make sure that the date string is in the correct format
    String formattedDate = v;
    try {
      if (v != 'Dogum tarixini qeyd edinn') {
        // Try to parse the date to validate it
        DateTime parsedDate = DateTime.parse(v);
        // Format back to ensure proper format
        formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      } else {
        // If default placeholder text, use formatted current date
        formattedDate = DateFormat('yyyy-MM-dd').format(initialTime);
      }
    } catch (e) {
      // If date parsing fails, use the formatted initialTime
      formattedDate = DateFormat('yyyy-MM-dd').format(initialTime);
      log('Date parsing failed. Using default format: $formattedDate');
    }

    emit(state.copyWith(
        birthDateString: formattedDate, initialDateTime: initialTime));
    log('Updated birth date: $formattedDate');
  }

  void goToMainPage(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    scrollController.dispose();
    childHeightFocusNode.dispose();
    childWeightFocusNode.dispose();
    childNameFocusNode.dispose();
    questionOneButtonNotifier.dispose();
    return super.close();
  }
}
