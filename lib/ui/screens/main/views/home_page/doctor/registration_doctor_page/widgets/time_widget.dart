import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/doctor_reservation/doctor_reservation_cubit.dart';
import '../../../../../../../../cubits/doctors_detail/doctors_detail_cubit.dart';
import '../../../../../../../../utils/helper/get_available_time.dart';
import '../../../../../../../widgets/global_text.dart';
import 'time_box.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorReservationCubit doctorReservationCubit =
        context.read<DoctorReservationCubit>();

    ValueNotifier<int?> selectedTimeId = ValueNotifier<int?>(null);

    return SizedBox(
      height: 52,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF9FAFB),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
          buildWhen: (previous, current) {
            return previous.availableTimesStatus !=
                current.availableTimesStatus;
          },
          builder: (context, state) {
            selectedTimeId.value = null;
            if (state.availableTimesStatus == AvailableTimesStatus.loading) {
              return Center(child: GlobalText(text: 'Yüklənir...'));
            } else if (state.availableTimesStatus ==
                AvailableTimesStatus.error) {
              return Center(child: GlobalText(text: 'Xəta baş verdi'));
            } else if (state.availableTimesStatus ==
                AvailableTimesStatus.success) {
              final availableTimes = state.availableTimes;
              return Visibility(
                visible: availableTimes!.isNotEmpty,
                replacement:
                    Center(child: GlobalText(text: 'Gün üçün boş vaxt yoxdur')),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(27)),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: availableTimes.length,
                      itemBuilder: (_, i) {
                        final time = availableTimes[i];
                        return GestureDetector(
                          onTap: () {
                            doctorReservationCubit.saveTime(time.id!);
                            selectedTimeId.value = time.id;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: selectedTimeId,
                            builder: (context, value, child) {
                              return TimeBox(
                                time: GetAvailableTime.getTime(
                                  time.start.toString(),
                                ),
                                isSelected: value == time.id,
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, i) => SizedBox(width: 4),
                    ),
                  ),
                ),
              );
            }
            return Center(child: GlobalText(text: 'Gün seçin'));
          },
        ),
      ),
    );
  }
}
