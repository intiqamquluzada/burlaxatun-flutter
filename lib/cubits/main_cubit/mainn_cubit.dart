import 'dart:developer';

import 'package:burla_xatun/data/models/local/medicine_detail_items_model.dart';
import 'package:burla_xatun/data/models/remote/response/medicine/medicines_model.dart';
import 'package:burla_xatun/ui/screens/main/views/daily_advise_page/advice_page.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/my_healing_page/my_medicines/initial_medicine_page/widgets/edit_medicine_dialog.dart';
import 'package:burla_xatun/ui/screens/main/views/profil_page/settings/setting_views/change_password/change_password_page/change_password_page.dart';
import 'package:burla_xatun/ui/screens/main/views/profil_page/settings/setting_views/change_phone_number/change_phone_number_view.dart';
import 'package:burla_xatun/ui/screens/main/views/profil_page/using_rules/using_rules_screen.dart';
import 'package:burla_xatun/ui/widgets/change_baby_bottomsheet/global_change_baby_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/local/bottom_navbar_items_model.dart';
import '../../data/models/local/main_page_box_model.dart';
import '../../data/models/local/my_healing_card_items_model.dart';
import '../../data/models/local/profile_sections_items_model.dart';
import '../../data/models/local/settings_items_model.dart';
import '../../ui/screens/main/views/forum_page/forum_comments/forum_comments_page.dart';
import '../../ui/screens/main/views/forum_page/forum_comments/widgets/menu_and_emoji_dialog.dart';
import '../../ui/screens/main/views/forum_page/main_forum_page.dart/forum_page.dart';
import '../../ui/screens/main/views/home_page/home.dart';
import '../../ui/screens/main/views/home_page/home/home_page.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/indicator_data_screen/widgets/add_new_indicator_dialog.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/indicator_data_screen/widgets/calendar_dialog.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/initial_my_healing_page/my_healing_page.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/my_medicines/initial_medicine_page/my_medicines_page.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/my_medicines/initial_medicine_page/widgets/add_medicine_dialog.dart';
import '../../ui/screens/main/views/home_page/notification/notification_page.dart';
import '../../ui/screens/main/views/home_page/ultrasound/ultrasound_page.dart';
import '../../ui/screens/main/views/home_page/video/video_page.dart';
import '../../ui/screens/main/views/profil_page/about_us/about_us_view.dart';
import '../../ui/screens/main/views/profil_page/contact_us/contact_us_view.dart';
import '../../ui/screens/main/views/profil_page/faq/faq_view.dart';
import '../../ui/screens/main/views/profil_page/initial_profile/initial_profile_page.dart';
import '../../ui/screens/main/views/profil_page/pricavy_policy/privacy_policy_view.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_view.dart';
import '../../ui/screens/main/views/profil_page/special_thanks/special_thanks_view.dart';
import 'main_state.dart';

enum UltrasoundFormat { format2d, format3d }

enum NameViewOption { countries, selecteds }

enum GenderOption { boy, girl }

enum CommentDialog { copy, reply, delete, emoji }

class MainnCubit extends Cubit<MainInitial> {
  MainnCubit()
      : super(
          MainInitial(
            indexOfView: 0,
            viewName: 'Home',
            profileViewName: 'initial_profile',
            carouselIndex: 0,
            latestScrollPosition: 0,
            genderOption: GenderOption.boy,
            nameViewOptions: NameViewOption.countries,
            ultrasoundFormat: UltrasoundFormat.format2d,
            isFirstChild: true,
            isShowQuestion: false,
            selectedQuestionBox: -1,
            navigationShellContext: null,
            isOverlayVisible: false,
            commentBoxIndex: -1,
            userTag: null,
            // menuOption: null,
          ),
        );

  final ScrollController homePageScrollController = ScrollController();
  final FocusNode commentInputFocusNode = FocusNode();
  late TextEditingController commentInputTextController;

  final navbarItems = BottomNavbarItemsModel.items;
  final boxItems = MainPageBoxModel.items;

  final myHealingCardItems = MyHealingCardItemsModel.items;
  final settingItems = SettingsItemModel.items;
  final medicineDetailItems = MedicineDetailItemsModel.items;

  final List views = [
    Home(),
    MainForumPage(),
    MyHealingPage(),
    InitialProfilePage(),
  ];

