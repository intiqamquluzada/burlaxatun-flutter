import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import 'format_box.dart';

class SelectableUltrasoundFormat extends StatelessWidget {
  const SelectableUltrasoundFormat({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return SizedBox(
      width: context.deviceWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffE4E7EC),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<MainCubit, MainInitial>(
                buildWhen: (previous, current) {
                  return previous.ultrasoundFormat != current.ultrasoundFormat;
                },
                builder: (context, state) {
                  return FormatBox(
                    format: '2D',
                    onTap: () =>
                        mainCubit.changeFormat(UltrasoundFormat.format2d),
                    boxColors:
                        state.ultrasoundFormat == UltrasoundFormat.format2d
                            ? Colors.white
                            : Colors.transparent,
                  );
                },
              ),
              SizedBox(width: 18),
              ColoredBox(
                color: Color(0xffD0D5DD),
                child: SizedBox(
                  width: 1,
                  height: 18,
                ),
              ),
              SizedBox(width: 18),
              BlocBuilder<MainCubit, MainInitial>(
                buildWhen: (previous, current) {
                  return previous.ultrasoundFormat != current.ultrasoundFormat;
                },
                builder: (context, state) {
                  return FormatBox(
                    format: '3D',
                    onTap: () =>
                        mainCubit.changeFormat(UltrasoundFormat.format3d),
                    boxColors:
                        state.ultrasoundFormat == UltrasoundFormat.format3d
                            ? Colors.white
                            : Colors.transparent,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
