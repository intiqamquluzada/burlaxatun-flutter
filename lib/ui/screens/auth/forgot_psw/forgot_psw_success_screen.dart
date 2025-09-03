import 'package:burla_xatun/ui/widgets/global_button.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/asset_constants.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:burla_xatun/utils/constants/padding_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SuccessForgotPswScreen extends StatelessWidget {
  const SuccessForgotPswScreen({
    super.key,
    this.isChangePasswordSuccess = false,
  });

  final bool isChangePasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset(AssetConstants.taddaaImage),
            Spacer(),
            GlobalText(
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
        padding: PaddingConstants.h15 + PaddingConstants.b32,
        child: GlobalButton(
          height: 50,
          //buttonName: 'Back at home',
          buttonName: 'Növbəti',
          buttonColor: ColorConstants.primaryRedColor,
          textColor: Colors.white,
          onPressed: () {
            isChangePasswordSuccess ? context.pop() : context.go('/login');
          },
        ),
      ),
    );
  }
}
