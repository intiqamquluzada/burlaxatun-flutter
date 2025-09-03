import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/constants/color_constants.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/sign_up'),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Hesabınız yoxdur?',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Color(0xff070707),
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
              ),
              TextSpan(
                text: ' Qeydiyyatdan keçin',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: ColorConstants.primaryRedColor,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
