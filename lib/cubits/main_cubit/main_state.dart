// @immutable
// abstract class MainnState extends Equatable {
//   const MainnState();

//   @override
//   List<Object?> get props => [];
// }
// extends MainnState
import 'package:burla_xatun/cubits/main_cubit/mainn_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MainInitial extends Equatable {
  const MainInitial({
    required this.indexOfView,
    required this.viewName,
    required this.ultrasoundFormat,
    required this.carouselIndex,
    required this.latestScrollPosition,
    required this.genderOption,
    required this.nameViewOptions,
    required this.profileViewName,
    required this.isFirstChild,
    required this.isShowQuestion,
    required this.selectedQuestionBox,
    required this.navigationShellContext,
    required this.isOverlayVisible,
    required this.commentBoxIndex,
    required this.userTag,
    required this.replyBoxIndex,
    // required this.menuOption,
    required this.commentDialog,
  });

  final int carouselIndex;
  final int indexOfView;
  final int selectedQuestionBox;
  final int commentBoxIndex;
  final double latestScrollPosition;
  final String viewName;
  final String profileViewName;
  final String? userTag;
  final UltrasoundFormat ultrasoundFormat;
  final NameViewOption nameViewOptions;
  // final MenuOption menuOption;
  final GenderOption genderOption;
  final bool isFirstChild;
  final bool isShowQuestion;
  final bool isOverlayVisible;
  final BuildContext? navigationShellContext;
  final int replyBoxIndex;
  final CommentDialog? commentDialog;

  @override
  List<Object?> get props => [
        indexOfView,
        viewName,
        ultrasoundFormat,
        carouselIndex,
        latestScrollPosition,
        genderOption,
        nameViewOptions,
        profileViewName,
        isFirstChild,
        isShowQuestion,
        selectedQuestionBox,
        navigationShellContext,
        isOverlayVisible,
        commentBoxIndex,
        userTag,
        replyBoxIndex,
        commentDialog,
      ];

  MainInitial copyWith({
    int? indexOfView,
    int? carouselIndex,
    int? selectedQuestionBox,
    int? commentBoxIndex,
    String? viewName,
    String? profileViewName,
    String? userTag,
    UltrasoundFormat? ultrasoundFormat,
    NameViewOption? nameViewOptions,
    GenderOption? genderOption,
    double? latestScrollPosition,
    bool? isFirstChild,
    bool? isShowQuestion,
    bool? isOverlayVisible,
    BuildContext? navigationShellContext,
    Offset? commentTapUpBox,
    int? replyBoxIndex,
    CommentDialog? commentDialog,
  }) {
    return MainInitial(
      indexOfView: indexOfView ?? this.indexOfView,
      viewName: viewName ?? this.viewName,
      ultrasoundFormat: ultrasoundFormat ?? this.ultrasoundFormat,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      latestScrollPosition: latestScrollPosition ?? this.latestScrollPosition,
      genderOption: genderOption ?? this.genderOption,
      nameViewOptions: nameViewOptions ?? this.nameViewOptions,
      profileViewName: profileViewName ?? this.profileViewName,
      isFirstChild: isFirstChild ?? this.isFirstChild,
      isShowQuestion: isShowQuestion ?? this.isShowQuestion,
      selectedQuestionBox: selectedQuestionBox ?? this.selectedQuestionBox,
      navigationShellContext:
          navigationShellContext ?? this.navigationShellContext,
      isOverlayVisible: isOverlayVisible ?? this.isOverlayVisible,
      commentBoxIndex: commentBoxIndex ?? this.commentBoxIndex,
      userTag: userTag ?? this.userTag,
      replyBoxIndex: replyBoxIndex ?? this.replyBoxIndex,
      commentDialog: commentDialog ?? this.commentDialog,
    );
  }
}
