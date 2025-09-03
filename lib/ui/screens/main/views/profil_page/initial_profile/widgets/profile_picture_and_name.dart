import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../../cubits/user_update/user_update_cubit.dart';
import '../../../../../../../utils/constants/text_constants.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../utils/helper/image_picker_helper.dart';
import '../../../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../../../widgets/global_text.dart';

class ProfilePictureAndName extends StatefulWidget {
  const ProfilePictureAndName({super.key});

  @override
  State<ProfilePictureAndName> createState() => _ProfilePictureAndNameState();
}

class _ProfilePictureAndNameState extends State<ProfilePictureAndName> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  late final UserDataCubit _userDataCubit;
  late final UserUpdateCubit _userUpdateCubit;

  @override
  void initState() {
    _userDataCubit = context.read<UserDataCubit>();
    _userUpdateCubit = context.read<UserUpdateCubit>();
    // _userDataCubit.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (_, state) {
        if (state.status == UserDataStatus.loading) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state.status == UserDataStatus.failure) {
          return const Center(
            child: Text('Xəta'),
          );
        }
        if (state.status == UserDataStatus.networkError) {
          return const Center(
            child: Text('Şəbəkə xətası'),
          );
        }
        if (state.status == UserDataStatus.success) {
          final data = state.response;
          return Column(
            children: [
              const GlobalText(
                text: 'Mənim Profilim',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              16.h,
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageFile != null
                            ? FileImage(imageFile!)
                            : (data?.image != null
                                    ? NetworkImage(data!.image!)
                                    : NetworkImage(
                                        TextConstants.defaultProfileImage)
                                // const AssetImage('assets/png/pfp.png'),
                                ) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        ImagePickerHelper.pickAndUploadImage(
                          context: context,
                          userDataCubit: _userDataCubit,
                          userUpdateCubit: _userUpdateCubit,
                          onImagePicked: (pickedImage) {
                            setState(() {
                              imageFile = pickedImage;
                            });
                          },
                        );
                      },
                      child: SizedBox(
                        height: 28,
                        width: 28,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEC407A),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: SvgPicture.asset(
                              'assets/icons/camera_icon.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              16.h,
              GlobalText(
                text: data?.fullName ?? 'İstifadəçi',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
