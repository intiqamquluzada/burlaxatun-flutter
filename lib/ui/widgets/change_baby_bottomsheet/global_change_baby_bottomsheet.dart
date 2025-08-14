import 'dart:developer';

import 'package:burla_xatun/data/models/remote/response/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/user_data/user_data_cubit.dart';
import '../../../utils/extensions/context_extensions.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../screens/main/views/profil_page/change_profile/widgets/add_child_or_im_pregnant_button.dart';
import '../../screens/main/views/profil_page/change_profile/widgets/child_account_box.dart';

class GlobalChangeBabyBottomsheet extends StatelessWidget {
  const GlobalChangeBabyBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataCubit userDataCubit = context.read<UserDataCubit>();
    final currentBaby = userDataCubit.currentBabyNotifier.value;
    log('${currentBaby?.name}');
    return SizedBox(
      width: context.deviceWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: BlocSelector<UserDataCubit, UserDataState, List<Baby>?>(
            selector: (state) {
              return state.babies;
            },
            builder: (context, state) {
              final children = state ?? [];
              return Column(
                children: [
                  24.h,
                  if (children.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text('Uşaq yoxdur'),
                    )
                  else
                    for (int i = 0; i < children.length; i++) ...[
                      ChildAccountBox(
                        babyName: children[i].name ?? 'Körpə adı tapılmadı',
                        isSelected: userDataCubit.currentBabyNotifier.value ==
                            children[i],
                        onTap: () {
                          log('selected baby: ${children[i]}');
                          userDataCubit.changeProfile(children[i]);
                          context.pop();
                        },
                      ),
                      18.h
                    ],
                  ChildAccountBox(
                    imageUrl:
                        context.read<UserDataCubit>().state.response?.image,
                    babyName: 'Mən',
                    isSelected: currentBaby == null,
                    onTap: () {
                      log('selected baby: ${currentBaby?.name}');
                      userDataCubit.changeProfile(null);
                      context.pop();
                    },
                  ),
                  18.h,
                  AddChildOrImPregnantButton(),
                  33.h,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
