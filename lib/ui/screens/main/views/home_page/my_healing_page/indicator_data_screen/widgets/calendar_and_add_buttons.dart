import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/indicator/indicator_cubit.dart';
import '../../../../../../../../utils/di/locator.dart';
import '../../widgets/add_button.dart';
import 'add_new_indicator_dialog.dart';

class CalendarAndAddButtons extends StatelessWidget {
  const CalendarAndAddButtons({
    super.key,
    required this.indicatorName,
  });

  final String indicatorName;

  @override
  Widget build(BuildContext context) {
    // final mainCubit = context.read<MainCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     mainCubit.showCalendar(context);
        //   },
        //   child: Row(
        //     children: [
        //       SvgPicture.asset('assets/icons/calendar_icon.svg'),
        //       SizedBox(width: 7),
        //       GlobalText(
        //         text: '3 dekabr 2024',
        //         fontSize: 14,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.black,
        //       ),
        //     ],
        //   ),
        // ),
        Spacer(),
        AddButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: locator<IndicatorCubit>(),
                  child: AddNewIndicatorDialog(indicatorName: indicatorName),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
