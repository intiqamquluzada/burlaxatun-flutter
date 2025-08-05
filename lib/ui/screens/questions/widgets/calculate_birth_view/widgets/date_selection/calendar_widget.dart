// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../../../../../../../cubits/questions_cubit/questions_cubit.dart';
// import '../../../../../../../utils/constants/color_constants.dart';

// class CalendarWidget extends StatelessWidget {
//   const CalendarWidget({
//     super.key,
//     required this.focusedDay,
//   });

//   final DateTime focusedDay;

//   @override
//   Widget build(BuildContext context) {
//     final questionsCubit = context.read<QuestionsCubit>();
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(36)),
//         border: Border.all(color: Colors.black38),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: TableCalendar(
//           rowHeight: 48,
//           focusedDay: focusedDay,
//           firstDay: DateTime.utc(2010, 10, 16),
//           lastDay: DateTime.utc(2030, 3, 14),
//           // selectedDayPredicate: (day) {
//           // return isSameDay(questionsCubit.selectedDay, day);
//           // },
//           onDaySelected: (selectedDay, focusedDay) {
//             questionsCubit.updateSelectedDay(selectedDay);
//           },
//           headerStyle: HeaderStyle(
//             titleCentered: true,
//             formatButtonVisible: false,
//             titleTextStyle: GoogleFonts.poppins(
//               fontSize: 14,
//               color: Color(0xffEC407A),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           calendarStyle: CalendarStyle(
//             cellPadding: EdgeInsets.zero,
//             outsideDaysVisible: false,
//             selectedDecoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: ColorConstants.primaryRedColor,
//             ),
//             selectedTextStyle: GoogleFonts.poppins(
//               fontSize: 20,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//             todayTextStyle: GoogleFonts.poppins(
//               fontSize: 20,
//               color: Color(0xff667085),
//               fontWeight: FontWeight.w400,
//             ),
//             weekendTextStyle: GoogleFonts.poppins(
//               fontSize: 20,
//               color: Color(0xff667085),
//               fontWeight: FontWeight.w400,
//             ),
//             defaultTextStyle: GoogleFonts.poppins(
//               fontSize: 20,
//               color: Color(0xff667085),
//               fontWeight: FontWeight.w400,
//             ),
//             cellMargin: EdgeInsets.all(6),
//           ),
//           daysOfWeekStyle: DaysOfWeekStyle(
//             weekdayStyle: GoogleFonts.poppins(
//               fontSize: 13,
//               color: Color(0xffD0D5DD),
//               fontWeight: FontWeight.w600,
//             ),
//             weekendStyle: GoogleFonts.poppins(
//               fontSize: 13,
//               color: Color(0xffD0D5DD),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../../../cubits/questions_cubit/questions_state.dart';
import '../../../../../../../utils/constants/color_constants.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    required this.focusedDay,
  });

  final DateTime focusedDay;

  @override
  Widget build(BuildContext context) { 
    final questionsCubit = context.read<QuestionsCubit>();

    return BlocBuilder<QuestionsCubit, QuestionsInitial>(
      buildWhen: (previous, current) =>
          previous.selectedDay != current.selectedDay,
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            border: Border.all(color: Color(0xffEAEAEA)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TableCalendar(
              rowHeight: 48,
              focusedDay: state
                  .selectedDay, // Use state.selectedDay instead of focusedDay parameter
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) {
                // Enable the predicate to highlight selected day
                return isSameDay(state.selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                // Update both the selected day and focused day
                questionsCubit.updateSelectedDay(selectedDay);
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Color(0xffEC407A),
                  fontWeight: FontWeight.w500,
                ),
              ),
              calendarStyle: CalendarStyle(
                cellPadding: EdgeInsets.zero,
                outsideDaysVisible: false,
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.primaryRedColor,
                ),
                selectedTextStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.primaryRedColor.withOpacity(0.2),
                ),
                todayTextStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xff667085),
                  fontWeight: FontWeight.w400,
                ),
                weekendTextStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xff667085),
                  fontWeight: FontWeight.w400,
                ),
                defaultTextStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xff667085),
                  fontWeight: FontWeight.w400,
                ),
                cellMargin: EdgeInsets.all(6),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Color(0xffD0D5DD),
                  fontWeight: FontWeight.w600,
                ),
                weekendStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Color(0xffD0D5DD),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
