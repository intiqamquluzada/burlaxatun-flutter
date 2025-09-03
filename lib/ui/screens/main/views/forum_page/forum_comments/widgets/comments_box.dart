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

import 'package:burla_xatun/cubits/create_comment/create_comment_cubit.dart';
import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'single_comment_box.dart';

class CommentsBox extends StatefulWidget {
  const CommentsBox({
    super.key,
    required this.commentList,
  });
  final List<Comments> commentList;

  @override
  State<CommentsBox> createState() => _CommentsBoxState();
}

class _CommentsBoxState extends State<CommentsBox> {
  late List<ValueNotifier<List<Comments>>> replyList;
  @override
  void initState() {
    // _initializeReplies();
    super.initState();
  }

  _initializeReplies() {
    replyList = List.generate(widget.commentList.length, (i) {
      return ValueNotifier(widget.commentList[i].replies ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    _initializeReplies();
    return DecoratedSliver(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color: Color(0xffE4E7EC)),
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.all(2),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.commentList.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  // log('comments buildedd');
                  return SingleCommentBox(
                    key: ValueKey(i),
                    index: i,
                    comment: widget.commentList[i],
                    replies: replyList[i],
                    parentReplies: replyList[i],
                  );
                },
              ),
              //
              BlocSelector<CreateCommentCubit, CreateCommentState,
                  CreateCommentStatus>(
                selector: (CreateCommentState state) {
                  return state.createCommentStatus;
                },
                builder: (context, status) {
                  return Visibility(
                    visible: status == CreateCommentStatus.commentLoading,
                    maintainSize: false,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
