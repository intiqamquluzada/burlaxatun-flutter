import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../data/models/local/main_page_box_model.dart';
import '../../../../../../../utils/routes/router.dart';
import 'home_box.dart';

class HomePageBoxes extends StatelessWidget {
  const HomePageBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainnCubit>();
    final boxItems = MainPageBoxModel.items;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: boxItems.length,
      itemBuilder: (_, i) {
        return HomeBox(
          boxName: boxItems[i].boxName,
          boxIcon: boxItems[i].boxIcon,
          onTap: () {
            if (i == 0) {
              mainCubit.changeView(1);
              // mainCubit.navigationShell.goBranch(1);
              navigatorKey.currentContext?.go('/daily_advices');
            } else {
              context.push(mainCubit.boxItems[i].route);
            }
          },
        );
      },
    );
  }
}
