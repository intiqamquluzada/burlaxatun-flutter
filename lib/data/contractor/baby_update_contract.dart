import 'package:dio/dio.dart';

abstract class BabyUpdateContract {
  Future<Response<dynamic>> updateBabyData({
    String? name,
    int? height,
    int? weight,
    String? gender,
    String? birthDate,
    bool? haveBorn,
    bool? isFirst,
    bool? haveMiscarriage,
  });
}
