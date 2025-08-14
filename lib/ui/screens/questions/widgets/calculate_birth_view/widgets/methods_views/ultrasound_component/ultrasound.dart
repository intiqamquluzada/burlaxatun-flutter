import 'package:flutter/material.dart';

import 'widgets/ultrasound_days_box.dart';
import 'widgets/ultrasound_weeks_box.dart';

class Ultrasound extends StatelessWidget {
  const Ultrasound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UltrasoundWeeksBox(),
          SizedBox(width: 12),
          UltrasoundDaysBox(),
        ], 
      ),
    );
  }
}
