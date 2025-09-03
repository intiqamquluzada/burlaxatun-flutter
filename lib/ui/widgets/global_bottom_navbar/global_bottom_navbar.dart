import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/main_cubit/mainn_cubit.dart';
import 'bottom_navbar_item.dart';

class GlobalBottomNavbar extends StatelessWidget {
  const GlobalBottomNavbar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    final mq = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 93,
      child: Row(
        // spacing: 21,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < mainCubit.views.length; i++)
            SizedBox(
              width: mq / 4,
              child: BottomNavbarItem(
                i: i,
                navigationShell: navigationShell,
              ),
            ),
        ],
      ),
    );
  }
}
