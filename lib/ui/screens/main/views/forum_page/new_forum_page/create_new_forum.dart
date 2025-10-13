import 'package:burla_xatun/cubits/create_forum/create_forum_cubit.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utils/extensions/num_extensions.dart';
import 'widgets/forum_thoughts_input.dart';
import 'widgets/forum_title_input.dart';
import 'widgets/new_forum_appbar.dart';

class CreateNewForum extends StatefulWidget {
  const CreateNewForum({
    super.key,
    this.categoryId,
  });

  final int? categoryId;

  @override
  State<CreateNewForum> createState() => _CreateNewForumState();
}

class _CreateNewForumState extends State<CreateNewForum> {
  late final TextEditingController thoughController;
  late final CreateForumCubit createForumCubit;
  @override
  void initState() {
    thoughController = TextEditingController();
    createForumCubit = context.read<CreateForumCubit>();
    super.initState();
  }

  @override
  void dispose() {
    thoughController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewForumAppbar(
        onTap: () {
          context.pop();
        },
        send: () async {
          if (thoughController.text.isEmpty) {
            AppSnackbars.error(context, 'Fikirlərinizi qeyd edin.');
            return;
          }
          await createForumCubit.createForum(
            categoryId: widget.categoryId!,
            text: thoughController.text.trim(),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              22.h,
              ForumTitleInput(),
              32.h,
              ForumThoughtsInput(
                controller: thoughController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}