import 'package:burla_xatun/cubits/baby_names_cubit/baby_names_cubit.dart';
import 'package:burla_xatun/data/models/remote/response/selected_names_model.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class GirlNameTile extends StatefulWidget {
  const GirlNameTile({
    super.key,
    required this.name,
    required this.babyNameId,
    required this.isSelectedName,
  });
  final String name;
  final int babyNameId;
  final ValueNotifier<bool> isSelectedName;
  @override
  State<GirlNameTile> createState() => _GirlNameTileState();
}

class _GirlNameTileState extends State<GirlNameTile> {
  late BabyNamesCubit babyNamesCubit;

  @override
  void initState() {
    babyNamesCubit = context.read<BabyNamesCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isSelectedName = ValueNotifier<bool>(false);
    for (SelectedName e in babyNamesCubit.selectedNames ?? []) {
      if (e.babyName == widget.name) {
        isSelectedName.value = true;
      }
    }
    return ListTile(
      title: Text(widget.name),
      trailing: GestureDetector(
        onTap: () async {
          isSelectedName.value = !isSelectedName.value;
          if (isSelectedName.value) {
            final isAdded = await babyNamesCubit.addToWishList(
              babyNameId: widget.babyNameId,
              selectedName: SelectedName(
                babyName: widget.name,
                id: widget.babyNameId,
              ),
            );
            if (isAdded == false) {
              isSelectedName.value = !isSelectedName.value;
              AppSnackbars.error(context, 'ad siyahıya əlavə edilmədi');
            }
          } else {
            babyNamesCubit.removeFromWishList(babyNameId: widget.babyNameId);
          }
        },
        child: ValueListenableBuilder(
          valueListenable: isSelectedName,
          builder: (context, value, child) {
            return SvgPicture.asset(
              'assets/icons/favorite_icon.svg',
              colorFilter: ColorFilter.mode(
                value
                    ? ColorConstants.primaryRedColor
                    : ColorConstants.hintTextColor,
                BlendMode.srcIn,
              ),
            );
          },
        ),
      ),
    );
  }
}
