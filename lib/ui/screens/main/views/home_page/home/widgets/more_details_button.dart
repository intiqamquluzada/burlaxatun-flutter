import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../widgets/global_button.dart';
import 'baby_info_bottom_sheet.dart';

class MoreDetailsButton extends StatelessWidget {
  const MoreDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainnCubit>();
    return GlobalButton(
      buttonName: 'Daha ətraflı',
      buttonColor: Color(0xffFFD3E2),
      textColor: ColorConstants.primaryRedColor,
      onPressed: () {
        mainCubit.showBottomSheetAboutChild(
          BabyInfoBottomSheet(),
          context,
        );
      },
    );
  }
}
