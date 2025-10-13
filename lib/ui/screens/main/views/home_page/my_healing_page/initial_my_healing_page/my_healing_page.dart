import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../widgets/global_appbar.dart';
import 'widgets/all_indicators.dart';

class MyHealingPage extends StatelessWidget {
  const MyHealingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        babyName: ValueListenableBuilder(
          valueListenable: context.read<UserDataCubit>().currentBabyNotifier,
          builder: (context, value, child) {
            return GlobalText(
              text: value?.name ?? 'Öz göstəricilərim',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xff344054),
            );
          },
        ),
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AllIndicators(),
        ),
      ),
    );
  }
}
