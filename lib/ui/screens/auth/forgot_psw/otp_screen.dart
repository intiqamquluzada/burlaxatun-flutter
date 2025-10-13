import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../cubits/reset_password/reset_password_cubit.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/constants/text_constants.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_appbar.dart';
import '../../../widgets/global_button.dart';
import '../../../widgets/global_text.dart';
import 'widgets/send_code_again_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.fromRegister,
    this.phoneNumber,
  });

  final bool fromRegister;
  final String? phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final ResetPasswordCubit resetPasswordCubit;
  late final TextEditingController _otpController;
  @override
  void initState() {
    resetPasswordCubit = context.read<ResetPasswordCubit>();
    _otpController = TextEditingController();
    super.initState();
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
          leading: SizedBox.shrink(),
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
                          text: TextConstants.chechYourPhone,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        12.h,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Bu nömrəyə kod göndərdik: ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: "${widget.phoneNumber}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        38.h,
                        Center(
                          child: BlocBuilder<ResetPasswordCubit,
                              ResetPasswordState>(
                            buildWhen: (previous, current) {
                              return previous.resetPasswordStatus !=
                                  current.resetPasswordStatus;
                            },
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Pinput(
                                    onCompleted: (otp) {
                                      resetPasswordCubit.confirmOtp(
                                        fromRegister: widget.fromRegister,
                                        otp: otp,
                                        phoneNumber: widget.phoneNumber,
                                      );
                                    },
                                    autofocus: true,
                                    forceErrorState:
                                        state.resetPasswordStatus ==
                                            ResetPasswordStatus.error,
                                    controller: _otpController,
                                    keyboardType: TextInputType.number,
                                    length: 4,
                                    errorPinTheme: PinTheme(
                                      width: 78,
                                      height: 78,
                                      textStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    defaultPinTheme: PinTheme(
                                      width: 78,
                                      height: 78,
                                      textStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorConstants.lightGray,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    focusedPinTheme: PinTheme(
                                      width: 78,
                                      height: 78,
                                      textStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorConstants.primaryRedColor,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Visibility(
                                    visible: state.resetPasswordStatus ==
                                        ResetPasswordStatus.error,
                                    child: GlobalText(
                                      text: 'Kod yanlışdır, yenidən yoxlayın',
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        40.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SendCodeAgainButton(
                              fromRegister: widget.fromRegister,
                              phoneNumber: widget.phoneNumber,
                            ),
                          ],
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
                    if (state.resetPasswordStatus ==
                        ResetPasswordStatus.success) {
                      widget.fromRegister
                          ? context.pushReplacement('/login')
                          : context.pushReplacement("/reset_psw");
                    }
                  },
                  builder: (context, state) {
                    return GlobalButton(
                      isLoading: state.resetPasswordStatus ==
                          ResetPasswordStatus.loading,
                      buttonName: TextConstants.verify,
                      buttonColor: ColorConstants.primaryRedColor,
                      textColor: ColorConstants.white,
                      onPressed: () async {
                        await resetPasswordCubit.confirmOtp(
                          fromRegister: widget.fromRegister,
                          otp: _otpController.text,
                          phoneNumber:
                              widget.fromRegister ? widget.phoneNumber : null,
                        );
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
