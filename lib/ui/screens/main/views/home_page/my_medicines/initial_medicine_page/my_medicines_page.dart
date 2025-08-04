import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../widgets/global_appbar.dart';
import '../../my_healing_page/widgets/add_button.dart';
import 'widgets/medicine_list.dart';

class MyMedicinesPage extends StatelessWidget {
  const MyMedicinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Dərmanlarım',
        onLeadingTap: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: const [
                MedicineList(),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 5,
              child: AddButton(
                onPressed: () {
                  log('show add medicine message');
                  mainCubit.showAddMedicine(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
