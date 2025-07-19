import 'package:burla_xatun/cubits/user_update/user_update_cubit.dart';
import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/utils/constants/color_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../widgets/global_text.dart';

class DeleteProfileButton extends StatefulWidget {
  const DeleteProfileButton({super.key});

  @override
  State<DeleteProfileButton> createState() => _DeleteProfileButtonState();
}

class _DeleteProfileButtonState extends State<DeleteProfileButton> {
  bool isLoading = false;

  void _deleteProfile() async {
    context.pop(); // Close the dialog

    final userUpdateCuit = context.read<UserUpdateCubit>();

    final response = await userUpdateCuit.userProfileDelete();
    if (response && mounted) {
      context.go('/login');
      locator<LoginTokenService>().deleteSaveByKey("login");
    } else {
      // Handle error case, e.g., show a snackbar or dialog
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Profil silinərkən xəta baş verdi')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userUpdateCuit = context.read<UserUpdateCubit>();
    return GestureDetector(
      onTap: () async {
        showDeleteAccountDialog(context);
      },
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 153, vertical: 15),
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Row(
                    children: [
                      SvgPicture.asset('assets/icons/delete_icon.svg'),
                      SizedBox(width: 21),
                      GlobalText(
                        text: 'Hesabı sil',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff344054),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/icons/log_out_arrow_icon.svg',
                        colorFilter: ColorFilter.mode(
                          Color(0xff344054),
                          BlendMode.srcIn,
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                'Hesabı sil',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Hesabınızı silmək istədiyinizə əminsiniz? Bu əməliyyat geri qaytarıla bilməz.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(height: 1),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _deleteProfile,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: Text(
                            'Bəli',
                            style: const TextStyle(
                              color: ColorConstants.primaryRedColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                      child: const VerticalDivider(
                        width: 1,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false); // "No"
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: Text(
                            'Xeyr',
                            style: const TextStyle(
                              color: ColorConstants.black800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

