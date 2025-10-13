import 'dart:io';

import 'package:burla_xatun/data/models/remote/response/user_update_model.dart';

abstract class UserUpdateContractor {
  Future<UserUpdateResponse?> updateUser({
    String? phoneNumber,
    String? inseminationDate,
    bool? onboardingDone,
    bool? wantToBePregnant,
    bool? wantToSeePeriod,
    bool? isPregnant,
    bool? haveMiscarriage,
    String? pregnantWeek,
    bool? firstChild,
    File? image,
    String? activeLanguage,
    bool? enableNotifications,
    bool? questionsCompleted,
  });

  Future<bool> userProfileDelete();
}
