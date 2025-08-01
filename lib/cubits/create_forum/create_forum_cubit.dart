import 'dart:developer';

import 'package:burla_xatun/data/contractor/create_comment_contract.dart';
import 'package:burla_xatun/data/contractor/create_forum_contract.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_forum_state.dart';

enum CreateForumStatus { initial, success, error, networkError, loading }

class CreateForumCubit extends Cubit<CreateForumState> {
  CreateForumCubit(this.createForumContract) : super(CreateForumState());

  final CreateForumContract createForumContract;

  Future<void> createForum({
    required int categoryId,
    required String text,
  }) async {
    try {
      emit(state.copyWith(createForumStatus: CreateForumStatus.loading));
      final response = await createForumContract.createForum(
        categoryId: categoryId,
        text: text,
      );
      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(createForumStatus: CreateForumStatus.success));
    } catch (e, s) {
      log('Error occured while creating forum: $e', stackTrace: s);
      emit(state.copyWith(createForumStatus: CreateForumStatus.error));
    }
  }
}
