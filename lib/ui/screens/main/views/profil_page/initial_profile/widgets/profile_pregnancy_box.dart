import 'package:burla_xatun/cubits/baby_update/baby_update_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../../cubits/user_update/user_update_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../../../widgets/global_text.dart';

class ProfilePregnancyBox extends StatefulWidget {
  const ProfilePregnancyBox({super.key});

  @override
  State<ProfilePregnancyBox> createState() => _ProfilePregnancyBoxState();
}

class _ProfilePregnancyBoxState extends State<ProfilePregnancyBox> {
  late UserDataCubit userDataCubit;
  late UserUpdateCubit userUpdateCubit;
  late BabyUpdateCubit babyUpdateCubit;
  late ValueNotifier<bool> isFirstChildNotifier;
  late ValueNotifier<bool> isMiscarryNotifier;
  late ValueNotifier<bool> isBornNotifier;
  @override
  void initState() {
    userDataCubit = context.read<UserDataCubit>();
    userUpdateCubit = context.read<UserUpdateCubit>();
    babyUpdateCubit = context.read<BabyUpdateCubit>();
    final isFirstChild = userDataCubit.state.response?.firstChild ?? false;
    final isMiscarry = false;
    final isBorn = userDataCubit.state.response?.isPregnant ?? false;
    isFirstChildNotifier = ValueNotifier<bool>(isFirstChild);
    isMiscarryNotifier = ValueNotifier<bool>(isMiscarry);
    isBornNotifier = ValueNotifier<bool>(!isBorn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final mainCubit = context.read<MainnCubit>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (_, state) {
              if (state.status == UserDataStatus.loading) {
                return Center(
                  child: CustomCircularProgressIndicator(),
                );
              }
              if (state.status == UserDataStatus.failure) {
                return Center(
                  child: Text('Xəta'),
                );
              }
              if (state.status == UserDataStatus.networkError) {
                return Center(
                  child: Text('Şəbəkə xətası'),
                );
              }

              if (state.status == UserDataStatus.success) {
                final data = state.response;
                final baby = data?.babies?.isNotEmpty == true
                    ? data!.babies!.first
                    : null;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: 'Hamiləlik',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    32.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Körpənin cinsi',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        GlobalText(
                          text: baby?.gender ?? 'Bilinmir',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Körpənin adı',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        SizedBox(
                          width: 75,
                          height: 37,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: baby?.name?.isNotEmpty == true
                                  ? baby!.name!
                                  : 'Daxil edin',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff98A2B3),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Doğum tarixi',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        GlobalText(
                          text: baby?.birthDate != null
                              ? DateFormat('dd.MM.yyyy')
                                  .format(baby!.birthDate!)
                              : 'Yoxdur',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GlobalText(
                    //       text: 'Doğum tarixini hesabla',
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w500,
                    //       color: Color(0xff344054),
                    //     ),
                    //     SvgPicture.asset('assets/icons/arrow_right.svg'),
                    //   ],
                    // ),
                    // 14.h,
                    // ColoredBox(
                    //   color: Color(0xffF2F4F7),
                    //   child: SizedBox(
                    //     height: 1,
                    //     width: MediaQuery.of(context).size.width,
                    //   ),
                    // ),
                    // 14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'İlk uşaqdır?',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        ValueListenableBuilder(
                          valueListenable: isFirstChildNotifier,
                          builder: (context, value, child) {
                            return CupertinoSwitch(
                              dragStartBehavior: DragStartBehavior.down,
                              value: value,
                              onChanged: (v) async {
                                await babyUpdateCubit.updateBabyData(
                                  isFirst: v,
                                );
                                isFirstChildNotifier.value = v;
                              },
                            );
                          },
                        ),
                        // CupertinoSwitch(
                        //   dragStartBehavior: DragStartBehavior.down,
                        //   value: baby?.isFirst ?? false,
                        //   onChanged: (_) {},
                        // ),
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Dölünüz düşübmü?',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        ValueListenableBuilder(
                          valueListenable: isMiscarryNotifier,
                          builder: (context, value, child) {
                            return CupertinoSwitch(
                              dragStartBehavior: DragStartBehavior.down,
                              value: value,
                              onChanged: (v) async {
                                await babyUpdateCubit.updateBabyData(
                                  haveMiscarriage: v,
                                );
                                isMiscarryNotifier.value = v;
                              },
                            );
                          },
                        ),
                        // CupertinoSwitch(
                        //   dragStartBehavior: DragStartBehavior.down,
                        //   value: baby?.haveMiscarriage ?? false,
                        //   onChanged: (_) {},
                        // ),
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GlobalText(
                            text: 'Körpəniz artıq doğulubmu?',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff344054),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: isBornNotifier,
                          builder: (context, value, child) {
                            return CupertinoSwitch(
                              dragStartBehavior: DragStartBehavior.down,
                              value: value,
                              onChanged: (v) async {
                                babyUpdateCubit.updateBabyData(
                                  haveBorn: v,
                                );
                                // await Future.wait([
                                //   userUpdateCubit.updateUser(
                                //     isPregnant: !v,
                                //   ),
                                //   babyUpdateCubit.updateBabyData(
                                //     haveBorn: v,
                                //   ),
                                // ]);
                                isBornNotifier.value = v;
                              },
                            );
                          },
                        ),
                        // CupertinoSwitch(
                        //   dragStartBehavior: DragStartBehavior.down,
                        //   value: baby?.haveBorn ?? false,
                        //   onChanged: (_) {},
                        // ),
                      ],
                    ),
                  ],
                );
              }

              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
