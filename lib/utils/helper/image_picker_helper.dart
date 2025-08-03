import 'dart:io';

import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:burla_xatun/cubits/user_update/user_update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImageFromDialog(BuildContext context) async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Şəkil seçin'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text('Kamera'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text('Qalereya'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    }
    return null;
  }

  static Future<void> pickAndUploadImage({
    required BuildContext context,
    required UserDataCubit userDataCubit,
    required UserUpdateCubit userUpdateCubit,
    required Function(File imageFile) onImagePicked,
  }) async {
    final pickedImage = await pickImageFromDialog(context);

    if (pickedImage != null) {
      onImagePicked(pickedImage);

      final user = userDataCubit.state.response;

      if (user != null) {
        await userUpdateCubit.updateUser(
          image: pickedImage,
        );
      }
    }
  }
}
