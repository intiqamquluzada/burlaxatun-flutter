import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../data/models/remote/response/user_data_model.dart';
import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/global_appbar.dart';
import 'widgets/add_child_or_im_pregnant_button.dart';
import 'widgets/child_account_box.dart';

class ChangeProfile extends StatelessWidget {
  const ChangeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataCubit userDataCubit = context.read<UserDataCubit>();
    final currentBaby = userDataCubit.currentBabyNotifier.value;
    log('${currentBaby?.name}');
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: GlobalAppbar(
        title: 'Profili dəyiş',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: BlocSelector<UserDataCubit, UserDataState, List<Baby>?>(
            selector: (state) {
              return state.babies;
            },
            builder: (context, state) {
              final children = state ?? [];
              return ValueListenableBuilder(
                valueListenable: userDataCubit.currentBabyNotifier,
                builder: (context, baby, child) {
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
                            isSelected: baby == children[i],
                            // userDataCubit.currentBabyNotifier.value ==
                            // children[i],
                            onTap: () {
                              log('selected baby: ${children[i]}');
                              userDataCubit.changeProfile(children[i]);
                            },
                          ),
                          18.h
                        ],
                      ChildAccountBox(
                        imageUrl:
                            context.read<UserDataCubit>().state.response?.image,
                        babyName: 'Özüm',
                        isSelected: baby == null,
                        onTap: () {
                          log('selected baby: ${currentBaby?.name}');
                          userDataCubit.changeProfile(null);
                          // context.pop();
                        },
                      ),
                      18.h,
                      AddChildOrImPregnantButton(
                        onTap: () {
                          context.push('/questions', extra: true);
                        },
                        icon: 'assets/icons/add_pregnancy_icon.svg',
                        buttonName: 'Hamiləyəm',
                      ),
                      10.h,
                      AddChildOrImPregnantButton(
                        onTap: () {
                          context.push('/add_child', extra: true);
                        },
                        icon: 'assets/icons/add_child_icon.svg',
                        buttonName: 'Uşaq əlavə edin',
                      ),
                      33.h,
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),

      // Center(
      //   child: Column(
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {

      //           context.push('/questions', extra: true);
      //         },
      //         child: Text('hamileyem'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
