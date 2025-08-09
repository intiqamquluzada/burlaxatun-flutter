import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/global_text.dart';

class ArticleBox extends StatelessWidget {
  const ArticleBox({
    super.key,
    this.playButton,
    required this.boxTitle,
    required this.boxDescription,
    this.onTap,
    required this.videoOrImage,
  });

  final Widget? playButton;
  final void Function()? onTap;
  final String boxTitle;
  final String boxDescription;
  final Widget videoOrImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xffF2F4F7),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            child: Column(
              children: [
                videoOrImage,
                22.h,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GlobalText(
                    height: 1.2,
                    textAlign: TextAlign.left,
                    text: boxTitle,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1D2939),
                  ),
                ),
                12.h,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Html(
                    data: boxDescription,
                    style: {
                      "body": Style(
                        maxLines: 2,
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(12),
                        color: Color(0xff8C8A8A),
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                        lineHeight: LineHeight.number(1.2),
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
