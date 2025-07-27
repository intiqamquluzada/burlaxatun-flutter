// import 'package:flutter/material.dart';

// import 'single_comment_box.dart';

// class CommentsBox extends StatelessWidget {
//   const CommentsBox({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedSliver(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         border: Border.all(width: 2, color: Color(0xffE4E7EC)),
//       ),
//       sliver: SliverPadding(
//         padding: const EdgeInsets.all(2),
//         sliver: SliverList(
//           delegate: SliverChildBuilderDelegate(
//             childCount: 4,
//             (_, i) {
//               return SingleCommentBox(index: i);
//             },
//           ),
//         ),
//       ),
//     );
//     // DecoratedBox(
//     //   decoration: BoxDecoration(
//     //     borderRadius: BorderRadius.all(Radius.circular(20)),
//     //     border: Border.all(width: 2, color: Color(0xffE4E7EC)),
//     //   ),
//     //   child: Padding(
//     //     padding: const EdgeInsets.all(2),
//     //     child:
//     //         // SliverList(
//     //         //   delegate: SliverChildBuilderDelegate(
//     //         //     childCount: 10,
//     //         //     (_, i) {
//     //         //       return SingleCommentBox(i: i);
//     //         //     },
//     //         //   ),
//     //         // )
//     //         ListView.builder(
//     //       itemCount: 10,
//     //       shrinkWrap: true,
//     //       physics: NeverScrollableScrollPhysics(),
//     //       itemBuilder: (_, i) {
//     //         return SingleCommentBox(i: i);
//     //       },
//     //     ),
//     //   ),
//     // );
//   }
// }

import 'package:burla_xatun/ui/screens/main/views/forum_page/forum_comments/widgets/single_comment_box.dart';
import 'package:flutter/material.dart';

class CommentsBox extends StatelessWidget {
  const CommentsBox({
    super.key,
  });

  @override 
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Color(0xffE4E7EC)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ListView.builder(
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return SingleCommentBox(
                index: i,
              );
            },
          ),
        ),
      ),
    );
  }
}
