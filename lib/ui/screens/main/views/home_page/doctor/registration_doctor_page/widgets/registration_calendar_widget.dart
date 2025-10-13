import 'package:burla_xatun/cubits/doctor_reservation/doctor_reservation_cubit.dart';
import 'package:burla_xatun/cubits/doctors_detail/doctors_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../../utils/constants/color_constants.dart';

class RegistrationCalendarWidget extends StatelessWidget {
  const RegistrationCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorReservationCubit = context.read<DoctorReservationCubit>();

    final doctorDetailCubit = context.read<DoctorDetailCubit>();

    final ValueNotifier<DateTime> selectedDayNotifier =
        ValueNotifier<DateTime>(DateTime.now());
    return ValueListenableBuilder(
      valueListenable: selectedDayNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: TableCalendar(
            locale: 'Az',
            startingDayOfWeek: StartingDayOfWeek.monday,
            rowHeight: 52,
            focusedDay: value,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
            selectedDayPredicate: (day) {
              return isSameDay(value, day);
            },
            onDaySelected: (selectedDay, focusedDay) async {
              selectedDayNotifier.value = focusedDay;
              final formattedDay =
                  DateFormat('yyyy-MM-dd').format(selectedDayNotifier.value);
              // doctorReservationCubit.saveDate(formattedDay);
              doctorReservationCubit.saveTime(0);

              await doctorDetailCubit.getAvailableTimes(date: formattedDay);
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
        );
      },
    );
  }
}
