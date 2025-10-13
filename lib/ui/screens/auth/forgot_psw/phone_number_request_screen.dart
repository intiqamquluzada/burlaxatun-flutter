import 'dart:developer';

import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cubits/reset_password/reset_password_cubit.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/constants/text_constants.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_button.dart';
import '../../../widgets/global_input.dart';
import '../../../widgets/global_text.dart';

class PhoneNumberRequestScreen extends StatefulWidget {
  const PhoneNumberRequestScreen({super.key});

  @override
  State<PhoneNumberRequestScreen> createState() =>
      _PhoneNumberRequestScreenState();
}

class _PhoneNumberRequestScreenState extends State<PhoneNumberRequestScreen> {
  late final ResetPasswordCubit resetPasswordCubit;
  late final TextEditingController _textEditingController;
  late final GlobalKey<FormState> numberFormKey;
  @override
  void initState() {
    resetPasswordCubit = context.read<ResetPasswordCubit>();
    _textEditingController = TextEditingController();
    numberFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
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
          title: '',
          onLeadingTap: () {
            context.pop();
          },
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: PaddingConstants.h20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.h,
                        GlobalText(
                          text: TextConstants.changePsw,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        12.h,
                        GlobalText(
                          text: TextConstants.dontWorry,
                        ),
                        24.h,
                        Form(
                          key: numberFormKey,
                          child: GlobalInput(
                            textController: _textEditingController,
                            hintText: TextConstants.enterYourNumber,
                            isNumber: true,
                            validator: (number) {
                              if (number == null || number.isEmpty) {
                                return 'Zəhmət olmasa sahəni doldurun';
                              } else if (number.length < 9) {
                                return 'Nömrə formatı düzgün deyil';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                    if (state.sendOtpStatus == SendOtpStatus.error) {
                      AppSnackbars.error(
                        context,
                        'Kod göndərərkən xəta baş verdi',
                      );
                    } else if (state.sendOtpStatus == SendOtpStatus.success) {
                      log('code sended successfully to your phone');
                      context.go(
                        "/forgot_psw_otp",
                        extra: {
                          'from_register': false,
                          'register_number': _textEditingController.text,
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return GlobalButton(
                      isLoading: state.sendOtpStatus == SendOtpStatus.loading,
                      buttonName: TextConstants.sendCode,
                      buttonColor: ColorConstants.primaryRedColor,
                      textColor: ColorConstants.white,
                      onPressed: () async {
                        if (numberFormKey.currentState!.validate()) {
                          await resetPasswordCubit.sendCode(
                            phoneNumber: _textEditingController.text.trim(),
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
