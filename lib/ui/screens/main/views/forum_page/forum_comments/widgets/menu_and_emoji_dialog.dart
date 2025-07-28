import 'package:burla_xatun/cubits/create_comment/create_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';
import 'emoji_bar/emoji_widget.dart';

class MenuAndEmojiDialog extends StatelessWidget {
  const MenuAndEmojiDialog({
    super.key,
    required this.fromTop,
  });
  final double fromTop;

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainnCubit>();
    // final CreateCommentCubit createCommentCubit =
    //     context.read<CreateCommentCubit>();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          right: context.deviceWidth * 0.05,
          top: fromTop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmojiWidget(
                  textEditingController: mainCubit.commentInputTextController),
              71.h,
              SizedBox(
                width: 228,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 32,
                        color: Color.fromARGB(50, 0, 0, 0),
                      ),
                    ],
                    color: Color(0xffF2EDEE),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Ink(
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            onTap: () {
                              context.pop();
                              // mainCubit.updateCommentBoxIndex(-1);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GlobalText(
                                    text: 'Kopyala',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  SvgPicture.asset(
                                      'assets/icons/copy_icon.svg'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5,
                          width: 228,
                          child: ColoredBox(color: Colors.grey),
                        ),
                        Ink(
                          child: InkWell(
                            onTap: () {
                              context.pop(CommentDialog.reply);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GlobalText(
                                    text: 'Cavabla',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  SvgPicture.asset(
                                      'assets/icons/reply_icon.svg'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5,
                          width: 228,
                          child: ColoredBox(color: Colors.grey),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          onTap: () {
                            context.pop();
                            mainCubit.updateCommentBoxIndex(-1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GlobalText(
                                  text: 'Sil',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                                SvgPicture.asset(
                                    'assets/icons/delete_icon.svg'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
