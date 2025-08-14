import 'package:burla_xatun/ui/screens/auth/widgets/custom_auth_button.dart';
import 'package:burla_xatun/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:burla_xatun/utils/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cubits/signup_cubit/signup_cubit.dart';
import '../../../../../utils/constants/color_constants.dart';

class GoOnButton extends StatefulWidget {
  const GoOnButton({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;

  @override
  State<GoOnButton> createState() => _GoOnButtonState();
}

class _GoOnButtonState extends State<GoOnButton> {
  bool? isActiveButton;

  @override
  Widget build(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (_, state) {
        if (state is SignupSuccess) {
          context.go('/questions', extra: false);
        }
        if (state is SignupError) {
          final errorMessage = state.error;
          AppSnackbars.error(
              context,
              errorMessage.isNotEmpty
                  ? errorMessage
                  : 'Qeydiyyat uğursuz oldu!');
        }
        if (state is SignupNetworkError) {
          final errorMessage = state.error;

          AppSnackbars.error(
              context,
              errorMessage.isNotEmpty
                  ? errorMessage
                  : 'Qeydiyyat uğursuz oldu!');
        }
      },
      builder: (_, state) {
        return CustomAuthButton(
          buttonColor: signupCubit.isActiveButton
              ? ColorConstants.primaryRedColor
              : ColorConstants.disabledButtonColor,
          textColor: ColorConstants.white,
          onPressed: state is SignupLoading
              ? () {}
              : () {
                  if (state is SignupInitial) {
                    isActiveButton = state.isActiveButton;
                  }

                  if (isActiveButton! &&
                      widget.formKey.currentState!.validate()) {
                    signupCubit.register();
                  }
                },
          child: state is SignupLoading
              ? CustomCircularProgressIndicator()
              : GlobalText(
                  text: TextConstants.davamEt,
                ),
        );
      },
    );
  }
}
