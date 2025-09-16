import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';

class ArticleDetail extends StatelessWidget {
  final String title;
  final String text;

  const ArticleDetail({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 26,
            ),
            child: Column(
              children: [
                //26.h,
                SizedBox(
                  //width: MediaQuery.of(context).size.width * 0.84,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GlobalText(
                      height: 1.2,
                      textAlign: TextAlign.left,
                      text: title,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1D2939),
                    ),
                  ),
                ),
                20.h,
                SizedBox(
                  width: double.infinity,
                  child: Html(
                    data: text,
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(14),
                        color: const Color(0xff667085),
                        fontWeight: FontWeight.w400,
                        lineHeight: const LineHeight(1.4),
                        textAlign: TextAlign.left,
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
