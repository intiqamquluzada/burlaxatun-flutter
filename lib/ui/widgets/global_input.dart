import 'package:flutter/services.dart';

import '../../utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/color_constants.dart';
import '../../utils/extensions/num_extensions.dart';
import 'global_text.dart';

class GlobalInput extends StatelessWidget {
  const GlobalInput({
    super.key,
    this.inputName,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.isObsecure = false,
    this.onSuffixIconTap,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.textController,
    this.onChanged,
    this.isError = false,
    this.isNumber = false,
    this.onTapOutside,
  });

  final String? inputName;
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool isObsecure;
  final bool isError;
  final bool isNumber;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final void Function()? onSuffixIconTap;
  final void Function(String v)? onFieldSubmitted;
  final void Function(String v)? onChanged;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        inputName != null
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GlobalText(
                        text: inputName!,
                        fontSize: 14,
                        height: 1.1,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  context.deviceHeight < 750 ? 8.h : 16.h,
                ],
              )
            : SizedBox.shrink(),
        TextFormField(
          onTapOutside: onTapOutside ??
              (event) {
                FocusScope.of(context).unfocus();
              },
          controller: textController,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          focusNode: focusNode,
          obscureText: isObsecure,
          maxLength: isNumber ? 10 : null,
          buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) =>
              null,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isError ? Color(0xffD62828) : Colors.black,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 18) + EdgeInsets.only(left: 24),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: isError ? Color(0xffD62828) : ColorConstants.hintTextColor,
              fontWeight: FontWeight.w500,
            ),
            isDense: true,
            prefixIcon: prefixIcon == null
                ? isNumber
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 10, bottom: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '+994',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isError
                                    ? Color(0xffD62828)
                                    : ColorConstants.hintTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          prefixIcon!,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            isError
                                ? Color(0xffD62828)
                                : ColorConstants.customBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
            suffixIcon: suffixIcon == null
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(right: 29),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: GestureDetector(
                        onTap: onSuffixIconTap,
                        child: SvgPicture.asset(
                          suffixIcon!,
                          colorFilter: ColorFilter.mode(
                            isError
                                ? Color(0xffD62828)
                                : ColorConstants.enabledInputColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(34)),
              borderSide: BorderSide(
                color: isError
                    ? Color(0xffD62828)
                    : ColorConstants.enabledInputColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(34)),
              borderSide: BorderSide(
                color: ColorConstants.primaryRedColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(34)),
              borderSide: BorderSide(
                color: ColorConstants.primaryRedColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(34)),
              borderSide: BorderSide(
                color: ColorConstants.primaryRedColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
