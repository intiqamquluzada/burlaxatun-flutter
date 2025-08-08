import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/pregnancy_progress/pregnancy_progress_cubit.dart';
import '../../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../widgets/global_text.dart';
import '../mixins/horizontal_calendar_mixin.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar>
    with HorizontalCalendarMixin {
  final ValueNotifier<int?> selectedDateIndex = ValueNotifier<int?>(null);

  void _initializeValueNotiferValue() {
    final currentDateIndex = allDates.indexOf(selectedDate);
    selectedDateIndex.value == null
        ? selectedDateIndex.value = currentDateIndex
        : null;
  }

  @override
  Widget build(BuildContext context) {
    ///* Get current date index for the selected date
    ///* This is used to highlight the selected date
    _initializeValueNotiferValue();
    final userDataCubit = context.read<UserDataCubit>();
    final inseminationDate = DateTime.parse(
        userDataCubit.state.response?.inseminationDate ??
            DateTime.now().toString());
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: ListView.builder(
          controller: scrollController,
          itemCount: allDates.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                ///* If the tapped date is not the current date, scroll to it
                final isPregnant =
                    userDataCubit.state.response!.isPregnant ?? false;

                final isBeforeInsemination =
                    allDates[i].isBefore(inseminationDate);
                final difference =
                    inseminationDate.difference(allDates[i]).inDays;
                final isNextWeek = difference % 7 == 0;

                if (!isPregnant ||
                    isBeforeInsemination ||
                    !isNextWeek ||
                    difference == 0) {
                  return;
                }
                selectedDateIndex.value = i;
                context
                    .read<PregnancyProgressCubit>()
                    .getPregnancyProgress(date: allDates[i]);

                // if (i == currentDateIndex) return;
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 43.33,
                    child: ValueListenableBuilder(
                      valueListenable: selectedDateIndex,
                      builder: (context, selectedBoxIndex, child) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: i == selectedBoxIndex
                                ? ColorConstants.primaryRedColor
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                GlobalText(
                                  text: getDayName(allDates[i]),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: i == selectedBoxIndex
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                GlobalText(
                                  text: allDates[i].day.toString(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: i == selectedBoxIndex
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
