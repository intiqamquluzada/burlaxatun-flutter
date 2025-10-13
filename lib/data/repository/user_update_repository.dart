import 'dart:io';

import 'package:burla_xatun/data/contractor/user_update_contractor.dart';
import 'package:burla_xatun/data/models/remote/response/user_update_model.dart';
import 'package:burla_xatun/data/services/remote/user_update_service.dart';

class UserUpdateRepository implements UserUpdateContractor {
  UserUpdateRepository(this._userUpdateService);
  final UserUpdateService _userUpdateService;

  @override
  Future<UserUpdateResponse?> updateUser({
    String? phoneNumber,
    bool? onboardingDone,
    bool? wantToBePregnant,
    bool? haveMiscarriage,
    bool? wantToSeePeriod,
    bool? isPregnant,
    String? pregnantWeek,
    bool? firstChild,
    File? image,
    String? activeLanguage,
    String? inseminationDate,
    bool? enableNotifications,
    bool? questionsCompleted,
  }) {
    return _userUpdateService.updateUser(
      phoneNumber: phoneNumber,
      onboardingDone: onboardingDone,
      wantToBePregnant: wantToBePregnant,
      haveMiscarriage: haveMiscarriage,
      wantToSeePeriod: wantToSeePeriod,
      isPregnant: isPregnant,
      inseminationDate: inseminationDate,
      pregnantWeek: pregnantWeek,
      firstChild: firstChild,
      image: image,
      activeLanguage: activeLanguage,
      enableNotifications: enableNotifications,
      questionsCompleted: questionsCompleted,
    );
  }

  @override
  Future<bool> userProfileDelete() {
    return _userUpdateService.userProfileDelete();
  }
}
