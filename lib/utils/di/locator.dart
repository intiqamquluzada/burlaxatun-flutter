import 'package:burla_xatun/cubits/create_comment/create_comment_cubit.dart';
import 'package:burla_xatun/cubits/forum_category/forum_category_cubit.dart';
import 'package:burla_xatun/cubits/forum_category_stats/forum_category_stats_cubit.dart';
import 'package:burla_xatun/cubits/forum_comments/forum_comments_cubit.dart';
import 'package:burla_xatun/cubits/forum_detail/forum_detail_cubit.dart';
import 'package:burla_xatun/cubits/report_or_block_user/report_or_block_user_cubit.dart';
import 'package:burla_xatun/data/contractor/create_comment_contract.dart';
import 'package:burla_xatun/data/contractor/forum_category_contractor.dart';
import 'package:burla_xatun/data/contractor/forum_category_stats_contract.dart';
import 'package:burla_xatun/data/contractor/forum_comment_contract.dart';
import 'package:burla_xatun/data/contractor/forum_comment_repo.dart';
import 'package:burla_xatun/data/contractor/forum_detail_contract.dart';
import 'package:burla_xatun/data/contractor/report_or_block_contract.dart';
import 'package:burla_xatun/data/repository/create_comment_repo.dart';
import 'package:burla_xatun/data/repository/forum_category_repository.dart';
import 'package:burla_xatun/data/repository/forum_category_stats_repo.dart';
import 'package:burla_xatun/data/repository/forum_detail_repo.dart';
import 'package:burla_xatun/data/repository/report_or_block_repo.dart';
import 'package:burla_xatun/data/services/remote/create_comment_service.dart';
import 'package:burla_xatun/data/services/remote/forum_category_service.dart';
import 'package:burla_xatun/data/services/remote/forum_category_stats_service.dart';
import 'package:burla_xatun/data/services/remote/forum_comment_service.dart';
import 'package:burla_xatun/data/services/remote/forum_detail_service.dart';
import 'package:burla_xatun/data/services/remote/report_or_block_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import '../../cubits/about/about_cubit.dart';
import '../../cubits/add_child/add_child_cubit.dart';
import '../../cubits/baby_names_cubit/baby_names_cubit.dart';
import '../../cubits/blog_cat/blog_cat_cubit.dart';
import '../../cubits/blog_sliders/blog_sliders_cubit.dart';
import '../../cubits/contact/contact_cubit.dart';
import '../../cubits/countries/countries_cubit.dart';
import '../../cubits/daily_rec/daily_rec_cubit.dart';
import '../../cubits/daily_rec_detail/daily_rec_detail_cubit.dart';
import '../../cubits/doctor_notification/doctor_notification_cubit.dart';
import '../../cubits/doctor_reservation/doctor_reservation_cubit.dart';
import '../../cubits/doctors_detail/doctors_detail_cubit.dart';
import '../../cubits/doctors_list/doctors_list_cubit.dart';
import '../../cubits/faqs_cubit/faqs_cubit.dart';
import '../../cubits/forum_list/forum_list_cubit.dart';
import '../../cubits/indicator/indicator_cubit.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/medicine/medicine_cubit.dart';
import '../../cubits/medicine_create/medicine_create_cubit.dart';
import '../../cubits/medicine_patch/medicine_patch_cubit.dart';
import '../../cubits/notification/notification_cubit.dart';
import '../../cubits/privacy_policy/privacy_policy_cubit.dart';
import '../../cubits/questions_cubit/questions_cubit.dart';
import '../../cubits/signup_cubit/signup_cubit.dart';
import '../../cubits/splash/splash_cubit.dart';
import '../../cubits/tasks_by_weeks/tasks_by_weeks_cubit.dart';
import '../../cubits/ultrasound/ultrasound_cubit.dart';
import '../../cubits/user_data/user_data_cubit.dart';
import '../../cubits/user_update/user_update_cubit.dart';
import '../../cubits/using_rules/using_rules_cubit.dart';
import '../../data/contractor/about_contractor.dart';
import '../../data/contractor/add_child_contract.dart';
import '../../data/contractor/baby_names_contractor.dart';
import '../../data/contractor/blog_cat_contractor.dart';
import '../../data/contractor/blog_sliders_contractor.dart';
import '../../data/contractor/contact_contractor.dart';
import '../../data/contractor/countries_contractor.dart';
import '../../data/contractor/daily_rec_contractor.dart';
import '../../data/contractor/daily_rec_detail_contractor.dart';
import '../../data/contractor/doctor_reserv_contract.dart';
import '../../data/contractor/doctors_detail_contractor.dart';
import '../../data/contractor/doctors_list_contractor.dart';
import '../../data/contractor/dr_notifications_contract.dart';
import '../../data/contractor/faqs_contractor.dart';
import '../../data/contractor/forum_list_contractor.dart';
import '../../data/contractor/indicator_contract.dart';
import '../../data/contractor/login_contractor.dart';
import '../../data/contractor/medicine/medicine_contractor.dart';
import '../../data/contractor/medicine/medicine_create_contractor.dart';
import '../../data/contractor/medicine/medicine_patch_contractor.dart';
import '../../data/contractor/notifications_contract.dart';
import '../../data/contractor/privacy_policy_contractor.dart';
import '../../data/contractor/refresh_token_contract.dart';
import '../../data/contractor/register_contractor.dart';
import '../../data/contractor/tasks_by_week_contract.dart';
import '../../data/contractor/ultrasound_contract.dart';
import '../../data/contractor/user_data_contractor.dart';
import '../../data/contractor/user_update_contractor.dart';
import '../../data/contractor/using_rules_contractor.dart';
import '../../data/repository/about_repository.dart';
import '../../data/repository/add_child_repo.dart';
import '../../data/repository/baby_names_repository.dart';
import '../../data/repository/blog_cat_repository.dart';
import '../../data/repository/blog_sliders_repository.dart';
import '../../data/repository/contact_repository.dart';
import '../../data/repository/countries_repository.dart';
import '../../data/repository/daily_rec_detail_repository.dart';
import '../../data/repository/daily_rec_repository.dart';
import '../../data/repository/doctor_reserv_repository.dart';
import '../../data/repository/doctors_detail_repository.dart';
import '../../data/repository/doctors_list_repository.dart';
import '../../data/repository/dr_notifications_repo.dart';
import '../../data/repository/faqs_repository.dart';
import '../../data/repository/forum_list_repository.dart';
import '../../data/repository/indicator_repo.dart';
import '../../data/repository/login_repository.dart';
import '../../data/repository/medicine/medicine_create_repository.dart';
import '../../data/repository/medicine/medicine_patch_repository.dart';
import '../../data/repository/medicine/medicine_repository.dart';
import '../../data/repository/notifications_repo.dart';
import '../../data/repository/privacy_policy_repository.dart';
import '../../data/repository/refresh_token_repo.dart';
import '../../data/repository/register_repository.dart';
import '../../data/repository/task_by_weeks_repo.dart';
import '../../data/repository/ultrasound_repo.dart';
import '../../data/repository/user_data_repository.dart';
import '../../data/repository/user_update_repository.dart';
import '../../data/repository/using_rules_repository.dart';
import '../../data/services/local/login_token_service.dart';
import '../../data/services/local/register_token_service.dart';
import '../../data/services/remote/about_service.dart';
import '../../data/services/remote/add_child_service.dart';
import '../../data/services/remote/baby_names_service.dart';
import '../../data/services/remote/blog_cat_service.dart';
import '../../data/services/remote/blog_sliders_service.dart';
import '../../data/services/remote/contact_service.dart';
import '../../data/services/remote/countries_service.dart';
import '../../data/services/remote/daily_rec_detail_service.dart';
import '../../data/services/remote/daily_rec_service.dart';
import '../../data/services/remote/doctor_reservation_service.dart';
import '../../data/services/remote/doctors_detail_service.dart';
import '../../data/services/remote/doctors_list_service.dart';
import '../../data/services/remote/dr_notifications_service.dart';
import '../../data/services/remote/faqs_service.dart';
import '../../data/services/remote/forum_list_service.dart';
import '../../data/services/remote/indicator_service.dart';
import '../../data/services/remote/login_service.dart';
import '../../data/services/remote/medicine/medicine_create_service.dart';
import '../../data/services/remote/medicine/medicine_patch_service.dart';
import '../../data/services/remote/medicine/medicine_service.dart';
import '../../data/services/remote/notification_service.dart';
import '../../data/services/remote/privacy_policy_service.dart';
import '../../data/services/remote/refresh_token_service.dart';
import '../../data/services/remote/register_service.dart';
import '../../data/services/remote/tasks_by_week_service.dart';
import '../../data/services/remote/ultrasound_service.dart';
import '../../data/services/remote/user_data_service.dart';
import '../../data/services/remote/user_update_service.dart';
import '../../data/services/remote/using_rules_service.dart';

