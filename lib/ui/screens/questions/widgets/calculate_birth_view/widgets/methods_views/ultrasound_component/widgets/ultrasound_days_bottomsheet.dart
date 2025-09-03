import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../../cubits/questions_cubit/questions_cubit.dart';

class UltrasoundDaysBottomsheet extends StatefulWidget {
  const UltrasoundDaysBottomsheet({super.key});

  @override
  State<UltrasoundDaysBottomsheet> createState() =>
      _UltrasoundDaysBottomsheetState();
}

class _UltrasoundDaysBottomsheetState extends State<UltrasoundDaysBottomsheet> {
  late QuestionsCubit questionCubit;
  late FixedExtentScrollController _controller;
  late ValueNotifier<int> dayValue;
  @override
  void initState() {
    questionCubit = context.read<QuestionsCubit>();
    _controller = FixedExtentScrollController(
      initialItem: questionCubit.state.ultrasoundDayCount ?? 0,
    );
    dayValue = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questionCubit = context.read<QuestionsCubit>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Bağla',
                  style: TextStyle(
                    color: ColorConstants.primaryRedColor,
                  ),
                ),
              ),
              GlobalText(text: 'Gün sayını seçin'),
              TextButton(
                onPressed: () {
                  questionCubit.updateUltrasoundDaysCount(dayValue.value);
                  context.pop();
                },
                child: Text(
                  'Seçin',
                  style: TextStyle(
                    color: ColorConstants.primaryRedColor,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: CupertinoPicker(
              scrollController: _controller,
              itemExtent: 40,
              onSelectedItemChanged: (v) {
                dayValue.value = v;
              },
              children: [
                for (int i = 0; i < 7; i++)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$i'),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
