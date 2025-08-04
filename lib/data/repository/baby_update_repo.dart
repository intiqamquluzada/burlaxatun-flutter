import 'package:dio/src/response.dart';

import '../contractor/baby_update_contract.dart';
import '../services/remote/baby_update_service.dart';

class BabyUpdateRepo implements BabyUpdateContract {
  BabyUpdateRepo(this.babyUpdateService);

  final BabyUpdateService babyUpdateService;

  @override
  Future<Response> updateBabyData({
    String? name,
    int? height,
    int? weight,
    String? gender,
    String? birthDate,
    bool? haveBorn,
    bool? isFirst,
    bool? haveMiscarriage,
  }) {
    return babyUpdateService.updateBabyData(
      name: name,
      height: height,
      weight: weight,
      gender: gender,
      birthDate: birthDate,
      haveBorn: haveBorn,
      isFirst: isFirst,
      haveMiscarriage: haveMiscarriage,
    );
  }
}
