import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/baby_names_cubit/baby_names_cubit.dart';
import '../../../../../../../utils/constants/padding_constants.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import 'widgets/boy_names.dart';
import 'widgets/girl_names.dart';
import 'widgets/select_gender_box.dart';

class GenderNames extends StatefulWidget {
  const GenderNames({
    super.key,
    required this.countryId,
  });

  final String countryId;

  @override
  State<GenderNames> createState() => _GenderNamesState();
}

class _GenderNamesState extends State<GenderNames> {
  late BabyNamesCubit babyNamesCubit;
  late PageController _pageController;
  late ValueNotifier<int> genderScreenIndex;

  @override
  void initState() {
    genderScreenIndex = ValueNotifier<int>(0);
    babyNamesCubit = context.read<BabyNamesCubit>();
    _pageController = PageController(initialPage: 0);
    // babyNamesCubit = context.read<BabyNamesCubit>()..getNames(widget.countryId);
    super.initState();
  }

  @override
  void dispose() {
    babyNamesCubit.resetGenderList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Adlar',
        onLeadingTap: () {
          context.pop();
          // babyNamesCubit.changeIsSelected(v: -1);
        },
      ),
      body: Padding(
        padding: PaddingConstants.h20,
        child: Center(
          child: Column(
            children: [
              14.h,
              SelectGenderBox(
                genderScreenIndex: genderScreenIndex,
                pageController: _pageController,
              ),
              24.h,
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    BoyNames(countryId: widget.countryId),
                    GirlNames(countryId: widget.countryId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
