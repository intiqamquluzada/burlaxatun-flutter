import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import 'single_indicator_tile.dart';

class AllIndicators extends StatelessWidget {
  const AllIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return Column(
      children: [
        for (int i = 0; i < mainCubit.myHealingCardItems.length; i++)
          SingleIndicatorTile(
            item: mainCubit.myHealingCardItems[i], 
          ),
      ],
    );
  }
}
