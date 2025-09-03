import 'package:burla_xatun/cubits/login_cubit/login_cubit.dart';
import 'package:burla_xatun/cubits/login_cubit/login_cubit_state.dart';
import 'package:burla_xatun/ui/widgets/global_input.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/constants/asset_constants.dart';
import 'package:burla_xatun/utils/constants/text_constants.dart';
import 'package:burla_xatun/utils/extensions/context_extensions.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoDoctorLoginInputs extends StatefulWidget {
  const VideoDoctorLoginInputs({
    super.key,
    required this.userNameOrPhoneNumberController,
    required this.passwordController,
    required this.userNameOrPhoneNumberFocusNode,
    required this.passwordFocusNode,
  });

  final TextEditingController userNameOrPhoneNumberController;
  final TextEditingController passwordController;
  final FocusNode userNameOrPhoneNumberFocusNode;
  final FocusNode passwordFocusNode;

  @override
  State<VideoDoctorLoginInputs> createState() => _VideoDoctorLoginInputsState();
}

class _VideoDoctorLoginInputsState extends State<VideoDoctorLoginInputs> {
  // late TextEditingController userNameOrPhoneNumberController;
  // late TextEditingController passwordController;
  // late FocusNode userNameOrPhoneNumberFocusNode;
  // late FocusNode passwordFocusNode;
  final ValueNotifier<bool> isObsecure = ValueNotifier<bool>(true);
  // @override
  // void initState() {
  //   userNameOrPhoneNumberController = TextEditingController();
  //   passwordController = TextEditingController();
  //   userNameOrPhoneNumberFocusNode = FocusNode();
  //   passwordFocusNode = FocusNode();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   userNameOrPhoneNumberController.dispose();
  //   passwordController.dispose();
  //   userNameOrPhoneNumberFocusNode.dispose();
  //   passwordFocusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginCubitInitial>(
      buildWhen: (previous, current) =>
          previous.isVideDoktorError != current.isVideDoktorError ||
          previous.videoDoktorLoginStatus != current.videoDoktorLoginStatus,
      builder: (_, state) {
        return Column(
          children: [
            GlobalInput(
              isError: state.isVideDoktorError,
              textController: widget.userNameOrPhoneNumberController,
              focusNode: widget.userNameOrPhoneNumberFocusNode,
              inputName: 'İstifadəçi adı və ya mobil nömrə',
              hintText: 'İstifadəçi adı və ya mobil nömrə',
              onFieldSubmitted: (v) => widget.passwordFocusNode.requestFocus(),
              onChanged: (v) {
                loginCubit.updateVideoDoktorLoginButton(
                  userName: widget.userNameOrPhoneNumberController,
                  password: widget.passwordController,
                );
              },
            ),
            context.deviceHeight < 750 ? 10.h : 26.h,
            BlocBuilder<LoginCubit, LoginCubitInitial>(
              buildWhen: (previous, current) =>
                  previous.isError != current.isError,
              builder: (_, state) {
                return ValueListenableBuilder(
                  valueListenable: isObsecure,
                  builder: (context, value, child) {
                    return GlobalInput(
                      isError: state.isVideDoktorError,
                      textController: widget.passwordController,
                      focusNode: widget.passwordFocusNode,
                      inputName: TextConstants.sifre,
                      hintText: TextConstants.sifreniziDaxilEdin,
                      isObsecure: value,
                      suffixIcon: value
                          ? AssetConstants.eyeClosedIcon
                          : AssetConstants.eyeOpenedIcon,
                      onSuffixIconTap: () {
                        isObsecure.value = !isObsecure.value;
                      },
                      onChanged: (v) {
                        loginCubit.updateVideoDoktorLoginButton(
                          userName: widget.userNameOrPhoneNumberController,
                          password: widget.passwordController,
                        );
                      },
                    );
                  },
                );
              },
            ),
            9.h,
            state.isVideDoktorError
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
                                : 'Parol və ya isitfadəçi adı (və ya nömrə) yanlışdır',
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
