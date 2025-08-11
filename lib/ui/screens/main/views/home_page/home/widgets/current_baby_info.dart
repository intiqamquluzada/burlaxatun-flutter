import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import 'baby_info_box.dart';

class CurrentBabyInfo extends StatelessWidget {
  const CurrentBabyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final currentBaby = context.read<UserDataCubit>().currentBabyNotifier;
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            42.h,
            ValueListenableBuilder(
              valueListenable: currentBaby,
              builder: (context, value, child) {
                // final indicator = value?.indicators?.first;
                return Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 17,
                  children: [
                    Expanded(
                      child: BabyInfoBox(
                        boxName: 'Övladın boyu',
                        boxData: '${value?.height} sm',
                      ),
                    ),
                    Expanded(
                      child: BabyInfoBox(
                        boxName: 'Övladın çəkisi',
                        boxData: '${value?.weight} kq',
                      ),
                    ),
                  ],
                );
              },
            ),
            20.h,
            // MoreDetailsButton(),
            // 42.h,
          ],
        ),
      ),
    );
  }
}
