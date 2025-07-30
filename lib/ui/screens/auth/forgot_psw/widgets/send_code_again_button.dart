import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/reset_password/reset_password_cubit.dart';
import '../../../../../utils/app/app_snackbars.dart';
import '../../../../../utils/constants/color_constants.dart';

class SendCodeAgainButton extends StatefulWidget {
  const SendCodeAgainButton({super.key});

  @override
  State<SendCodeAgainButton> createState() => _SendCodeAgainButtonState();
}

class _SendCodeAgainButtonState extends State<SendCodeAgainButton> {
  final ValueNotifier<int> seconds = ValueNotifier<int>(0);
  Timer? timer;

  void _startTimer() {
    seconds.value = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds.value--;
      _stopWhenZero();
    });
  }

  void _stopWhenZero() {
    if (seconds.value == 0) {
      timer?.cancel();
    }
  }

  String formattedTime(int v) {
    final minutes = v ~/ 60;
    final seconds = v % 60;
    final minute = minutes.toString().padLeft(2, '0');
    final second = seconds.toString().padLeft(2, '0');
    return '$minute:$second';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetpasswordCubit = context.read<ResetPasswordCubit>();
    return ValueListenableBuilder(
      valueListenable: seconds,
      builder: (context, value, child) {
        bool isZero = value == 0;
        return Row(
          children: [
            BlocListener<ResetPasswordCubit, ResetPasswordState>(
              listenWhen: (previous, current) {
                return previous.sendOtpStatus != current.sendOtpStatus;
              },
              listener: (context, state) {
                if (state.sendOtpStatus == SendOtpStatus.error) {
                  AppSnackbars.error(
                    context,
                    'Kod göndərərkən xəta baş verdi',
                  );
                } else if (state.sendOtpStatus == SendOtpStatus.success) {
                  AppSnackbars.success(
                    context,
                    'Kod göndərildi',
                  );
                }
              },
              child: GestureDetector(
                onTap: () {
                  if (isZero) {
                    _startTimer();
                    resetpasswordCubit.sendCode();
                  }
                },
                child: Text(
                  'Yenidən kod göndər',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isZero
                        ? ColorConstants.customBlack
                        : ColorConstants.textFieldTitleColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            !isZero
                ? Text(
                    formattedTime(value),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.customBlack,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
