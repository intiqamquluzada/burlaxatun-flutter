import 'package:flutter/material.dart';

import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import 'widgets/home_page_appbar.dart';
import 'widgets/home_page_boxes.dart';
import 'widgets/home_page_daily_advise.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/pregnancy_guide.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final mainCubit = context.read<MainnCubit>();
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
                    // BabyInformation(),
                    HomePageDailyAdvise(),
                    PregnancyGuide(),
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
