import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/splash/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashCubit splashCubit;

  @override
  void initState() {
    splashCubit = context.read<SplashCubit>();
    splashCubit.splahsMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuth) {
            context.go('/onboarding');
          } else if (state is SplashSuccess) {
            context.go('/home');
          } else if (state is SplashLogin) {
            context.go('/login');
          } else {
            context.go('/onboarding');
          }
        },
        child: Center(
          child: Image.asset('assets/png/Burla_Xatun_splash_screen.png'),
        ),
      ),
    );
  }
}
