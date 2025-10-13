import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cubits/login_cubit/login_cubit.dart';
import '../../../../../cubits/login_cubit/login_cubit_state.dart';
import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/constants/text_constants.dart';
import '../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../widgets/global_text.dart';
import '../../widgets/custom_auth_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginCubitInitial>(
      buildWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus ||
          previous.isActiveButton != current.isActiveButton,
      listenWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus,
      listener: (_, state) {
        if (state.loginStatus == LoginStatus.success) {
          loginCubit.state.questionCompleted!
              ? context.go('/home')
              : context.go('/questions', extra: false);
        }
        if (state.loginStatus == LoginStatus.error) {
          loginCubit.errorState();
        }
        if (state.loginStatus == LoginStatus.networkError) {
          if (state.errorCode == 'phone_not_verified') {
            context.go(
              "/forgot_psw_otp",
              extra: {
                'from_register': true,
                'phone_number': loginCubit.loginEmailController.text,
              },
            );
          } else {
            loginCubit.errorState();
          }
          // AppSnackbars.error(context, 'Şəbəkəni yoxlayın');
        }
      },
      builder: (_, state) {
        return CustomAuthButton(
          buttonColor: state.isActiveButton
              ? ColorConstants.primaryRedColor
              : ColorConstants.disabledButtonColor,
          textColor: ColorConstants.white,
          onPressed: () {
            if (state.loginStatus == LoginStatus.loading) return;
            if (loginCubit.loginEmailController.text.isNotEmpty &&
                loginCubit.loginPasswordController.text.isNotEmpty) {
              state.isActiveButton ? loginCubit.login() : null;
            }
          },
          child: state.loginStatus == LoginStatus.loading
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
