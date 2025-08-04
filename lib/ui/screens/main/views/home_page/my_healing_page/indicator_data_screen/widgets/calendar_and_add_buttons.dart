import 'package:burla_xatun/cubits/indicator/indicator_cubit.dart';
import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/my_healing_page/indicator_data_screen/widgets/add_new_indicator_dialog.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../widgets/global_text.dart';
import '../../widgets/add_button.dart';

class CalendarAndAddButtons extends StatelessWidget {
  const CalendarAndAddButtons({super.key, required this.indicatorName});

  final String indicatorName;

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            mainCubit.showCalendar(context);
          },
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/calendar_icon.svg'),
              SizedBox(width: 7),
              GlobalText(
                text: '3 dekabr 2024',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
        ),
        AddButton(
          onPressed: () {
            if (context.read<UserDataCubit>().currentBabyNotifier.value ==
                null) {
              return;
            }
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