  final Map<String, Widget> profileViews = {
    'initial_profile': InitialProfilePage(),
    'settings': SettingView(),
    'faq': FaqView(),
    'about_us': AboutUsView(),
    'contact_us': ContactUsView(),
    'terms_of_use': UsingRulesScreen(),
    'privacy_policy': PrivacyPolicyView(),
    'special_thanks': SpecialThanksView(),
  };

  final Map<String, Widget> homePageViews = {
    'Home': HomePage(),
    'Gündəlik Tövsiyyələr': AdvicePage(),
    'Ultrasəs': UltrasoundPage(),
    'Notification': NotificationPage(),
    'Videolar': VideoPage(),
    'Dərmanlar': MyHealingPage(),
  };

  void showMenuDialogAndEmojis(BuildContext context, double v) {
    showDialog<CommentDialog>(
      useSafeArea: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return MenuAndEmojiDialog(fromTop: v);
      },
    ).then((onValue) {
      emit(state.copyWith(commentBoxIndex: -1));
      log('$onValue');
      if (onValue != null) {
        switch (onValue) {
          case CommentDialog.copy:
          case CommentDialog.delete:
          case CommentDialog.reply:
            emit(state.copyWith(userTag: '@Nihad '));
            commentInputTextController.text = state.userTag!;
            commentInputFocusNode.requestFocus();

          case CommentDialog.emoji:
            // commentInputTextController.text = state.userTag!;
            commentInputFocusNode.requestFocus();
        }
      }
    });
  }

  void onEmoji() {}

  void setShellContext(v) {
    emit(state.copyWith(navigationShellContext: v));
  }

  void changeView(int v) {
    emit(state.copyWith(indexOfView: v));
  }

  void changeHomeView(String v) {
    emit(state.copyWith(viewName: v));
  }

  void setIsOverlayVisible(bool v) {
    emit(state.copyWith(isOverlayVisible: v));
  }

  void changeProfileView(String v) {
    emit(state.copyWith(profileViewName: v));
  }

  void goBackInitialProfileView() {
    emit(state.copyWith(profileViewName: 'initial_profile'));
  }

  void changeFormat(UltrasoundFormat v) {
    emit(state.copyWith(ultrasoundFormat: v));
  }

  void changeNameView(NameViewOption v) {
    emit(state.copyWith(nameViewOptions: v));
  }

  void changeGender(GenderOption v) {
    emit(state.copyWith(genderOption: v));
  }

  void updateCarouselIndex(int v) {
    emit(state.copyWith(carouselIndex: v));
  }

  void pushScaffoldMyMedicinesPage(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (_) => MyMedicinesPage(),
      ),
    );
  }

  // void pushScaffoldForumComments(BuildContext context, int forumID) {
  //   Navigator.of(context, rootNavigator: true).push(
  //     MaterialPageRoute(
  //       builder: (_) => ForumCommentsPage(),
  //     ),
  //   );
  // }

  void tapSettingTile(BuildContext context, int i) {
    switch (i) {
      case 1:
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => ChangePasswordPage(),
          ),
        );
      case 2:
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => ChangePhoneNumberView(),
          ),
        );
      case 3:
        context.push('/change_language');
      default:
        null;
    }
  }

  void showBottomSheetAboutChild(Widget widget, BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return widget;
      },
    );
  }

  // void showChangeBabyBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (_) {
  //       return GlobalChangeBabyBottomsheet();
  //     },
  //   );
  // }

  void showCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CalendarDialog();
      },
    );
  }

  void showAddMedicine(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AddMedicineDialog();
      },
    );
  }

  Future<Result?> showEditMedicine(BuildContext context, Result data) {
    return showModalBottomSheet<Result>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => EditMedicineDialog(data: data),
    );
  }

  // void showAddIndicator(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return AddNewIndicatorDialog();
  //     },
  //   );
  // }

  void firstChildToggle(bool v) {
    emit(state.copyWith(isFirstChild: v));
  }

  void isShowToggle(int v) {
    if (state.selectedQuestionBox != v) {
      emit(state.copyWith(isShowQuestion: true));
    } else {
      emit(state.copyWith(isShowQuestion: !state.isShowQuestion));
    }
  }

  void updateSelectedQuestionBox(int v) {
    emit(state.copyWith(selectedQuestionBox: v));
  }

  void updateCommentBoxIndex(int v) {
    emit(state.copyWith(commentBoxIndex: v));
  }

  @override
  Future<void> close() {
    homePageScrollController.dispose();
    commentInputFocusNode.dispose();
    // commentInputTextController.dispose();
    return super.close();
  }
}
