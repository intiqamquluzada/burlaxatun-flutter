import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../widgets/select_option.dart';
import '../../widgets/single_option.dart';

class CountriesAndSelectedsBox extends StatelessWidget {
  const CountriesAndSelectedsBox({
    super.key,
    required this.countriesOrSelectedNamesScreen,
    required this.pageController,
  });

  final ValueNotifier<int> countriesOrSelectedNamesScreen;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: countriesOrSelectedNamesScreen,
      builder: (_, value, child) {
        return SelectOption(
          optionOne: BlocBuilder<MainCubit, MainInitial>(
            buildWhen: (previous, current) {
              return previous.nameViewOptions != current.nameViewOptions;
            },
            builder: (context, state) {
              return SingleOption(
                boxTitle: 'Ölkələr',
                boxColors: countriesOrSelectedNamesScreen.value == 0
                    ? Colors.white
                    : Colors.transparent,
                onTap: () {
                  countriesOrSelectedNamesScreen.value = 0;
                  pageController.jumpToPage(0);
                },
              );
            },
          ),
          optionTwo: BlocBuilder<MainCubit, MainInitial>(
            buildWhen: (previous, current) {
              return previous.nameViewOptions != current.nameViewOptions;
            },
            builder: (context, state) {
              return SingleOption(
                boxTitle: 'Seçilmişlər',
                boxColors: countriesOrSelectedNamesScreen.value == 1
                    ? Colors.white
                    : Colors.transparent,
                onTap: () {
                  countriesOrSelectedNamesScreen.value = 1;
                  pageController.jumpToPage(1);
                },
              );
            },
          ),
        );
      },
    );
  }
}
