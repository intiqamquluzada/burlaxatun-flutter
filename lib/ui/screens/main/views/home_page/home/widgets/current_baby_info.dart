import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/home/widgets/baby_info_box.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/home/widgets/more_details_button.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 17,
                  children: [
                    BabyInfoBox(
                      boxName: 'Baby height',
                      boxData: '${value?.height} sm',
                    ),
                    BabyInfoBox(
                      boxName: 'Baby weight',
                      boxData: '${value?.weight} kq',
                    ),
                  ],
                );
              },
            ),
            20.h,
            MoreDetailsButton(),
            42.h,
          ],
        ),
      ),
    );
  }
}
