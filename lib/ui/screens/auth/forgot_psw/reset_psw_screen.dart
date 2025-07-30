import 'package:burla_xatun/cubits/reset_password/reset_password_cubit.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/asset_constants.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/constants/text_constants.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_button.dart';
import '../../../widgets/global_input.dart';
import '../../../widgets/global_text.dart';

class ResetPswScreen extends StatefulWidget {
  const ResetPswScreen({super.key});

  @override
  State<ResetPswScreen> createState() => _ResetPswScreenState();
}

class _ResetPswScreenState extends State<ResetPswScreen> {
  final ValueNotifier<bool> _newPasswordVisibility = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _confirmPasswordVisibility =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> isEqual = ValueNotifier<bool>(true);

  late final TextEditingController newPassController;
  late final TextEditingController confirmPassController;

  late final GlobalKey<FormState> passwordsFormKey;
  late final ResetPasswordCubit resetPasswordCubit;

  @override
  void initState() {
    passwordsFormKey = GlobalKey<FormState>();
    newPassController = TextEditingController();
    confirmPassController = TextEditingController();
    resetPasswordCubit = context.read<ResetPasswordCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _newPasswordVisibility.dispose();
    _confirmPasswordVisibility.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardVisible = keyboardHeight > 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: GlobalAppbar(
          title: "",
          leading: SizedBox.shrink(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: PaddingConstants.h20,
                    child: Form(
                      key: passwordsFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          30.h,
                          GlobalText(
                            text: TextConstants.resetPsw,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                          12.h,
                          GlobalText(
                            text: TextConstants.typeSomething,
                          ),
                          24.h,
                          GlobalText(
                            text: TextConstants.newPsw,
                            color: ColorConstants.textFieldTitleColor,
                            fontWeight: FontWeight.w500,
                          ),
                          20.h,
                          ValueListenableBuilder(
                            valueListenable: _newPasswordVisibility,
                            builder: (_, isVisibile, __) => GlobalInput(
                              validator: (pass) {
                                if (pass == null || pass.isEmpty) {
                                  return 'Zəhmət olmasa sahəni doldurun';
                                } else if (pass.length < 8) {
                                  return 'Şifrə ən azı 8 rəqəmli olmalıdır';
                                }
                                return null;
                              },
                              textController: newPassController,
                              isObsecure: !isVisibile,
                              hintText: TextConstants.enterNewPassword,
                              prefixIcon: AssetConstants.lockIcon,
                              suffixIcon: isVisibile
                                  ? AssetConstants.eyeOpenedIcon
                                  : AssetConstants.eyeClosedIcon,
                              onSuffixIconTap: () {
                                // setState(() {
                                _newPasswordVisibility.value = !isVisibile;
                                // });
                              },
                            ),
                          ),
                          20.h,
                          GlobalText(
                            text: TextConstants.confirmNewPsw,
                            color: ColorConstants.textFieldTitleColor,
                            fontWeight: FontWeight.w500,
                          ),
                          20.h,
                          ValueListenableBuilder(
                            valueListenable: _confirmPasswordVisibility,
                            builder: (_, isVisible, __) => GlobalInput(
                              validator: (pass) {
                                if (pass == null || pass.isEmpty) {
                                  return 'Zəhmət olmasa sahəni doldurun';
                                } else if (pass.length < 8) {
                                  return 'Şifrə ən azı 8 rəqəmli olmalıdır';
                                }
                                return null;
                              },
                              textController: confirmPassController,
                              isObsecure: !isVisible,
                              hintText: TextConstants.enterNewPasswordAgain,
                              prefixIcon: AssetConstants.lockIcon,
                              suffixIcon: isVisible
                                  ? AssetConstants.eyeOpenedIcon
                                  : AssetConstants.eyeClosedIcon,
                              onSuffixIconTap: () {
                                // setState(() {
                                _confirmPasswordVisibility.value = !isVisible;
                                // });
                              },
                            ),
                          ),
                          13.h,
                          ValueListenableBuilder(
                            valueListenable: isEqual,
                            builder: (context, value, child) {
                              return !value
                                  ? Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Şifrələr bərabər deyil',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: isKeyboardVisible ? 20 : 32,
                ),
                child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  listener: (context, state) {
                    if (state.resetPasswordStatus ==
                        ResetPasswordStatus.error) {
                      AppSnackbars.error(
                        context,
                        'Şifrəni dəyişərkən xəta baş verdi',
                      );
                    } else if (state.resetPasswordStatus ==
                        ResetPasswordStatus.success) {
                      context.go('/forgot_psw_success');
                    }
                  },
                  builder: (context, state) {
                    return GlobalButton(
                      isLoading: state.resetPasswordStatus ==
                          ResetPasswordStatus.loading,
                      buttonName: TextConstants.resetPsw,
                      buttonColor: ColorConstants.primaryRedColor,
                      textColor: ColorConstants.white,
                      onPressed: () async {
                        isEqual.value = newPassController.text ==
                            confirmPassController.text;
                        if (!passwordsFormKey.currentState!.validate() ||
                            newPassController.text !=
                                confirmPassController.text) {
                          return;
                        } else {
                          await resetPasswordCubit.resetPassword(
                            newPass: newPassController.text.trim(),
                            confirmNewPass: confirmPassController.text.trim(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
