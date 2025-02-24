import 'package:flutter/material.dart';

import 'global_text.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    required this.buttonName,
    required this.buttonColor,
    this.borderColor = Colors.transparent,
    required this.textColor,
    required this.onPressed,
    this.height = 55,
  });

  final double height;
  final String buttonName;
  final Color buttonColor;
  final Color borderColor;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          // padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
          // fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, double.maxFinite)),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
          backgroundColor: WidgetStatePropertyAll(buttonColor),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          side: WidgetStatePropertyAll(
            BorderSide(
              width: 1,
              color: borderColor,
            ),
          ),
        ),
        onPressed: onPressed,
        child: GlobalText(
          text: buttonName,
          fontSize: 16,
          height: 1.3,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
