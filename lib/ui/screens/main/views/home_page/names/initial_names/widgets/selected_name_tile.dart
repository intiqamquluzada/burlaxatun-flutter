import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../cubits/baby_names_cubit/baby_names_cubit.dart';
import '../../../../../../../../utils/constants/color_constants.dart';

class SelectedNameTile extends StatelessWidget {
  const SelectedNameTile({
    super.key,
    required this.name,
    required this.nameId,
  });

  final String name;
  final int nameId;

  @override
  Widget build(BuildContext context) {
    final babyNamesCubit = context.read<BabyNamesCubit>();
    return ListTile(
      title: Text(name),
      trailing: GestureDetector(
        onTap: () async {
          babyNamesCubit.removeFromWishList(babyNameId: nameId);
        },
        child: BlocBuilder<BabyNamesCubit, BabyNamesState>(
          buildWhen: (previous, current) {
            return previous.selectNameStatus != current.selectNameStatus;
          },
          builder: (context, state) {
            return SvgPicture.asset(
              'assets/icons/favorite_icon.svg',
              colorFilter: ColorFilter.mode(
                // state.selectNameStatus == SelectNameStatus.loading
                // ? ColorConstants.hintTextColor
                // :
                ColorConstants.primaryRedColor,
                BlendMode.srcIn,
              ),
            );
          },
        ),
      ),
    );
  }
}
