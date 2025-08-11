import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import 'widgets/delete_profile_button.dart';
import 'widgets/log_out_button.dart';
import 'widgets/my_profile_box.dart';
import 'widgets/profile_page_sections.dart';
import 'widgets/profile_picture_and_name.dart';
import 'widgets/profile_pregnancy_box.dart';

class InitialProfilePage extends StatefulWidget {
  const InitialProfilePage({super.key});

  @override
  State<InitialProfilePage> createState() => _InitialProfilePageState();
}

class _InitialProfilePageState extends State<InitialProfilePage> {
  @override
  void initState() {
    super.initState();
    // context.read<UserDataCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userDataCubit = context.read<UserDataCubit>();
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  24.h,
                  ProfilePictureAndName(),
                  24.h,
                  ProfilePageSections(),
                  12.h,
                  Visibility(
                    visible: userDataCubit.state.response?.isPregnant ?? false,
                    child: Column(
                      children: [
                        ProfilePregnancyBox(),
                        12.h,
                      ],
                    ),
                  ),
                  MyProfileBox(),
                  12.h,
                  ColoredBox(
                    color: Color(0xffE8E8E8),
                    child: SizedBox(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  12.h,
                  LogOutButton(),
                  12.h,
                  DeleteProfileButton(),
                  24.h,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
