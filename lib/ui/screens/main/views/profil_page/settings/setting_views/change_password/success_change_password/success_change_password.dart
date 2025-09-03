import 'package:burla_xatun/utils/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../../widgets/global_appbar.dart';
import '../../../../../../../../widgets/global_button.dart';
import '../../../../../../../../widgets/global_text.dart';

class SuccessChangePassword extends StatelessWidget {
  const SuccessChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return Scaffold(
      appBar: GlobalAppbar(
        title: ' ',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset(AssetConstants.taddaaImage),
            Spacer(),
            GlobalText(
              height: 1.4,
              text: 'Şifrə uğurla \n dəyişdirildi!',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15) +
            EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 32),
        child: GlobalButton(
          height: 50,
          buttonName: 'Ana səhifəyə qayıdın',
          buttonColor: ColorConstants.primaryRedColor,
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            mainCubit.changeView(0);
            context.go('/home');
          },
        ),
      ),
    );
  }
}
