import 'package:dio/src/response.dart';

import '../contractor/baby_names_contractor.dart';
import '../services/remote/baby_names_service.dart';

class BabyNamesRepository implements BabyNamesContractor {
  BabyNamesRepository(this._babyNamesService);
  final BabyNamesService _babyNamesService;

  @override
  Future<Response<dynamic>> getCountries() {
    return _babyNamesService.getCountries();
  }

  @override
  Future<Response<dynamic>> getBabyNamesByCountryId({
    required String countryId,
    required String gender,
    String? url,
  }) {
    return _babyNamesService.getNames(
      countryId: countryId,
      gender: gender,
      url: url,
    );
  }

  @override
  Future<Response> getWishListNames() {
    return _babyNamesService.getWishListNames();
  }

  @override
  Future<Response> addToWishList({required int babyNameId}) {
    return _babyNamesService.addToWishList(babyNameId: babyNameId);
  }

  @override
  Future<Response> removeFromWishList({required int babyNameId}) {
    return _babyNamesService.removeFromWishList(babyNameId: babyNameId);
  }
}
