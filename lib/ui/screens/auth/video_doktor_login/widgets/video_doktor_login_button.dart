import 'dart:developer';

import 'package:burla_xatun/cubits/login_cubit/login_cubit.dart';
import 'package:burla_xatun/cubits/login_cubit/login_cubit_state.dart';
import 'package:burla_xatun/ui/screens/auth/widgets/custom_auth_button.dart';
import 'package:burla_xatun/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:burla_xatun/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoDoktorLoginButton extends StatelessWidget {
  const VideoDoktorLoginButton({
    super.key,
    required this.userNameOrPhoneNumberController,
    required this.passwordController,
  });

  final TextEditingController userNameOrPhoneNumberController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginCubitInitial>(
      buildWhen: (previous, current) =>
          previous.videoDoktorLoginStatus != current.videoDoktorLoginStatus ||
          previous.isActiveVideoDoktorLoginButton !=
              current.isActiveVideoDoktorLoginButton,
      listener: (_, state) {
        if (state.videoDoktorLoginStatus == VideoDoktorLoginStatus.success) {
          // context.go('/home');
        }
        if (state.videoDoktorLoginStatus == VideoDoktorLoginStatus.error) {
          loginCubit.errorVideoDoktor();
          // AppSnackbars.error(context, 'Nə isə xəta baş verdi!');
        }
        if (state.videoDoktorLoginStatus ==
            VideoDoktorLoginStatus.networkError) {
          loginCubit.errorVideoDoktor();
          AppSnackbars.error(context, 'Şəbəkəni yoxlayın');
        }
      },
      builder: (_, state) {
        return CustomAuthButton(
          buttonColor: state.isActiveVideoDoktorLoginButton
              ? ColorConstants.primaryRedColor
              : ColorConstants.disabledButtonColor,
          textColor: ColorConstants.white,
          onPressed: () {
            if (state.videoDoktorLoginStatus ==
                VideoDoktorLoginStatus.loading) {
              return;
            }
            // if (loginCubit.loginEmailController.text.isNotEmpty &&
            //     loginCubit.loginPasswordController.text.isNotEmpty) {
            //   state.isActiveVideoDoktorLoginButton
            //       ? log('login with video doctor') // loginCubit.login()
            //       : null;
            // }
            state.isActiveVideoDoktorLoginButton
                ? loginCubit.loginByVideoDoktor(
                    login: userNameOrPhoneNumberController.text.trim(),
                    password: passwordController.text.trim(),
                  )
                : null;
          },
          child: state.videoDoktorLoginStatus == VideoDoktorLoginStatus.loading
              ? CustomCircularProgressIndicator()
              : GlobalText(
                  text: TextConstants.daxilOl,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
        );
      },
    );
  }
}
