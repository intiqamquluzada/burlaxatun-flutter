import 'package:burla_xatun/cubits/main_cubit/mainn_cubit.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomEmojiBar extends EmojiPickerView {
  const CustomEmojiBar(super.config, super.state, super.showSearchBar,
      this.textEditingController,
      {super.key});

  final TextEditingController textEditingController;

  @override
  State<StatefulWidget> createState() => _CustomEmojiBarState();
}

class _CustomEmojiBarState extends State<CustomEmojiBar> {
  @override
  Widget build(BuildContext context) {
    // Access widget.config, widget.state and widget.showSearchBar
    final emojiList = widget.state.categoryEmoji[1];
    return SizedBox(
      width: 200,
      height: 42,
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Color.fromARGB(130, 0, 0, 0),
            ),
          ],
          color: Color(0xffFCD2EC),
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                onTap: () {
                  context.pop(CommentDialog.emoji);
                  widget.textEditingController.text =
                      ' ${emojiList.emoji[i].emoji}';
                },
                child: Text(emojiList.emoji[i].emoji),
              )
          ],
        ),
      ),
    );
  }
}
