import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_forum_state.dart';

enum CreateForumStatus { initial, success, error, networkError, loading }

class CreateForumCubit extends Cubit<CreateForumState> {
  CreateForumCubit() : super(CreateForumState());

  Future<void> createForum() async {
    try {
      emit(state.copyWith(createForumStatus: CreateForumStatus.loading));
      //
      emit(state.copyWith(createForumStatus: CreateForumStatus.success));
    } catch (e, s) {
      log('Error occured while creating forum: $e', stackTrace: s);
      emit(state.copyWith(createForumStatus: CreateForumStatus.error));
    }
  }
}
