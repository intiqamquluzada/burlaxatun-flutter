import 'package:dio/src/response.dart';

import '../contractor/change_password_contract.dart';
import '../services/remote/change_password_service.dart';

class ChangePasswordRepo implements ChangePasswordContract {
  ChangePasswordRepo(this.changePasswordService);

  final ChangePasswordService changePasswordService;

  @override
  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  }) {
    return changePasswordService.changePassword(
      oldPassword: oldPassword,
      newPassword1: newPassword1,
      newPassword2: newPassword2,
    );
  }
}
