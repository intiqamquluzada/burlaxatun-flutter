import 'package:burla_xatun/cubits/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/extensions/context_extensions.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_appbar.dart';
import '../login/widgets/login_image.dart';
import 'widgets/video_doctor_login_inputs.dart';
import 'widgets/video_doktor_login_button.dart';

class VideoDoktorLogin extends StatefulWidget {
  const VideoDoktorLogin({super.key});

  @override
  State<VideoDoktorLogin> createState() => _VideoDoktorLoginState();
}

class _VideoDoktorLoginState extends State<VideoDoktorLogin> {
  late TextEditingController userNameOrPhoneNumberController;
  late TextEditingController passwordController;
  late FocusNode userNameOrPhoneNumberFocusNode;
  late FocusNode passwordFocusNode;
  @override
  void initState() {
    userNameOrPhoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    userNameOrPhoneNumberFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    userNameOrPhoneNumberController.dispose();
    passwordController.dispose();
    userNameOrPhoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Video hesabı ilə giriş',
        onLeadingTap: () {
          Navigator.pop(context, true);
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: PaddingConstants.h20,
            child: Center(
              child: Column(
                children: [
                  (context.deviceHeight * 0.07).h,
                  LoginImage(),
                  context.deviceHeight < 750 ? 13.h : 30.h,
                  VideoDoctorLoginInputs(
                    userNameOrPhoneNumberController:
                        userNameOrPhoneNumberController,
                    passwordController: passwordController,
                    userNameOrPhoneNumberFocusNode:
                        userNameOrPhoneNumberFocusNode,
                    passwordFocusNode: passwordFocusNode,
                  ),
                  context.deviceHeight < 750 ? 15.h : 22.h,
                  VideoDoktorLoginButton(
                    userNameOrPhoneNumberController:
                        userNameOrPhoneNumberController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
