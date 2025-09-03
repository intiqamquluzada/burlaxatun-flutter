import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../cubits/main_cubit/mainn_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return BlocBuilder<MainCubit, MainInitial>(
      buildWhen: (previous, current) {
        return previous.viewName != current.viewName;
      },
      builder: (context, state) {
        return mainCubit.homePageViews[state.viewName]!;
      },
    );
  }
}
