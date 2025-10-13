class LoginResponseModel {
  final String? refresh;
  final String? access;
  final String? activeLanguage;
  final bool? onboardingDone;
  final bool? enableNotifications;
  final String? pregnantWeek;
  final bool? questionCompleted;

  LoginResponseModel({
    this.refresh,
    this.access,
    this.activeLanguage,
    this.onboardingDone,
    this.enableNotifications,
    this.pregnantWeek,
    this.questionCompleted,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        refresh: json["refresh"],
        access: json["access"],
        activeLanguage: json["active_language"],
        onboardingDone: json["onboarding_done"],
        enableNotifications: json["enable_notifications"],
        pregnantWeek: json["pregnant_week"],
        questionCompleted: json["questions_completed"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "active_language": activeLanguage,
        "onboarding_done": onboardingDone,
        "enable_notifications": enableNotifications,
        "pregnant_week": pregnantWeek,
        "questions_completed": questionCompleted,
      };
}
