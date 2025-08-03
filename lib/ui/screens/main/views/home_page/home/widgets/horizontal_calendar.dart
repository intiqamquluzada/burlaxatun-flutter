import 'package:burla_xatun/ui/screens/main/views/home_page/home/mixins/horizontal_calendar_mixin.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../widgets/global_text.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar>
    with HorizontalCalendarMixin {
  @override
  Widget build(BuildContext context) {
    ///* Get current date index for the selected date
    ///* This is used to highlight the selected date
    final currentDateIndex = allDates.indexOf(selectedDate);

    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: ListView.builder(
          controller: scrollController,
          itemCount: allDates.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                ///* If the tapped date is not the current date, scroll to it
                if (i == currentDateIndex) return;
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 43.33,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: i == currentDateIndex
                            ? ColorConstants.primaryRedColor
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            GlobalText(
                              text: getDayName(allDates[i]),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: i == currentDateIndex
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            GlobalText(
                              text: allDates[i].day.toString(),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: i == currentDateIndex
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
