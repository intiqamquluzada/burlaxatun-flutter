import 'package:burla_xatun/utils/helper/past_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../../widgets/global_text.dart';

class LastDays extends StatelessWidget {
  const LastDays({
    super.key,
    this.createdAt,
  });

  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    final lastDays = createdAt != null
        ? 'Son ${PastHelper.timeAgo(createdAt!)}'
        : 'tapılmadı';
    return GlobalText(
      text: lastDays,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xff414651),
    );
  }
}
