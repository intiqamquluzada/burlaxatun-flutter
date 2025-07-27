// import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
// import 'package:burla_xatun/ui/screens/main/views/forum_page/forum_comments/widgets/single_comment_box.dart';
// import 'package:flutter/material.dart';

// class CommentsBox extends StatelessWidget {
//   const CommentsBox({
//     super.key,
//     required this.commentList,
//   });

//   final List<Comments> commentList;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           // border: Border(
//           //   top: BorderSide(color: Color(0xffE4E7EC), width: 2),
//           //   left: BorderSide(color: Color(0xffE4E7EC), width: 2),
//           //   right: BorderSide(color: Color(0xffE4E7EC), width: 2),
//           //   bottom: BorderSide(color: Colors.black, width: 0),
//           // ),
//           border: Border.all(width: 2, color: Color(0xffE4E7EC)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(2),
//           child: ListView.builder(
//             itemCount: commentList.length,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, i) {
//               return SingleCommentBox(
//                 index: i,
//                 comment: commentList[i],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:flutter/material.dart';

import 'single_comment_box.dart';

class CommentsBox extends StatelessWidget {
  const CommentsBox({
    super.key,
    required this.commentList,
  });
  final List<Comments> commentList;

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color: Color(0xffE4E7EC)),
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.all(2),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: commentList.length,
            (_, i) {
              return SingleCommentBox(
                index: i,
                comment: commentList[i],
              );
            },
          ),
        ),
      ),
    );
  }
}
