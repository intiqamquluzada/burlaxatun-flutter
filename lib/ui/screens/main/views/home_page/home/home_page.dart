import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../cubits/notification/notification_cubit.dart';
import '../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../cubits/user_update/user_update_cubit.dart';
import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../utils/routes/router.dart';
import 'widgets/baby_information.dart';
import 'widgets/current_baby_info.dart';
import 'widgets/home_page_appbar.dart';
import 'widgets/home_page_boxes.dart';
import 'widgets/home_page_daily_advise.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/pregnancy_guide.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.isAddedPregnancy = false,
  });

  final bool isAddedPregnancy;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserDataCubit userDataCubit;
  late final MainCubit mainCubit;
  late final NotificationCubit notificationCubit;
  late final UserUpdateCubit userUpdateCubit;
  @override
  void initState() {
    mainCubit = context.read<MainCubit>();
    userDataCubit = context.read<UserDataCubit>()..getUserData();
    notificationCubit = context.read<NotificationCubit>();
    userUpdateCubit = context.read<UserUpdateCubit>();

    saveFcmToken();

    super.initState();
  }

  Future<bool> _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final isAllowedNotification =
        settings.authorizationStatus == AuthorizationStatus.authorized;

    return isAllowedNotification;
  }

  void saveFcmToken() async {
    final isAllowedNotification = await _requestPermission();
    await userUpdateCubit.updateUser(
      enableNotifications: isAllowedNotification,
    );

    if (!isAllowedNotification) return; 

    String? newFcmToken = await FirebaseMessaging.instance.getToken();
    

    if (newFcmToken == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedFcmToken = prefs.getString('fcm_token');

    if (savedFcmToken != newFcmToken) {
      await notificationCubit.enableNotification(
        fcmToken: newFcmToken,
        deviceType: getDeviceType(),
      );

      await prefs.setString('fcm_token', newFcmToken);
    }
  }

  String getDeviceType() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: HomePageAppbar(),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state.status == UserDataStatus.loading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state.status == UserDataStatus.success) {
                final week = state.response?.pregnantWeek ?? '0';
                final isPregnant = state.response?.isPregnant ?? false;
                final days = state.pregnantDays;
                return Center(
                  child: Column(
                    children: [
                      Visibility(
                        visible: isPregnant,
                        child: Column(
                          children: [
                            24.h,
                            HorizontalCalendar(),
                            24.h,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ValueListenableBuilder(
                                valueListenable:
                                    userDataCubit.currentBabyNotifier,
                                builder: (context, currentBaby, child) {
                                  // log('user is null: ${user == null}');

                                  return Visibility(
                                    visible: currentBaby == null && isPregnant,
                                    replacement: currentBaby == null
                                        ? SizedBox.shrink()
                                        : CurrentBabyInfo(),
                                    child: BabyInformation(),
                                  );
                                },
                              ),
                            ),
                            24.h,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Visibility(
                                visible: isPregnant,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: days != null,
                                      child: GestureDetector(
                                        onTap: () {
                                          mainCubit.changeView(1);
                                          navigatorKey.currentContext
                                              ?.go('/daily_advices');
                                        },
                                        child: HomePageDailyAdvise(),
                                      ),
                                    ),
                                    24.h,
                                    Visibility(
                                      visible: week != '0',
                                      child: PregnancyGuide(pregnantWeek: week),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      24.h,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: HomePageBoxes(),
                      ),
                      24.h,
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
