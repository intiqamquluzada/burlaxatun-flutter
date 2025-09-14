import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/login_cubit/login_cubit.dart';
import '../../../../utils/constants/text_constants.dart';
import '../../../../utils/extensions/context_extensions.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_text.dart';
import '../video_doktor_login/video_doktor_login.dart';

class SignupOptions extends StatelessWidget {
  const SignupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalText(
          text: 'VƏ YA',
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        context.deviceHeight < 710 ? 10.h : 24.h,
        GestureDetector( 
          onTap: () {
            // context.pushReplacement('/video_doktor_login');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<LoginCubit>(),
                  child: VideoDoktorLogin(),
                ),
              ),
            );
          },
          child: OptionWidget(
            paddingRight: 39,
            optionName: TextConstants.videoDoktor,
            child: Image.asset(
              'assets/png/videodoctor_logo.png',
              width: 25,
              height: 25,
            ),
          ),
        ),
      ],
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.optionName,
    required this.child,
    this.paddingRight = 0,
  });

  final String optionName;
  final Widget child;
  final double paddingRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Color(0xffD3D3D3),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            Padding(
              padding: EdgeInsets.only(right: paddingRight),
              child: GlobalText(
                text: optionName,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
