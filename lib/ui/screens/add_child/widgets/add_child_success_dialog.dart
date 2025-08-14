import 'package:burla_xatun/cubits/main_cubit/mainn_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/asset_constants.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/extensions/context_extensions.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_button.dart';
import '../../../widgets/global_text.dart';

class AddChildSuccessDialog extends StatelessWidget {
  const AddChildSuccessDialog({
    super.key,
    required this.text,
    this.isChangeProfile = false,
  });

  final String text;
  final bool isChangeProfile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.deviceWidth * 0.78,
        height: context.deviceHeight * 0.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(38)),
          ),
          child: Padding(
            padding: PaddingConstants.v20 + PaddingConstants.h15,
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetConstants.successImage,
                      )
                    ],
                  ),
                ),
                (context.deviceHeight * 0.04).h,
                GlobalText(
                  text: text,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
                22.h,
                GlobalButton(
                  buttonName: 'Ana səhifə',
                  textFSize: 14,
                  textHeight: 0,
                  buttonColor: Color(0xffFDECF2),
                  textColor: ColorConstants.primaryRedColor,
                  height: 44,
                  onPressed: () {
                    isChangeProfile
                        ? context.replace('/change_profile')
                        : context.go('/home');
                    context.read<MainCubit>().changeView(0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
