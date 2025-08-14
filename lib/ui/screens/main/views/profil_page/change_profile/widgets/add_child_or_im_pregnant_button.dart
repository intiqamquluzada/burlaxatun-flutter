import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../widgets/global_text.dart';

class AddChildOrImPregnantButton extends StatelessWidget {
  const AddChildOrImPregnantButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.buttonName,
  });

  final void Function()? onTap;

  final String icon;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(42)),
            color: Color(0xffFFD3E2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12) +
                EdgeInsets.only(left: 23, right: 46),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),
                SizedBox(width: 16),
                GlobalText(
                  height: 1.4,
                  textAlign: TextAlign.left,
                  text: buttonName,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffEC407A),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
