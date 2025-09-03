import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

import 'custom_emoji_bar.dart';

class EmojiWidget extends StatelessWidget {
  const EmojiWidget({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      // onEmojiSelected: (Category? category, Emoji emoji) {
      //   textEditingController.text += emoji.emoji;
      // },
      // onBackspacePressed: () {
      //   // Do something when the user taps the backspace button (optional)
      //   // Set it to null to hide the Backspace-Button
      // },
      customWidget: (config, state, showSearchBar) {
        return CustomEmojiBar(
          config,
          state,
          showSearchBar,
          textEditingController,
        );
      },
      textEditingController: textEditingController,
      config: Config(
        height: 50,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        viewOrderConfig: const ViewOrderConfig(
          top: EmojiPickerItem.categoryBar,
          middle: EmojiPickerItem.emojiView,
          bottom: EmojiPickerItem.searchBar,
        ),
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(),
        searchViewConfig: const SearchViewConfig(),
      ),
    );
  }
}
