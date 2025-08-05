import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../data/models/remote/response/faqs_model.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class QuestionBox extends StatelessWidget {
  QuestionBox({
    super.key,
    required this.index,
    required this.faq,
  });

  final int index;
  final Result faq;
  final isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Durations.medium2,
      child: GestureDetector(
        onTap: () {
          isExpanded.value = !isExpanded.value;
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: context.deviceWidth * 0.69,
                        child: GlobalText(
                          height: 1.5,
                          textAlign: TextAlign.left,
                          text: faq.question ?? 'No question',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      ValueListenableBuilder(
                        valueListenable: isExpanded,
                        builder: (context, value, child) {
                          return SvgPicture.asset(
                            isExpanded.value
                                ? 'assets/icons/minus_icon.svg'
                                : 'assets/icons/plus_icon.svg',
                          );
                        },
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: isExpanded,
                    builder: (context, value, child) {
                      return isExpanded.value
                          ? Column(
                              children: [
                                15.h,
                                ColoredBox(
                                  color: Color(0xffE4E4E4),
                                  child: SizedBox(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                15.h,
                                Html(data: faq.answer)
                                // GlobalText(
                                //   height: 1.8,
                                //   textAlign: TextAlign.left,
                                //   text: faq.answer ?? 'No answer',
                                //   fontSize: 14,
                                //   fontWeight: FontWeight.w400,
                                //   color: Colors.black,
                                // ),
                              ],
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
