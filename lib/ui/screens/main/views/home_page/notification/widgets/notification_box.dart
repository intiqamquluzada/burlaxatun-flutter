import 'package:burla_xatun/ui/screens/main/views/home_page/notification/widgets/from_admin_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../cubits/delete_comment/delete_comment_cubit.dart';
import '../../../../../../../cubits/edit_comment/edit_comment_cubit.dart';
import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
import '../../../../../../../cubits/forum_detail/forum_detail_cubit.dart';
import '../../../../../../../data/models/remote/response/notifications_model.dart';
import '../../../../../../../utils/di/locator.dart';
import '../../../forum_page/forum_comments/forum_comments_page.dart';
import 'from_user_notification.dart';

class NotificationBox extends StatefulWidget {
  const NotificationBox({
    super.key,
    required this.notification,
  });

  final NotificationsModel notification;

  @override
  State<NotificationBox> createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  late final void Function()? onNotification;
  late final void Function()? fromUser;
  @override
  void initState() {
    super.initState();

    fromUser = () {
      final forumSlug = widget.notification.forumSlug ?? '';
      final forumId = widget.notification.forumId ?? -1;
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    locator<ForumDetailCubit>()..getForumDetail(forumSlug),
              ),
              BlocProvider(
                create: (context) => locator<ForumCommentsCubit>()
                  ..getForumComments(forumId: forumId),
              ),
              BlocProvider(
                create: (context) => locator<CreateCommentCubit>(),
              ),
              BlocProvider(
                create: (context) => locator<DeleteCommentCubit>(),
              ),
              BlocProvider(
                create: (context) => locator<EditCommentCubit>(),
              ),
            ],
            child: ForumCommentsPage(forumId: forumId),
          ),
        ),
      );
    };
    onNotification = widget.notification.fromUser != null ? fromUser : () {};
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNotification,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffE4E7EC),
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: widget.notification.fromUser != null
              ? FromUserNotification(
                  image: widget.notification.fromUser?.image,
                  fullName: widget.notification.fromUser?.fullName,
                  createdAt: widget.notification.createdAt,
                  text: widget.notification.text,
                )
              : FromAdminNotification(
                  title: widget.notification.title ?? 'Başlıq tapılmadı',
                  text: widget.notification.text ?? 'Tapılmadı',
                ),
        ),
      ),
    );
  }
}
