import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/create_forum/create_forum_cubit.dart';
import '../../../../../../../cubits/forum_list/forum_list_cubit.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../widgets/global_text.dart';

class NewForumAppbar extends StatelessWidget implements PreferredSizeWidget {
  const NewForumAppbar({
    super.key,
    required this.onTap,
    required this.send,
  });

  final void Function() onTap;
  final void Function() send;

  @override
  Widget build(BuildContext context) {
    final forumListCubit = context.read<ForumListCubit>();
    // context.read<ForumListCubit>();
    return SafeArea(
      minimum: EdgeInsets.only(top: 32),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.close_rounded,
              size: 34,
              color: Color(0xff344054),
            ),
          ),
        ),
        title: GlobalText(
          text: 'Yeni Forum',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xff344054),
        ),
        actions: [
          BlocConsumer<CreateForumCubit, CreateForumState>(
            listener: (context, state) {
              if (state.createForumStatus == CreateForumStatus.success) {
                AppSnackbars.success(context, 'Forum uğurla əlavə olundu');
                forumListCubit.addCreatedForumToList(state.createdForum!);
                // forumListCubit.getForumList(isRefresh: true);

                context.pop();
              } else if (state.createForumStatus == CreateForumStatus.error) {
                AppSnackbars.error(context, 'Forum yaradarkən xəta baş verdi');
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: send,
                child: Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: SvgPicture.asset(
                    'assets/icons/forum_send_icon.svg',
                    color: state.createForumStatus == CreateForumStatus.loading
                        ? ColorConstants.gray400
                        : ColorConstants.primaryRedColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 70);
}
