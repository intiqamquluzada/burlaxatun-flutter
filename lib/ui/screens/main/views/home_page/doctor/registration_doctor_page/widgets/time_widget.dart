import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/doctor_reservation/doctor_reservation_cubit.dart';
import 'time_box.dart';

class TimeWidget extends StatelessWidget {
  final List<String> timeList;

  const TimeWidget({super.key, required this.timeList});

  @override
  Widget build(BuildContext context) {
    final DoctorReservationCubit doctorReservationCubit =
        context.read<DoctorReservationCubit>();
    ValueNotifier<String?> selectedTimeValue = ValueNotifier<String?>(null);
    return SizedBox(
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF9FAFB),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(27)),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: timeList.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    doctorReservationCubit.saveTime(timeList[i]);
                    selectedTimeValue.value = timeList[i];
                  },
                  child: ValueListenableBuilder(
                    valueListenable: selectedTimeValue,
                    builder: (context, value, child) {
                      return TimeBox(
                        time: timeList[i],
                        isSelected: value == null
                            ? false
                            : timeList.indexOf(value) == i,
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (_, i) => SizedBox(width: 4),
            ),
          ),
        ),
      ),
    );
  }
}
