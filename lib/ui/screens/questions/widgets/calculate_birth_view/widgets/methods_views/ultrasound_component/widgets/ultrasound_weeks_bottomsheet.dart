import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../../cubits/questions_cubit/questions_cubit.dart';

class UltrasoundWeeksBottomsheet extends StatefulWidget {
  const UltrasoundWeeksBottomsheet({super.key});

  @override
  State<UltrasoundWeeksBottomsheet> createState() =>
      _UltrasoundWeeksBottomsheetState();
}

class _UltrasoundWeeksBottomsheetState
    extends State<UltrasoundWeeksBottomsheet> {
  late QuestionsCubit questionCubit;
  late FixedExtentScrollController _controller;
  late ValueNotifier<int> weekValue;
  @override
  void initState() {
    questionCubit = context.read<QuestionsCubit>();
    _controller = FixedExtentScrollController(
      initialItem: questionCubit.state.ultrasoundWeekCount ?? 0,
    );
    weekValue = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              GlobalText(text: 'Həftə sayını seçin'),
              TextButton(
                onPressed: () {
                  questionCubit.updateUltrasoundWeekCount(weekValue.value);
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
                weekValue.value = v;
              },
              children: [
                for (int i = 0; i < 43; i++)
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
