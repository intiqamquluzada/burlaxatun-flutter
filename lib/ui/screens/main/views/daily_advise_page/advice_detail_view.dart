import 'package:burla_xatun/ui/screens/main/views/daily_advise_page/widgets/advise_image.dart';
import 'package:burla_xatun/ui/screens/main/views/daily_advise_page/widgets/advise_text.dart';
import 'package:burla_xatun/ui/screens/main/views/daily_advise_page/widgets/advise_title.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/daily_rec_detail/daily_rec_detail_cubit.dart';
import '../../../../widgets/custom_circular_progress_indicator.dart';
import '../home_page/widgets/scrollable_days_appbar.dart';

class AdviceDetailView extends StatefulWidget {
  const AdviceDetailView({super.key});

  @override
  State<AdviceDetailView> createState() => _AdviceDetailViewState();
}

class _AdviceDetailViewState extends State<AdviceDetailView> {
  late final ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyRecDetailCubit, DailyRecDetailState>(
      builder: (_, detailState) {
        if (detailState.status == DailyRecDetailStatus.loading) {
          return const Scaffold(
            body: Center(child: CustomCircularProgressIndicator()),
          );
        } else if (detailState.status == DailyRecDetailStatus.failure) {
          return const Center(
            child: Text('Xəta'),
          );
        } else if (detailState.status == DailyRecDetailStatus.success) {
          final data = detailState.response;

          return Scaffold(
            backgroundColor: ColorConstants.scaffoldColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(175),
              child: ScrollableDaysAppbar(
                count: 270,
                isShowBackButton: false,
                appbarName: 'Günlük Tövsiyələr',
                week: data?.day ?? 1,
                weekValue: ValueNotifier<int?>(data?.day),
                scrollController: scrollController,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdviseImage(
                      imageUrl:
                          data?.image ?? 'assets/images/default_image.png',
                    ),
                    12.h,
                    AdviseTitle(adviceTitle: data?.name ?? ''),
                    10.h,
                    AdviseText(adviceText: data?.text ?? ''),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
