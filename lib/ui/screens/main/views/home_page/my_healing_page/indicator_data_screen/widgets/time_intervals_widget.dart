import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/indicator/indicator_cubit.dart';
import '../../../../../../../../data/models/local/indicator_time_interval_items_model.dart';
import '../../../../../../../../data/models/remote/response/user_data_model.dart';
import 'single_time_interval_box.dart';

class TimeIntervalsWidget extends StatelessWidget {
  const TimeIntervalsWidget({
    super.key,
    required this.indicatorName,
    required this.currentBabyNotifier,
    required this.selectedInterval,
  });

  final String indicatorName;
  final ValueNotifier<Baby?> currentBabyNotifier;
  final ValueNotifier<int?> selectedInterval;

  @override
  Widget build(BuildContext context) {
    final timeIntervalItems = IndicatorTimeIntervalItemsModel.items;
    // final ValueNotifier<int> selectedInterval = ValueNotifier<int>(2);
    final IndicatorCubit indicatorCubit = context.read<IndicatorCubit>();
    return Row(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: timeIntervalItems.length,
            itemBuilder: (_, i) {
              return ValueListenableBuilder(
                valueListenable: selectedInterval,
                builder: (_, value, child) {
                  return ValueListenableBuilder(
                    valueListenable: currentBabyNotifier,
                    builder: (context, currentBaby, child) {
                      return GestureDetector(
                        onTap: () {
                          selectedInterval.value = i;
                          indicatorCubit.getIndicatorDatas(
                            babyId: currentBaby?.id,
                            indicatorName: indicatorName,
                            range: timeIntervalItems[i].range,
                          );
                        },
                        child: SingleTimeIntervalBox(
                          interval: timeIntervalItems[i].interval,
                          isSelected: value == i,
                        ),
                      );
                    },
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 13);
            },
          ),
        ),
      ],
    );
    // Row(
    //   spacing: 12,
    //   children: [
    //     SingleTimeIntervalBox(interval: 'Gun'),
    //     SingleTimeIntervalBox(interval: 'Hefte'),
    //     SingleTimeIntervalBox(interval: 'Ay'),
    //     SingleTimeIntervalBox(interval: 'İl'),
    //   ],
    // );
  }
}