final GetIt locator = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
}

Future<void> setupLocator() async {
  final Box<String> loginBox = await Hive.openBox('loginBox');
  final Box<String> registerBox = await Hive.openBox('loginBox');

  // services
  locator.registerLazySingleton(() => LoginTokenService(loginBox));
  locator.registerLazySingleton(() => RegisterTokenService(registerBox));

  locator.registerLazySingleton(() => LoginService());
  locator.registerLazySingleton(() => DailyRecService());
  locator.registerLazySingleton(() => RegisterService());
  locator.registerLazySingleton(() => DailyRecDetailService());
  locator.registerLazySingleton(() => FaqsService());
  locator.registerLazySingleton(() => PrivacyPolicyService());
  locator.registerLazySingleton(() => UsingRulesService());
  locator.registerLazySingleton(() => AboutService());
  locator.registerLazySingleton(() => ContactService());
  locator.registerLazySingleton(() => CountriesService());
  locator.registerLazySingleton(() => BabyNamesService());
  locator.registerLazySingleton(() => BlogSlidersService());
  locator.registerLazySingleton(() => BlogCatService());
  locator.registerLazySingleton(() => MedicineService());
  locator.registerLazySingleton(() => UserUpdateService());
  locator.registerLazySingleton(() => MedicineCreateService());
  locator.registerLazySingleton(() => ForumCategoryService());
  locator.registerLazySingleton(() => DoctorsListService());
  locator.registerLazySingleton(() => DoctorDetailService());
  // locator.registerLazySingleton(() => ForumListService());
  locator.registerLazySingleton(() => ForumCommentService());
  // locator.registerLazySingleton(() => ForumCreateService());
  locator.registerLazySingleton(() => MedicinePatchService());
  locator.registerLazySingleton(() => UserDataService());
  //
  locator.registerLazySingleton(() => DoctorReservationService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => DrNotificationsService());
  locator.registerLazySingleton(() => TasksByWeekService());
  locator.registerLazySingleton(() => AddChildService());
  locator.registerLazySingleton(() => UltrasoundService());
  locator.registerLazySingleton(() => IndicatorService());
  locator.registerLazySingleton(() => RefreshTokenService());
  locator.registerLazySingleton(() => ForumListService());
  locator.registerLazySingleton(() => ForumDetailService());
  locator.registerLazySingleton(() => ForumCategoryStatsService());
  locator.registerLazySingleton(() => CreateCommentService());

  locator.registerLazySingleton(() => ReportOrBlockService());

  // contractor
  locator.registerLazySingleton<LoginContractor>(
      () => LoginRepository(locator<LoginService>()));

  locator.registerLazySingleton<RegisterContractor>(
      () => RegisterRepository(locator<RegisterService>()));

  locator.registerLazySingleton<DailyRecContractor>(
      () => DailyRecRepository(locator<DailyRecService>()));

  locator.registerLazySingleton<DailyRecDetailContractor>(
      () => DailyRecDetailRepository(locator<DailyRecDetailService>()));

  locator.registerLazySingleton<FaqsContractor>(
      () => FaqsRepository(locator<FaqsService>()));

  locator.registerLazySingleton<PrivacyPolicyContractor>(
      () => PrivacyPolicyRepository(locator<PrivacyPolicyService>()));

  locator.registerLazySingleton<UsingRulesContractor>(
      () => UsingRulesRepository(locator<UsingRulesService>()));

  locator.registerLazySingleton<AboutContractor>(
      () => AboutRepository(locator<AboutService>()));

  locator.registerLazySingleton<ContactContractor>(
      () => ContactRepository(locator<ContactService>()));

  locator.registerLazySingleton<CountriesContractor>(
      () => CountriesRepository(locator<CountriesService>()));

  locator.registerLazySingleton<BabyNamesContractor>(
      () => BabyNamesRepository(locator<BabyNamesService>()));

  locator.registerLazySingleton<BlogSlidersContractor>(
      () => BlogSlidersRepository(locator<BlogSlidersService>()));

  locator.registerLazySingleton<BlogCatContractor>(
      () => BlogCatRepository(locator<BlogCatService>()));

  locator.registerLazySingleton<MedicineContractor>(
      () => MedicineRepository(locator<MedicineService>()));

  // locator.registerLazySingleton<UserUpdateContractor>(
  //     () => UserUpdateRepository(locator<UserUpdateService>()));

  locator.registerLazySingleton<MedicineCreateContractor>(
      () => MedicineCreateRepository(locator<MedicineCreateService>()));

  locator.registerLazySingleton<ForumCategoryContractor>(
      () => ForumCategoryRepository(locator<ForumCategoryService>()));

  // locator.registerLazySingleton<ForumCreateContractor>(
  // () => ForumCreateRepository(locator<ForumCreateService>()));

  locator.registerLazySingleton<DoctorsListContractor>(
      () => DoctorsListRepository(locator<DoctorsListService>()));

  locator.registerLazySingleton<DoctorDetailContractor>(
      () => DoctorDetailRepository(locator<DoctorDetailService>()));

  locator.registerLazySingleton<ForumListContractor>(
      () => ForumListRepository(locator<ForumListService>()));

  // locator.registerLazySingleton<ForumCommentsContractor>(
  //     () => ForumCommentsRepository(locator<ForumCommentsService>()));

  locator.registerLazySingleton<MedicinePatchContractor>(
      () => MedicinePatchRepository(locator<MedicinePatchService>()));

  locator.registerLazySingleton<UserDataContractor>(
      () => UserDataRepository(locator<UserDataService>()));

  locator.registerLazySingleton<UserUpdateContractor>(
      () => UserUpdateRepository(locator<UserUpdateService>()));

  locator.registerLazySingleton<DoctorReservContract>(
      () => DoctorReservRepository(locator<DoctorReservationService>()));

  locator.registerLazySingleton<NotificationsContract>(
      () => NotificationsRepo(locator<NotificationService>()));

  locator.registerLazySingleton<IndicatorContract>(
      () => IndicatorRepo(locator<IndicatorService>()));

  locator.registerLazySingleton<DrNotificationsContract>(
      () => DrNotificationsRepo(locator<DrNotificationsService>()));

  locator.registerLazySingleton<TasksByWeekContract>(
      () => TasksByWeeksRepo(locator<TasksByWeekService>()));

  locator.registerLazySingleton<AddChildContract>(
      () => AddChildRepo(locator<AddChildService>()));

  locator.registerLazySingleton<UltrasoundContract>(
      () => UltrasoundRepo(locator<UltrasoundService>()));

  locator.registerLazySingleton<RefreshTokenContract>(
      () => RefreshTokenRepo(locator<RefreshTokenService>()));

  locator.registerLazySingleton<ForumDetailContract>(
      () => ForumDetailRepo(locator<ForumDetailService>()));

  locator.registerLazySingleton<ForumCategoryStatsContract>(
      () => ForumCategoryStatsRepo(locator<ForumCategoryStatsService>()));

  locator.registerLazySingleton<ForumCommentContract>(
      () => ForumCommentRepo(locator<ForumCommentService>()));

  locator.registerLazySingleton<CreateCommentContract>(
      () => CreateCommentRepo(locator<CreateCommentService>()));

  locator.registerLazySingleton<ReportOrBlockContract>(
      () => ReportOrBlockRepo(locator<ReportOrBlockService>()));
  // cubit
  locator.registerFactory(() => LoginCubit(locator()));
  locator.registerFactory(() => DailyRecCubit(locator()));
  locator.registerFactory(() => DailyRecDetailCubit(locator()));
  locator.registerFactory(() => SignupCubit(locator()));
  locator.registerFactory(() => FaqsCubit(locator()));
  locator.registerFactory(() => PrivacyPolicyCubit(locator()));
  locator.registerFactory(() => UsingRulesCubit(locator()));
  locator.registerFactory(() => AboutCubit(locator()));
  locator.registerFactory(() => ContactCubit(locator()));
  locator.registerFactory(() => CountriesCubit(locator()));
  locator.registerFactory(() => BabyNamesCubit(locator<BabyNamesContractor>()));
  locator.registerFactory(() => BlogSlidersCubit(locator()));
  locator.registerFactory(() => BlogCatCubit(locator()));
  locator.registerFactory(() => MedicineCubit(locator()));
  locator.registerFactory(() => UserUpdateCubit(locator()));
  locator.registerFactory(() => MedicineCreateCubit(locator()));
  locator.registerFactory(() => MedicinePatchCubit(locator()));
  locator.registerFactory(() => ForumCategoryCubit(locator()));
  locator.registerFactory(() => DoctorsListCubit(locator()));
  locator.registerFactory(() => DoctorDetailCubit(locator()));
  // locator.registerFactory(() => ForumCommentsCubit(locator()));
  // locator.registerFactory(() => ForumCreateCubit(locator()));
  locator.registerFactory(() => UserDataCubit(locator()));
  //locator.registerFactory(() => UserUpdateCubit(locator()));
  locator.registerFactory(
      () => DoctorReservationCubit(locator<DoctorReservContract>()));
  locator.registerFactory(
      () => NotificationCubit(locator<NotificationsContract>()));

  locator.registerFactory(
      () => DoctorNotificationCubit(locator<DrNotificationsContract>()));

  locator.registerFactory(() =>
      QuestionsCubit(userUpdateContractor: locator<UserUpdateContractor>()));

  locator
      .registerFactory(() => TasksByWeeksCubit(locator<TasksByWeekContract>()));

  locator.registerFactory(() => AddChildCubit(locator<AddChildContract>()));

  locator.registerFactory(() => UltrasoundCubit(locator<UltrasoundContract>()));

  locator.registerFactory(() => IndicatorCubit(locator<IndicatorContract>()));

  locator.registerFactory(() => SplashCubit(locator<RefreshTokenContract>()));

  locator.registerFactory(() => ForumListCubit(locator<ForumListContractor>()));

  locator
      .registerFactory(() => ForumDetailCubit(locator<ForumDetailContract>()));

  locator.registerFactory(
      () => ForumCategoryStatsCubit(locator<ForumCategoryStatsContract>()));

  locator.registerFactory(
      () => ForumCommentsCubit(locator<ForumCommentContract>()));

  locator.registerFactory(
      () => CreateCommentCubit(locator<CreateCommentContract>()));

  locator.registerFactory(
      () => ReportOrBlockUserCubit(locator<ReportOrBlockContract>()));
}
