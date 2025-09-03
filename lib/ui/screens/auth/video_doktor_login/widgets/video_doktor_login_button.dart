import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/login_cubit/login_cubit.dart';
import '../../../../../cubits/login_cubit/login_cubit_state.dart';
import '../../../../../utils/app/app_snackbars.dart';
import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/constants/text_constants.dart';
import '../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../widgets/global_text.dart';
import '../../widgets/custom_auth_button.dart';

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
            log('videodoktor login');
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
