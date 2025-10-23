import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/constants/text_constants.dart';
import '../../../../widgets/global_text.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.push("/email_request");
          },
          style:
              ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
          child: GlobalText(
            text: TextConstants.forgotPsw,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorConstants.customBlue,
          ),
        ),
      ],
    );
  }
}
