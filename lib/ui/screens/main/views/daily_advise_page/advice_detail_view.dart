import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/recommend_by_day/recommend_by_day_cubit.dart';
import '../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/extensions/num_extensions.dart';
import '../../../../widgets/global_text.dart';
import '../home_page/ultrasound/widgets/scrollable_days_appbar.dart';
import 'widgets/advise_image.dart';
import 'widgets/advise_text.dart';
import 'widgets/advise_title.dart';

class AdvicePagee extends StatefulWidget {
  const AdvicePagee({super.key});

  @override
  State<AdvicePagee> createState() => _AdvicePageeState();
}

class _AdvicePageeState extends State<AdvicePagee> {
  late ValueNotifier<int?> dayValue;
  late final ScrollController scrollController;
  late RecommendByDayCubit recommendByDayCubit;
  @override
  void initState() {
    final day = context.read<UserDataCubit>().state.pregnantDays;
    dayValue = ValueNotifier<int?>(day ?? 0);
    scrollController = ScrollController();
    recommendByDayCubit = context.read<RecommendByDayCubit>();

    if (day == null || day == 0) return;

    recommendByDayCubit.getRecommendByDay(day: day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: ScrollableWeeksAppBar(
          count: 291,
          isShowBackButton: false,
          appbarName: 'Günlük Tövsiyələr',
          isDailyAdvice: true,
          weekOrDayValue: dayValue,
          scrollController: scrollController,
          onTap: (weekOrDay) {
            dayValue.value = weekOrDay;
            if (weekOrDay == 0) return;
            recommendByDayCubit.getRecommendByDay(day: weekOrDay);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: dayValue,
              builder: (context, value, child) {
                return Visibility(
                  visible: dayValue.value != 0,
                  replacement: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: GlobalText(
                      textAlign: TextAlign.center,
                      text:
                          'İstənilən günün məlumatına baxmaq üçün həmin günün üzərinə toxunun',
                    ),
                  ),
                  child: BlocBuilder<RecommendByDayCubit, RecommendByDayState>(
                    builder: (context, state) {
                      if (state.recommendByDayStatus ==
                          RecommendByDayStatus.loading) {
                        return CircularProgressIndicator.adaptive();
                      } else if (state.recommendByDayStatus ==
                          RecommendByDayStatus.error) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: GlobalText(
                            textAlign: TextAlign.center,
                            text: 'Bu gün üçün məlumatı tapılmadı',
                          ),
                        );
                      }
                      if (state.recommendByDayStatus ==
                          RecommendByDayStatus.success) {
                        final recommendationByDay = state.recommendationByDay;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdviseImage(
                              imageUrl: recommendationByDay?.image ??
                                  'assets/images/default_image.png',
                            ),
                            12.h,
                            AdviseTitle(
                                adviceTitle: recommendationByDay?.name ?? ''),
                            10.h,
                            AdviseText(
                                adviceText: recommendationByDay?.text ?? ''),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
    // BlocBuilder<DailyRecDetailCubit, DailyRecDetailState>(
    //   builder: (_, detailState) {
    //     if (detailState.status == DailyRecDetailStatus.loading) {
    //       return const Scaffold(
    //         body: Center(child: CustomCircularProgressIndicator()),
    //       );
    //     } else if (detailState.status == DailyRecDetailStatus.failure) {
    //       return const Center(
    //         child: Text('Xəta'),
    //       );
    //     } else if (detailState.status == DailyRecDetailStatus.success) {
    //       final data = detailState.response;

    //       return
    //     } else {
    //       return const SizedBox.shrink();
    //     }
    //   },
    // );
  }
}
