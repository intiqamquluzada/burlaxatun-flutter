import 'package:flutter/material.dart';

import '../../../../utils/constants/padding_constants.dart';
import '../../../../utils/extensions/context_extensions.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../widgets/signup_options.dart';
import 'widgets/forgot_password_button.dart';
import 'widgets/login_button.dart';
import 'widgets/login_image.dart';
import 'widgets/login_inputs.dart';
import 'widgets/signup_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  LoginInputs(),
                  ForgotPasswordButton(),
                  context.deviceHeight < 750 ? 3.h : 10.h,
                  LoginButton(),
                  context.deviceHeight < 750 ? 11.h : 26.h,
                  SignupButton(),
                  context.deviceHeight < 750 ? 10.h : 25.h,
                  SignupOptions(),
                  
                  // TextButton(
                  //   onPressed: () {
                  //     context.go('/home');
                  //   },
                  //   child: Text('Home'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
