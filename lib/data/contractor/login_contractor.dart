import 'package:burla_xatun/data/models/remote/response/login_response_model.dart';

abstract class LoginContractor {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<LoginResponseModel> loginByVideoDoktor({
    required String login, 
    required String password,
  });
}
