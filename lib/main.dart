import 'dart:developer';

import 'package:burla_xatun/cubits/notification/notification_cubit.dart';
import 'package:burla_xatun/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubits/about/about_cubit.dart';
import 'cubits/baby_update/baby_update_cubit.dart';
import 'cubits/blog_cat/blog_cat_cubit.dart';
import 'cubits/blog_sliders/blog_sliders_cubit.dart';
import 'cubits/change_password/change_password_cubit.dart';
import 'cubits/contact/contact_cubit.dart';
import 'cubits/countries/countries_cubit.dart';
import 'cubits/daily_rec/daily_rec_cubit.dart';
import 'cubits/daily_rec_detail/daily_rec_detail_cubit.dart';
import 'cubits/doctors_detail/doctors_detail_cubit.dart';
import 'cubits/doctors_list/doctors_list_cubit.dart';
import 'cubits/faqs_cubit/faqs_cubit.dart';
import 'cubits/forum_category/forum_category_cubit.dart';
import 'cubits/forum_create/forum_create_cubit.dart';
import 'cubits/language_cubit/language_cubit.dart';
import 'cubits/main_cubit/mainn_cubit.dart';
import 'cubits/medicine/medicine_cubit.dart';
import 'cubits/medicine_create/medicine_create_cubit.dart';
import 'cubits/medicine_patch/medicine_patch_cubit.dart';
import 'cubits/pregnancy_progress/pregnancy_progress_cubit.dart';
import 'cubits/privacy_policy/privacy_policy_cubit.dart';
import 'cubits/recommend_by_day/recommend_by_day_cubit.dart';
import 'cubits/report_or_block_user/report_or_block_user_cubit.dart';
import 'cubits/reset_password/reset_password_cubit.dart';
import 'cubits/select_task/select_task_cubit.dart';
import 'cubits/tasks_by_weeks/tasks_by_weeks_cubit.dart';
import 'cubits/ultrasound/ultrasound_cubit.dart';
import 'cubits/user_data/user_data_cubit.dart';
import 'cubits/user_update/user_update_cubit.dart';
import 'cubits/using_rules/using_rules_cubit.dart';
import 'data/contractor/ultrasound_contract.dart';
import 'data/models/local/user_data_model.dart';
import 'generated/l10n.dart';
import 'utils/constants/color_constants.dart';
import 'utils/di/locator.dart';
import 'utils/routes/router.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('Background message received: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await init();
  await setupLocator();
  Hive.registerAdapter(UserDataModelAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('notification: ${message.notification?.title}');
  });
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        // BlocProvider<SignupCubit>(
        //   create: (context) => locator<SignupCubit>(),
        // ),
        BlocProvider<DailyRecCubit>(
          create: (context) => locator<DailyRecCubit>(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => locator<NotificationCubit>(),
        ),
        BlocProvider<DailyRecDetailCubit>(
          create: (context) => locator<DailyRecDetailCubit>(),
        ),
        BlocProvider<FaqsCubit>(
          create: (context) => locator<FaqsCubit>()..getFaqs(),
        ),
        BlocProvider<PrivacyPolicyCubit>(
          create: (context) =>
              locator<PrivacyPolicyCubit>()..getPrivacyPolicy(),
        ),
        BlocProvider<UsingRulesCubit>(
          create: (context) => locator<UsingRulesCubit>()..getUsingRules(),
        ),
        BlocProvider<AboutCubit>(
            create: (context) => locator<AboutCubit>()..getAbout()),
        BlocProvider<ContactCubit>(
          create: (context) => locator<ContactCubit>()..getContact(),
        ),
        BlocProvider<CountriesCubit>(
          create: (context) => locator<CountriesCubit>()..getCountries(),
        ),
        BlocProvider<BlogSlidersCubit>(
          create: (context) => locator<BlogSlidersCubit>()..getBlogSliders(),
        ),
        BlocProvider<BlogCatCubit>(
          create: (context) => locator<BlogCatCubit>()..getBlogCat(),
        ),
        BlocProvider<MedicineCubit>(
          create: (context) => locator<MedicineCubit>()..getMedicines(),
        ),
        BlocProvider<MedicineCreateCubit>(
          create: (context) => locator<MedicineCreateCubit>(),
        ),
        BlocProvider<MedicinePatchCubit>(
          create: (context) => locator<MedicinePatchCubit>(),
        ),
        BlocProvider<UserUpdateCubit>(
          create: (context) => locator<UserUpdateCubit>(),
        ),
        BlocProvider<ForumCategoryCubit>(
          create: (context) =>
              locator<ForumCategoryCubit>()..getForumCategory(),
        ),
        // BlocProvider<ForumCommentsCubit>(
        //   create: (context) =>
        //       locator<ForumCommentsCubit>()..getForumComments(),
        // ),
        BlocProvider<ForumCreateCubit>(
          create: (context) => locator<ForumCreateCubit>(),
        ),
        BlocProvider<DoctorsListCubit>(
          create: (context) => locator<DoctorsListCubit>()..getDoctorsList(),
        ),
        BlocProvider(
          create: (context) => locator<DoctorDetailCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<UserDataCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<TasksByWeeksCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<ResetPasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<ChangePasswordCubit>(),
        ),
        BlocProvider(
          create: (context) => UltrasoundCubit(locator<UltrasoundContract>()),
        ),
        BlocProvider(
          create: (context) => locator<PregnancyProgressCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<BabyUpdateCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<ReportOrBlockUserCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<RecommendByDayCubit>(),
        ),
        BlocProvider(
          create: (context) => locator<SelectTaskCubit>(),
        )
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: ColorConstants.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              progressIndicatorTheme: ProgressIndicatorThemeData(
                color: ColorConstants.primaryRedColor,
              ),
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: state,
            routerConfig: Routerapp.instance.router,
          );
        },
      ),
    );
  }
}

// DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (BuildContext context) {
//         return MyApp();
//       },
//       // child: MyApp(),
//     ),
