import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/create_forum_contract.dart';
import '../../data/models/remote/response/forum_list_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

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
      final createdForum = Forum.fromJson(response.data);
      emit(state.copyWith(
        createForumStatus: CreateForumStatus.success,
        createdForum: createdForum,
      ));
    } catch (e, s) {
      log('Error occured while creating forum: $e', stackTrace: s);
      emit(state.copyWith(createForumStatus: CreateForumStatus.error));
    }
  }
}
