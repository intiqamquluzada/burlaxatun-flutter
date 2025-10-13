import 'dart:developer';

import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/indicator/indicator_cubit.dart';
import '../../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../../data/models/remote/response/user_data_model.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import 'widgets/calendar_and_add_buttons.dart';
import 'widgets/chart_widget.dart';
import 'widgets/time_intervals_widget.dart';

class IndicatorDataScreen extends StatefulWidget {
  const IndicatorDataScreen({
    super.key,
    required this.indicatorName,
    required this.indicatorAppBarTitle,
  });

  final String indicatorName;
  final String indicatorAppBarTitle;

  @override
  State<IndicatorDataScreen> createState() => _IndicatorDataScreenState();
}

class _IndicatorDataScreenState extends State<IndicatorDataScreen> {
  late IndicatorCubit indicatorCubit;
  late ValueNotifier<Baby?> currentBabyNotifier;
  late ValueNotifier<int?> selectedInterval;
  late VoidCallback babyNotifierListener;

  @override
  void initState() {
    super.initState();
    selectedInterval = ValueNotifier<int>(2);
    indicatorCubit = context.read<IndicatorCubit>();
    currentBabyNotifier = context.read<UserDataCubit>().currentBabyNotifier;

    log('current baby null: ${currentBabyNotifier.value == null}');

    indicatorCubit.getIndicatorDatas(
      babyId: currentBabyNotifier.value?.id,
      indicatorName: widget.indicatorName,
      range: 'monthly',
    );

    babyNotifierListener = () {
      log('changed baby');
      selectedInterval.value = 2;
      indicatorCubit.getIndicatorDatas(
        babyId: currentBabyNotifier.value?.id,
        indicatorName: widget.indicatorName,
        range: 'monthly',
      );
    };

    currentBabyNotifier.addListener(babyNotifierListener);
  }

  @override
  void dispose() {
    currentBabyNotifier.removeListener(babyNotifierListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: widget.indicatorAppBarTitle,
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TimeIntervalsWidget(
              indicatorName: widget.indicatorName,
              currentBabyNotifier: currentBabyNotifier,
              selectedInterval: selectedInterval,
            ),
            18.h,
            DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: ValueListenableBuilder(
                valueListenable: currentBabyNotifier,
                builder: (context, value, child) {
                  return BlocBuilder<IndicatorCubit, IndicatorState>(
                    buildWhen: (previous, current) {
                      return previous.indicatorList == current.indicatorList ||
                          previous.indicatorStatus != current.indicatorStatus;
                    },
                    builder: (context, state) {
                      log('baby data status: ${state.indicatorStatus}');
                      if (state.indicatorStatus == IndicatorStatus.loading) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 112),
                          child: Center(
                              child: CircularProgressIndicator.adaptive()),
                        );
                      } else if (state.indicatorStatus ==
                          IndicatorStatus.error) {
                        return Center(child: Text('Xəta baş verdi'));
                      }
                      if (state.indicatorStatus == IndicatorStatus.success) {
                        log('Indicator datas: ${state.indicatorList?.length}');
                        return state.indicatorList!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ChartWidget(
                                  indicatorDataList: state.indicatorList ?? [],
                                ),
                              )
                            : SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: GlobalText(
                                    color: ColorConstants.customBlue,
                                    textAlign: TextAlign.center,
                                    text: 'Məlumat yoxdur',
                                  ),
                                ),
                              );
                      }
                      return SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
            27.h,
            CalendarAndAddButtons(
              indicatorName: widget.indicatorName,
            ),
          ],
        ),
      ),
    );
  }
}
