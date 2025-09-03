import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../utils/extensions/num_extensions.dart';

class PickBirthDateWidget extends StatelessWidget {
  const PickBirthDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final questionCubit = context.read<QuestionsCubit>();
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          10.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Bağla',
                  style: TextStyle(color: ColorConstants.primaryRedColor),
                ),
              ),
              Text('Doğum tarixini seçin'),
              TextButton(
                onPressed: () {
                  context.pop([
                    questionCubit.state.birthDateString,
                    questionCubit.state.initialDateTime
                  ]);
                },
                child: Text(
                  'Seçin',
                  style: TextStyle(color: ColorConstants.primaryRedColor),
                ),
              ),
            ],
          ),
          10.h,
          SizedBox(
            height: 230,
            child: CupertinoDatePicker(
              initialDateTime: questionCubit.state.initialDateTime,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (onDateTimeChanged) {
                questionCubit.updateBirthDate(
                    '${onDateTimeChanged.day}/${onDateTimeChanged.month}/${onDateTimeChanged.year}',
                    onDateTimeChanged);
              },
            ),
          ),
        ],
      ),
    );
  }
}
