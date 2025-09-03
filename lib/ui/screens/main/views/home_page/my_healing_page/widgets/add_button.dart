import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../widgets/global_text.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shadowColor: const WidgetStatePropertyAll(Colors.transparent),
        backgroundColor: WidgetStatePropertyAll(Color(0xffFFD3E2)),
      ),
      onPressed: onPressed,
      child: Row(
        spacing: 3,
        children: [
          GlobalText(
            text: 'Əlavə et',
            fontSize: 14,
            height: 1.1,
            fontWeight: FontWeight.w500,
            color: ColorConstants.primaryRedColor,
          ),
          SvgPicture.asset('assets/icons/add_icon.svg'),
        ],
      ),
    );
  }
}
