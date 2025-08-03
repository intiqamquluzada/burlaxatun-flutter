import 'package:burla_xatun/ui/screens/auth/video_doktor_login/video_doktor_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/add_child/add_child_cubit.dart';
import '../../cubits/baby_names_cubit/baby_names_cubit.dart';
import '../../cubits/doctor_reservation/doctor_reservation_cubit.dart';
import '../../cubits/doctors_detail/doctors_detail_cubit.dart';
import '../../cubits/forum_list/forum_list_cubit.dart';
import '../../cubits/indicator/indicator_cubit.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/notification/notification_cubit.dart';
import '../../cubits/onboarding_cubit/onboarding_cubit.dart';
import '../../cubits/questions_cubit/questions_cubit.dart';
import '../../cubits/signup_cubit/signup_cubit.dart';
import '../../cubits/splash/splash_cubit.dart';
import '../../data/models/remote/response/blog_cat_model.dart';
import '../../ui/screens/add_child/add_your_child.dart';
import '../../ui/screens/auth/forgot_psw/phone_number_request_screen.dart';
import '../../ui/screens/auth/forgot_psw/forgot_psw_otp_screen.dart';
import '../../ui/screens/auth/forgot_psw/forgot_psw_success_screen.dart';
import '../../ui/screens/auth/forgot_psw/reset_psw_screen.dart';
import '../../ui/screens/auth/login/login.dart';
import '../../ui/screens/auth/sign_up/signup.dart';
import '../../ui/screens/main/main_page.dart';
import '../../ui/screens/main/views/daily_advise_page/advice_page.dart';
import '../../ui/screens/main/views/forum_page/main_forum_page.dart/forum_page.dart';
import '../../ui/screens/main/views/forum_page/new_forum_page/create_new_forum.dart';
import '../../ui/screens/main/views/forum_page/secondary_forum_page/secondary_forum_page.dart';
import '../../ui/screens/main/views/home_page/blog/article_details/article_details_page.dart';
import '../../ui/screens/main/views/home_page/blog/initial_blog/initial_blog_page.dart';
import '../../ui/screens/main/views/home_page/blog/see_all_articles/see_all_articles_page.dart';
import '../../ui/screens/main/views/home_page/doctor/initial_doctor_page/initial_doctor_page.dart';
import '../../ui/screens/main/views/home_page/doctor/registration_doctor_page/registration_doctor_page.dart';
import '../../ui/screens/main/views/home_page/home/home_page.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/indicator_data_screen/indicator_data_screen.dart';
import '../../ui/screens/main/views/home_page/my_healing_page/initial_my_healing_page/my_healing_page.dart';
import '../../ui/screens/main/views/home_page/names/gender_names/gender_names.dart';
import '../../ui/screens/main/views/home_page/names/initial_names/names_page.dart';
import '../../ui/screens/main/views/home_page/notification/notification_page.dart';
import '../../ui/screens/main/views/home_page/ultrasound/ultrasound_page.dart';
import '../../ui/screens/main/views/home_page/video/video_page.dart';
import '../../ui/screens/main/views/profil_page/about_us/about_us_view.dart';
import '../../ui/screens/main/views/profil_page/contact_us/contact_us_view.dart';
import '../../ui/screens/main/views/profil_page/faq/faq_view.dart';
import '../../ui/screens/main/views/profil_page/initial_profile/initial_profile_page.dart';
import '../../ui/screens/main/views/profil_page/pricavy_policy/privacy_policy_view.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_view.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_views/change_language/change_language_view.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_views/change_password/change_password_page/change_password_page.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_views/change_password/otp_page/otp_page.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_views/change_password/reset_password/reset_password_page.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_views/change_password/success_change_password/success_change_password.dart';
import '../../ui/screens/main/views/profil_page/settings/setting_views/change_phone_number/change_phone_number_view.dart';
import '../../ui/screens/main/views/profil_page/special_thanks/special_thanks_view.dart';
import '../../ui/screens/main/views/profil_page/using_rules/using_rules_screen.dart';
import '../../ui/screens/onboarding/onboarding.dart';
import '../../ui/screens/questions/questions.dart';
import '../../ui/screens/questions/widgets/calculate_birth_view/calculate_birth.dart';
import '../../ui/screens/splash/splash_screen.dart';
import '../di/locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routerapp {
  static Routerapp? _instance;

  Routerapp._();

  static Routerapp get instance => _instance ??= Routerapp._();

  // static final navigatorKey = GlobalKey<NavigatorState>();
  // static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  late final StatefulNavigationShell shell;

  final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => BlocProvider(
          create: (context) => locator<SplashCubit>(),
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingCubit(),
          child: Onboarding(),
        ),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider<LoginCubit>(
          create: (context) => locator<LoginCubit>(),
          child: Login(),
        ),
      ),
      GoRoute(
        path: '/video_doktor_login',
        builder: (context, state) => VideoDoktorLogin(),
      ),
      GoRoute(
        path: '/sign_up',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<SignupCubit>(),
            child: SignUp(),
          );
        },
      ),
      GoRoute(
        path: '/add_child',
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => locator<AddChildCubit>(),
              ),
              BlocProvider(
                create: (context) => locator<QuestionsCubit>(),
              ),
            ],
            child: AddYourChild(),
          );
        },
      ),
      GoRoute(
        path: '/email_request',
        builder: (context, state) {
          return PhoneNumberRequestScreen();
        },
      ),
      GoRoute(
        path: '/forgot_psw_otp',
        builder: (context, state) {
          return ForgotPswOtpScreen();
        },
      ),
      GoRoute(
        path: '/reset_psw',
        builder: (context, state) {
          return ResetPswScreen();
        },
      ),
      GoRoute(
        path: '/forgot_psw_success',
        builder: (context, state) => SuccessForgotPswScreen(),
      ),
      GoRoute(
        path: '/questions',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<QuestionsCubit>(),
            child: Questions(),
          );
        },
      ),
      GoRoute(
        path: '/calculate',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => locator<QuestionsCubit>(),
            child: CalculateBirth(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(
            navigationShell: navigationShell,
            shellContext: context,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return HomePage();
                },
              ),
              GoRoute(
                path: '/videos',
                builder: (context, state) => VideoPage(),
              ),
              GoRoute(
                path: '/notification',
                builder: (context, state) => BlocProvider(
                  create: (context) => locator<NotificationCubit>(),
                  child: NotificationPage(),
                ),
              ),
              GoRoute(
                path: '/my_healing_card',
                builder: (context, state) => MyHealingPage(),
              ),
              GoRoute(
                path: '/indicator_data',
                builder: (context, state) {
                  final indicator = state.extra as Map;
                  return BlocProvider(
                    create: (context) => locator<IndicatorCubit>(),
                    child: IndicatorDataScreen(
                      indicatorName: indicator['indicator']!,
                      indicatorAppBarTitle: indicator['indicator_name']!,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/initial_doctors',
                builder: (context, state) => InitialDoctorPage(),
              ),
              GoRoute(
                path: '/doctor_register/:slug',
                builder: (context, state) {
                  final slug = state.pathParameters['slug']!;
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            locator<DoctorDetailCubit>()..getDoctorDetail(slug),
                      ),
                      BlocProvider(
                        create: (context) => locator<DoctorReservationCubit>(),
                      )
                    ],
                    child: RegistrationDoctorPage(),
                  );
                  // BlocProvider(
                  //   create: (context) =>
                  //       locator<DoctorDetailCubit>()..getDoctorDetail(slug),
                  //   child: RegistrationDoctorPage(),
                  // );
                },
              ),

              // GoRoute(
              //   path: '/doctor_register/:slug',
              //   builder: (context, state) {
              //     final slug = state.params['slug']!;
              //     return RegistrationDoctorPage(slug: slug);
              //   },
              // ),

              GoRoute(
                path: '/initial_blog',
                builder: (context, state) => InitialBlogPage(),
              ),
              GoRoute(
                path: '/article_details',
                builder: (context, state) {
                  final blog = state.extra as Blog;
                  return ArticleDetailsPage(
                    blog: blog,
                  );
                },
              ),
              GoRoute(
                path: '/see_all_articles',
                builder: (context, state) {
                  final category = state.extra as Result;
                  return SeeAllArticlesPage(
                    category: category,
                  );
                },
              ),
              GoRoute(
                path: '/videos',
                builder: (context, state) => VideoPage(),
              ),
              GoRoute(
                path: '/ultrasound',
                builder: (context, state) => UltrasoundPage(),
              ),
              GoRoute(
                path: '/initial_names',
                builder: (context, state) => BlocProvider(
                  create: (context) => locator<BabyNamesCubit>(),
                  child: NamesPage(),
                ),
              ),
              GoRoute(
                path: '/gender_names',
                builder: (context, state) {
                  final extra = state.extra as Map;
                  final cubit = extra['cubit'] as BabyNamesCubit;
                  final countryId = extra['id'] as int;
                  return BlocProvider.value(
                    value: cubit,
                    child: GenderNames(countryId: countryId.toString()),
                  );
                },
              ),
              //  GoRoute(
              //   path: '/gender_names',
              //   builder: (context, state) {
              //    final extra = state.extra as Map;
              //     final cubit = extra['cubit'] as BabyNamesCubit2;
              //     final countryId = extra['id'];
              //     return BlocProvider(
              //       create:(context) => cubit..getBabyNames(countryId),
              //       child: GenderNames(countryId: countryId),
              //     );
              //   },
              // ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/daily_advices',
                builder: (context, state) => AdvicePage(),
              ),
              // GoRoute(
              //   path: '/daily_advices',
              //   builder: (context, state) {
              //     final slug = state.extra as String?;
              //     return AdvisesPage(slug: slug);
              //   },
              // ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main_forum',
                builder: (context, state) => MainForumPage(),
              ),
              GoRoute(
                path: '/secondary_forum',
                builder: (context, state) {
                  final categoryData = state.extra as Map<String, dynamic>;
                  final categoryId = categoryData['category_id'];
                  final categoryName = categoryData['category_name'];

                  return BlocProvider(
                    create: (context) => locator<ForumListCubit>()
                      ..getForumList(categoryid: categoryId),
                    child: SecondaryForumPage(
                      categoryId: categoryId,
                      categoryName: categoryName,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/create_new_forum',
                builder: (context, state) => CreateNewForum(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile_page',
                builder: (context, state) => InitialProfilePage(),
              ),
              GoRoute(
                path: '/about_us',
                builder: (context, state) => AboutUsView(),
              ),
              GoRoute(
                path: '/contact_us',
                builder: (context, state) => ContactUsView(),
              ),
              GoRoute(
                path: '/faq',
                builder: (context, state) => FaqView(),
              ),
              GoRoute(
                path: '/privacy_policy',
                builder: (context, state) => PrivacyPolicyView(),
              ),
              GoRoute(
                path: '/settings',
                builder: (context, state) => SettingView(),
              ),
              GoRoute(
                path: '/change_password',
                builder: (context, state) => ChangePasswordPage(),
              ),
              GoRoute(
                path: '/change_password_otp',
                builder: (context, state) => OtpPage(),
              ),
              GoRoute(
                path: '/reset_password',
                builder: (context, state) => ResetPasswordPage(),
              ),
              GoRoute(
                path: '/change_password_success',
                builder: (context, state) => SuccessChangePassword(),
              ),
              GoRoute(
                path: '/special_thanks',
                builder: (context, state) => SpecialThanksView(),
              ),
              GoRoute(
                path: '/terms_of_use',
                builder: (context, state) => UsingRulesScreen(),
              ),
              GoRoute(
                path: '/change_language',
                builder: (context, state) => ChangeLanguageView(),
              ),
              GoRoute(
                path: '/change_number',
                builder: (context, state) => ChangePhoneNumberView(),
              ),
            ],
          )
        ],
      )
    ],
  );
}
