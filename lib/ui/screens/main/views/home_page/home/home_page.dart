import 'package:burla_xatun/cubits/main_cubit/mainn_cubit.dart';
import 'package:burla_xatun/utils/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final mainCubit = context.read<MainCubit>();
    // final user = userDataCubit.state.response;
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: HomePageAppbar(),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state.status == UserDataStatus.loading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state.status == UserDataStatus.success) {
                final week = state.response?.pregnantWeek ?? '0';
                final isPregnant = state.response?.isPregnant ?? false;
                final days = state.pregnantDays;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            24.h,
                            HorizontalCalendar(),
                            24.h,
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ValueListenableBuilder(
                            valueListenable: userDataCubit.currentBabyNotifier,
                            builder: (context, currentBaby, child) {
                              // log('user is null: ${user == null}');

                              return Visibility(
                                visible: currentBaby == null && isPregnant,
                                replacement: currentBaby == null
                                    ? SizedBox.shrink()
                                    : CurrentBabyInfo(),
                                child: BabyInformation(),
                              );
                            },
                          ),
                        ),
                        24.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Visibility(
                            visible: isPregnant,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: days != null,
                                  child: GestureDetector(
                                    onTap: () {
                                      mainCubit.changeView(1);
                                      navigatorKey.currentContext
                                          ?.go('/daily_advices');
                                    },
                                    child: HomePageDailyAdvise(),
                                  ),
                                ),
                                24.h,
                                Visibility(
                                  visible: week != '0',
                                  child: PregnancyGuide(pregnantWeek: week),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // BlocBuilder<UserDataCubit, UserDataState>(
                        //   builder: (context, state) {
                        //     if (state.status == UserDataStatus.loading) {
                        //       return CircularProgressIndicator.adaptive();
                        //     } else if (state.status ==
                        //         UserDataStatus.success) {
                        //       return ValueListenableBuilder(
                        //         valueListenable:
                        //             userDataCubit.currentBabyNotifier,
                        //         builder: (context, currentBaby, child) {
                        //           // log('user is null: ${user == null}');
                        //           final isPregnant =
                        //               state.response?.isPregnant ?? false;
                        //           return Visibility(
                        //             visible:
                        //                 currentBaby == null && isPregnant,
                        //             replacement: currentBaby == null
                        //                 ? SizedBox.shrink()
                        //                 : CurrentBabyInfo(),
                        //             child: BabyInformation(),
                        //           );
                        //         },
                        //       );
                        //     }
                        //     return SizedBox.shrink();
                        //   },
                        // ),

                        // BlocBuilder<UserDataCubit, UserDataState>(
                        //   builder: (context, state) {
                        //     if (state.status == UserDataStatus.loading) {
                        //       return CircularProgressIndicator.adaptive();
                        //     } else if (state.status ==
                        //         UserDataStatus.success) {
                        //       return Visibility(
                        //         visible: week != '0',
                        //         child: PregnancyGuide(pregnantWeek: week),
                        //       );
                        //     }
                        //     return SizedBox.shrink();
                        //   },
                        // ),
                        24.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: HomePageBoxes(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
