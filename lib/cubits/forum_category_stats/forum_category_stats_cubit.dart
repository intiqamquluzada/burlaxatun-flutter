import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/forum_category_stats_contract.dart';
import '../../data/models/remote/response/forum_category_stats_model.dart';
import '../../utils/di/locator.dart';
import '../forum_category/forum_category_cubit.dart';

part 'forum_category_stats_state.dart';

enum CategoryStatsStatus { inital, loading, success, error, networkError }

class ForumCategoryStatsCubit extends Cubit<ForumCategoryStatsState> {
  ForumCategoryStatsCubit(this.forumCategoryStatsContract)
      : super(ForumCategoryStatsState());

  final ForumCategoryStatsContract forumCategoryStatsContract;
  final ForumCategoryCubit forumCategoryCubit = locator<ForumCategoryCubit>();
  final List<ForumCategoryStatsModel> sortedCategoryStatsList = [];

  List<ForumCategoryStats> statList = [];
  String? url = '';

  Future<void> getCategoryStatistics() async {
    log('request for statistics');
    if (url == null ||
        state.categoryStatsStatus == CategoryStatsStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(categoryStatsStatus: CategoryStatsStatus.loading));
      final response = await forumCategoryStatsContract.getCategoryStats(
        url: url!.isEmpty ? null : url,
      );
      final data = ForumCategoryStatsModel.fromJson(response.data);
      // final sortedList = unsortedCategoryStatsList.results?.reversed.toList();

      url = data.next;

      data.results?.forEach((e) {
        statList.add(e);
      });

      // final reversedList = statList;

      emit(state.copyWith(
        categoryStatsStatus: CategoryStatsStatus.success,
        categoryStatsList: List.from(statList),
      ));
    } catch (e, s) {
      emit(state.copyWith(categoryStatsStatus: CategoryStatsStatus.error));
      log('Error occured while getting category statistics; $e', stackTrace: s);
    }
  }

  // void sortStatsList(List<ForumCategoryStatsModel> unsortedCategoryStatsList) {
  //   final categories = (state as ForumCategorySuccess).response;
  //   for (var i = 0; i < unsortedCategoryStatsList.length; i++) {
  //     for (var j = 0; j < unsortedCategoryStatsList.length; j++) {
  //       if (categories[i].id == unsortedCategoryStatsList[j].id) {
  //         sortedCategoryStatsList.add(unsortedCategoryStatsList[i]);
  //         break;
  //       }
  //     }
  //   }
  // }
}
