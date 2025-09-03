import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/login_cubit/login_cubit.dart';
import '../../../../../cubits/login_cubit/login_cubit_state.dart';
import '../../../../../utils/constants/asset_constants.dart';
import '../../../../../utils/constants/text_constants.dart';
import '../../../../../utils/extensions/context_extensions.dart';
import '../../../../../utils/extensions/num_extensions.dart';
import '../../../../widgets/global_input.dart';
import '../../../../widgets/global_text.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginCubitInitial>(
      buildWhen: (previous, current) =>
          previous.isError != current.isError ||
          previous.loginStatus != current.loginStatus,
      builder: (_, state) {
        return Column(
          children: [
            GlobalInput(
              isError: state.isError,
              textController: loginCubit.loginEmailController,
              focusNode: loginCubit.loginEmailFocusNode,
              inputName: 'Mobil nömrə',
              hintText: 'xxx xxx xx xx',
              isNumber: true,
              onFieldSubmitted: (p0) =>
                  loginCubit.loginPasswordFocusNode.requestFocus(),
              onChanged: (v) {
                loginCubit.updateIsValid();
              },
            ),
            context.deviceHeight < 750 ? 10.h : 26.h,
            BlocBuilder<LoginCubit, LoginCubitInitial>(
              buildWhen: (previous, current) =>
                  previous.isObsecure != current.isObsecure ||
                  previous.isError != current.isError,
              builder: (_, state) {
                return GlobalInput(
                  isError: state.isError,
                  textController: loginCubit.loginPasswordController,
                  focusNode: loginCubit.loginPasswordFocusNode,
                  inputName: TextConstants.sifre,
                  // prefixIcon: 'assets/icons/lock_2.svg',
                  hintText: TextConstants.sifreniziDaxilEdin,
                  isObsecure: state.isObsecure,
                  suffixIcon: state.isObsecure
                      ? AssetConstants.eyeClosedIcon
                      : AssetConstants.eyeOpenedIcon,
                  onSuffixIconTap: () => loginCubit.isObsecureToggle(),
                  onChanged: (v) {
                    loginCubit.updateIsValid();
                  },
                );
              },
            ),
            9.h,
            state.isError
                ? Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Color(0xffD62828),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          child: GlobalText(
                            text: (state.errorMessage != null &&
                                    state.errorMessage!.isNotEmpty)
                                ? state.errorMessage!
                                : 'Email və ya parol yanlışdır.',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffD62828),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
