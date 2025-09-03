import 'package:burla_xatun/cubits/questions_cubit/questions_cubit.dart';
import 'package:burla_xatun/data/models/local/calculation_options_model.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CalculateOptionBottomsheet extends StatefulWidget {
  const CalculateOptionBottomsheet({super.key});

  @override
  State<CalculateOptionBottomsheet> createState() =>
      _CalculateOptionBottomsheetState();
}

class _CalculateOptionBottomsheetState
    extends State<CalculateOptionBottomsheet> {
  late QuestionsCubit questionCubit;
  late FixedExtentScrollController _controller;
  late ValueNotifier<int?> calculateOptionValue;
  @override
  void initState() {
    questionCubit = context.read<QuestionsCubit>();

    calculateOptionValue = ValueNotifier<int>(0);
    _controller = FixedExtentScrollController(
        initialItem: questionCubit.state.selectedCalculateOptionIndex ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
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
              GlobalText(text: 'Hesablama metodunu seçin'),
              TextButton(
                onPressed: () {
                  questionsCubit.updateCalculateOptionName(
                      CalculationOptionsModel
                          .options[calculateOptionValue.value!].optionName);
                  questionsCubit
                      .selectCalculateOption(calculateOptionValue.value!);

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
              onSelectedItemChanged: (i) {
                calculateOptionValue.value = i;
                // questionsCubit.selectCalculateOption(i);
                // questionsCubit.updateCalculateOptionName(
                //     CalculationOptionsModel.options[i].optionName);
              },
              children: [
                for (int i = 0;
                    i < questionsCubit.calculationOptions.length;
                    i++)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${CalculationOptionsModel.options[i].optionName}'),
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
