import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import 'widgets/baby_information.dart';
import 'widgets/current_baby_info.dart';
import 'widgets/home_page_appbar.dart';
import 'widgets/home_page_boxes.dart';
import 'widgets/home_page_daily_advise.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/pregnancy_guide.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    // required this.shellContext,
  });

  // final BuildContext shellContext;

  @override
  Widget build(BuildContext context) {
    final userDataCubit = context.read<UserDataCubit>();
    final user = userDataCubit.state.response;
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: HomePageAppbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              24.h,
              HorizontalCalendar(),
              24.h,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 24,
                  children: [
                    BlocBuilder<UserDataCubit, UserDataState>(
                      builder: (context, state) {
                        if (state.status == UserDataStatus.loading) {
                          return CircularProgressIndicator.adaptive();
                        } else if (state.status == UserDataStatus.success) {
                          return ValueListenableBuilder(
                            valueListenable: userDataCubit.currentBabyNotifier,
                            builder: (context, currentBaby, child) {
                              // log('user is null: ${user == null}');
                              final isPregnant =
                                  state.response?.isPregnant ?? false;
                              return Visibility(
                                visible: currentBaby == null && isPregnant,
                                replacement: currentBaby == null
                                    ? SizedBox.shrink()
                                    : CurrentBabyInfo(),
                                child: BabyInformation(),
                              );
                            },
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    HomePageDailyAdvise(),
                    BlocBuilder<UserDataCubit, UserDataState>(
                      builder: (context, state) {
                        if (state.status == UserDataStatus.loading) {
                          return CircularProgressIndicator.adaptive();
                        } else if (state.status == UserDataStatus.success) {
                          final week = state.response?.pregnantWeek ?? '0';
                          return Visibility(
                            visible: week != '0',
                            child: PregnancyGuide(pregnantWeek: week),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    HomePageBoxes(),
                  ],
                ),
              ),
              24.h,
            ],
          ),
        ),
      ),
    );
  }
}
