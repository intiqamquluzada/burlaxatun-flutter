import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class CommentDatas extends StatelessWidget {
  const CommentDatas({
    super.key,
    this.comment,
  });

  final Comments? comment;

  @override
  Widget build(BuildContext context) {
    final userName = comment?.user ?? 'user';
    final text = comment?.text ?? 'comment text not found';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: '',
          errorWidget: (context, url, error) {
            return Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: Icon(Icons.person),
            );
          },
        ),
        // Image.asset(
        //   'assets/png/comment_user_pic.png',
        //   width: 44,
        //   height: 44,
        // ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GlobalText(
                      text: '@$userName',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Flexible(
                    child: GlobalText(
                      text: '1 minute ago',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              6.h,
              GlobalText(
                height: 1.4,
                textAlign: TextAlign.left,
                text: text,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ],
          ),
        )
      ],
    );
  }
}
