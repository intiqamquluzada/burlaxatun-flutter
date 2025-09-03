import 'package:flutter/material.dart';

import 'widgets/onboard_button.dart';
import 'widgets/onboard_dots.dart';
import 'widgets/onboard_page_view.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  OnboardPageView(),
                  Positioned(
                    bottom: 160,
                    child: OnboardDots(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
          child: OnboardButton(),
        ),
      ),
    );
  }
}
