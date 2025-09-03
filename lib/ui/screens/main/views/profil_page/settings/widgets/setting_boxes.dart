import 'package:burla_xatun/data/models/local/settings_items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../../cubits/user_update/user_update_cubit.dart';
import 'setting_box.dart';

class SettingBoxes extends StatefulWidget {
  const SettingBoxes({super.key});

  @override
  State<SettingBoxes> createState() => _SettingBoxesState();
}

class _SettingBoxesState extends State<SettingBoxes> {
  late MainCubit mainCubit;
  late UserDataCubit userDataCubit;
  late UserUpdateCubit userUpdateCubit;
  late ValueNotifier<bool> isEnableNotification;
  late final List<SettingsItemModel> settingItems;
  @override
  void initState() {
    mainCubit = context.read<MainCubit>();
    userDataCubit = context.read<UserDataCubit>();
    userUpdateCubit = context.read<UserUpdateCubit>();
    isEnableNotification = ValueNotifier<bool>(
        userDataCubit.state.response?.enableNotifications ?? false);
    settingItems = SettingsItemModel.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < settingItems.length ; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SettingBox(
              rightWidget: i != 0
                  ? SvgPicture.asset('assets/icons/arrow_right.svg')
                  : ValueListenableBuilder(
                      valueListenable: isEnableNotification,
                      builder: (context, value, child) {
                        return CupertinoSwitch(
                          dragStartBehavior: DragStartBehavior.down,
                          value: value,
                          onChanged: (v) async {
                            await userUpdateCubit.updateUser(
                                enableNotifications: v);
                            isEnableNotification.value = v;
                          },
                        );
                      },
                    ),
              boxIcon: settingItems[i].icon,
              boxName: settingItems[i].settingName,
              onTap: () => mainCubit.tapSettingTile(context, i),
            ),
          ),
      ],
    );
  }
}
