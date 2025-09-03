import 'package:burla_xatun/data/contractor/login_contractor.dart';
import 'package:burla_xatun/data/models/remote/response/login_response_model.dart';
import 'package:burla_xatun/data/services/remote/login_service.dart';

class LoginRepository implements LoginContractor {
  LoginRepository(this._loginService);

  final LoginService _loginService;

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) {
    return _loginService.login(
      email: email,
      password: password,
    );
  }

  @override
  Future<LoginResponseModel> loginByVideoDoktor({
    required String login,
    required String password,
  }) {
    return _loginService.loginByVideoDoktor(
      login: login,
      password: password,
    );
  }
}
