import 'package:flutter/material.dart';

import '../../../../../../widgets/global_text.dart';

class ForumTitle extends StatelessWidget {
  const ForumTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GlobalText(
          text: 'Hamiləlik və reproduktiv sağlamlıq',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ],
    );
  }
}
