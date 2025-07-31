import 'package:dio/dio.dart';

abstract class ChangePasswordContract {
  Future<Response<dynamic>> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  });
}
