import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/global_text.dart';

class ForumBox extends StatelessWidget {
  const ForumBox({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainnCubit>();
    return GestureDetector(
      onTap: () {
        mainCubit.pushScaffoldForumComments(context);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xffF7F7F7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlobalText(
                    text: 'Samira',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      GlobalText(
                        text: 'Daha etrafli',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff97989D),
                      ),
                      SizedBox(width: 7),
                      SvgPicture.asset(
                          'assets/icons/medicine_arrow_right_icon.svg'),
                    ],
                  ),
                ],
              ),
              8.h,
              SizedBox(
                width: context.deviceWidth * 0.62,
                child: GlobalText(
                  height: 1.4,
                  textAlign: TextAlign.left,
                  text:
                      'Hamilə qadının havanın çirklənməsi haqqında nəyi bilməsi lazımdır?',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              20.h,
              Row(
                spacing: 30,
                children: [
                  GlobalText(
                    textAlign: TextAlign.left,
                    text: '651,324 Views',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  GlobalText(
                    textAlign: TextAlign.left,
                    text: '36,6545 Likes',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  GlobalText(
                    textAlign: TextAlign.left,
                    text: '56 comments',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
