import 'package:dio/dio.dart';

abstract class SelectTaskContract {
  Future<Response<dynamic>> selectTask({required int taskId});

  Future<Response<dynamic>> declineTask({required int taskId});
}
