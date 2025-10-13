import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../utils/constants/color_constants.dart';

class ForumInput extends StatelessWidget {
  const ForumInput({
    super.key,
    required this.hintText,
    this.textController,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.topPadding = 18,
    this.bottomPadding = 18,
    this.maxLines = 1,
  });

  final String hintText;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final void Function(String v)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final double topPadding;
  final double bottomPadding;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        controller: textController,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: bottomPadding, top: topPadding),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Color(0xff595959),
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(34)),
            borderSide: BorderSide(
              color: ColorConstants.enabledInputColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(34)),
            borderSide: BorderSide(
              color: ColorConstants.primaryRedColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.primaryRedColor,
            ),
          ),
        ),
      ),
    );
  }
}
