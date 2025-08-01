import 'package:flutter/material.dart';

import 'forum_input.dart';

class ForumThoughtsInput extends StatelessWidget {
  final TextEditingController controller;

  const ForumThoughtsInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ForumInput(
      textController: controller,
      hintText: 'Fikirlərinizi buraya yaza bilərsiniz',
      topPadding: 26,
      maxLines: 15,
    );
  }
}
