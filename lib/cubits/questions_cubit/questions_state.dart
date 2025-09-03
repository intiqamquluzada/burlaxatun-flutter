// part of 'questions_cubit.dart';

// @immutable
// abstract class QuestionsState {}

import 'package:burla_xatun/cubits/questions_cubit/questions_cubit.dart';
import 'package:equatable/equatable.dart';

class QuestionsInitial extends Equatable {
  const QuestionsInitial({
    required this.currentQuestionOneOptionIndex,
    required this.selectedCalculateOptionIndex,
    required this.questionPageIndex,
    required this.focusedWeekIndex,
    required this.iDontKnow,
    required this.showOptions,
    required this.showDays,
    required this.showCalendar,
    required this.isActiveButton,
    required this.selectedCalculateOptionString,
    required this.selectedPeriodTimeString,
    required this.selectedDay,
    required this.isFirstChild,
    required this.birthDateString,
    required this.initialDateTime,
    required this.ivfRadioValue,
    required this.ultrasoundDayCount,
    required this.ultrasoundWeekCount,
    required this.isShowUltrasoundDays,
    required this.isShowUltrasoundWeeks,
    required this.stateStatus,
    required this.userUpdateStatus,
  });

  final int? currentQuestionOneOptionIndex;
  final int? selectedCalculateOptionIndex; 
  final int questionPageIndex;
  final int focusedWeekIndex;
  final int? ultrasoundWeekCount;
  final int? ultrasoundDayCount;
  final bool iDontKnow;
  final bool showOptions;
  final bool showDays;
  final bool showCalendar;
  final bool isActiveButton;
  final bool? isFirstChild;
  final bool isShowUltrasoundDays;
  final bool isShowUltrasoundWeeks;
  final String selectedCalculateOptionString;
  final String selectedPeriodTimeString;
  final String birthDateString;
  final int? ivfRadioValue;
  final DateTime selectedDay;
  final DateTime initialDateTime;
  final CalculateStateStatus stateStatus;
  final UserUpdateStatus userUpdateStatus;

  @override
  List<Object?> get props => [
        userUpdateStatus,
        currentQuestionOneOptionIndex,
        selectedCalculateOptionIndex,
        questionPageIndex,
        focusedWeekIndex,
        iDontKnow,
        showDays,
        showCalendar,
        showOptions,
        selectedCalculateOptionString,
        selectedPeriodTimeString,
        selectedDay,
        isActiveButton,
        isFirstChild,
        birthDateString,
        initialDateTime,
        ivfRadioValue,
        ultrasoundDayCount,
        ultrasoundWeekCount,
        isShowUltrasoundDays,
        isShowUltrasoundWeeks,
        stateStatus,
      ];

  QuestionsInitial copyWith({
    int? currentQuestionOneOptionIndex,
    int? selectedCalculateOptionIndex,
    int? questionPageIndex,
    int? focusedWeekIndex,
    int? ultrasoundWeekCount,
    int? ultrasoundDayCount,
    bool? iDontKnow,
    bool? showOptions,
    bool? showDays,
    bool? showCalendar,
    bool? isActiveButton,
    bool? isFirstChild,
    bool? isShowUltrasoundDays,
    bool? isShowUltrasoundWeeks,
    String? selectedCalculateOptionString,
    String? selectedPeriodTimeString,
    String? birthDateString,
    int? ultrasoundRadioValue,
    DateTime? selectedDay,
    DateTime? initialDateTime,
    CalculateStateStatus? stateStatus,
    UserUpdateStatus? userUpdateStatus,
  }) {
    return QuestionsInitial(
      currentQuestionOneOptionIndex: currentQuestionOneOptionIndex,
      selectedCalculateOptionIndex:
          selectedCalculateOptionIndex ?? this.selectedCalculateOptionIndex,
      questionPageIndex: questionPageIndex ?? this.questionPageIndex,
      focusedWeekIndex: focusedWeekIndex ?? this.focusedWeekIndex,
      iDontKnow: iDontKnow ?? this.iDontKnow,
      showOptions: showOptions ?? this.showOptions,
      showDays: showDays ?? this.showDays,
      showCalendar: showCalendar ?? this.showCalendar,
      selectedCalculateOptionString:
          selectedCalculateOptionString ?? this.selectedCalculateOptionString,
      selectedPeriodTimeString:
          selectedPeriodTimeString ?? this.selectedPeriodTimeString,
      selectedDay: selectedDay ?? this.selectedDay,
      isActiveButton: isActiveButton ?? this.isActiveButton,
      isFirstChild: isFirstChild ?? this.isFirstChild,
      birthDateString: birthDateString ?? this.birthDateString,
      initialDateTime: initialDateTime ?? this.initialDateTime,
      ivfRadioValue: ultrasoundRadioValue ?? this.ivfRadioValue,
      ultrasoundDayCount: ultrasoundDayCount ?? this.ultrasoundDayCount,
      ultrasoundWeekCount: ultrasoundWeekCount ?? this.ultrasoundWeekCount,
      isShowUltrasoundDays: isShowUltrasoundDays ?? this.isShowUltrasoundDays,
      isShowUltrasoundWeeks:
          isShowUltrasoundWeeks ?? this.isShowUltrasoundWeeks,
      stateStatus: stateStatus ?? this.stateStatus,
      userUpdateStatus: userUpdateStatus ?? this.userUpdateStatus,
    );
  }
}
