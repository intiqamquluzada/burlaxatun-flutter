import 'dart:developer';

import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/baby_names_contractor.dart';
import '../../data/models/remote/response/countries_model.dart';
import '../../data/models/remote/response/names_model.dart';
import '../../data/models/remote/response/selected_names_model.dart';

part 'baby_names_state.dart';

enum NameStateStatus { initial, loading, error, success, networkError }

enum SelectNameStatus { initial, loading, error, success, networkError }

class BabyNamesCubit extends Cubit<BabyNamesState> {
  BabyNamesCubit(this._babyNamesContractor) : super(BabyNamesState());

  final BabyNamesContractor _babyNamesContractor;

  Future<void> getCountries() async {
    try {
      emit(state.copyWith(nameStateStatus: NameStateStatus.loading));
      final response = await _babyNamesContractor.getCountries();
      final countries = CountriesResponse.fromJson(response.data);
      emit(state.copyWith(
        countries: countries,
        nameStateStatus: NameStateStatus.success,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(nameStateStatus: NameStateStatus.networkError));
      throw Exception(e);
    } catch (e, s) {
      log('error occured while getting countries: $e', stackTrace: s);
      emit(state.copyWith(nameStateStatus: NameStateStatus.error));
    }
  }

  Future<void> getNames({
    required String countryId,
    required String gender,
  }) async {
    try {
      emit(state.copyWith(nameStateStatus: NameStateStatus.loading));
      final response = await _babyNamesContractor.getBabyNamesByCountryId(
        countryId: countryId,
        gender: gender,
      );
      final names = NamesModel.fromJson(response.data);

      switch (gender) {
        case 'male':
          emit(state.copyWith(
            maleNamesList: names.results,
            nameStateStatus: NameStateStatus.success,
          ));
          break;
        case 'female':
          emit(state.copyWith(
            femaleNamesList: names.results,
            nameStateStatus: NameStateStatus.success,
          ));
          break;
      }
    } on DioException catch (e) {
      emit(state.copyWith(nameStateStatus: NameStateStatus.networkError));
      throw Exception(e);
    } catch (e, s) {
      log('error occured while getting names: $e', stackTrace: s);
      emit(state.copyWith(nameStateStatus: NameStateStatus.error));
    }
  }

  List<SelectedName>? selectedNames = [];

  Future<void> getSelectedNames() async {
    try {
      emit(state.copyWith(nameStateStatus: NameStateStatus.loading));
      final response = await _babyNamesContractor.getWishListNames();
      final wishListNames = SelectedNamesModel.fromJson(response.data);
      selectedNames = wishListNames.results;
      emit(state.copyWith(
        selectedNamesList: selectedNames,
        nameStateStatus: NameStateStatus.success,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(nameStateStatus: NameStateStatus.networkError));
      throw Exception(e);
    } catch (e, s) {
      log('error occured while getting selected names: $e', stackTrace: s);
      emit(state.copyWith(nameStateStatus: NameStateStatus.error));
    }
  }

  Future<void> removeFromWishList({required int babyNameId}) async {
    try {
      emit(state.copyWith(selectNameStatus: SelectNameStatus.loading));
      final response =
          await _babyNamesContractor.removeFromWishList(babyNameId: babyNameId);
      // final isRemoved =
      //     response.statusCode == 200 || response.statusCode == 201;
      if (response.statusCode.isSuccess) {
        // proccessing remove disliked name from wish list
        final List<SelectedName> updatedSelectedNameList =
            List.from(selectedNames ?? []);
        selectedNames = updatedSelectedNameList;
        updatedSelectedNameList.removeWhere((element) {
          return element.id == babyNameId;
        });
        emit(state.copyWith(
          selectedNamesList: updatedSelectedNameList.reversed.toList(),
          selectNameStatus: SelectNameStatus.success,
        ));
      } else {
        emit(state.copyWith(selectNameStatus: SelectNameStatus.error));
      }
    } on DioException catch (e) {
      emit(state.copyWith(selectNameStatus: SelectNameStatus.networkError));
      throw Exception(e);
    } catch (e, s) {
      log('error occured while removing name: $e', stackTrace: s);
      emit(state.copyWith(selectNameStatus: SelectNameStatus.error));
    }
  }

  Future<bool> addToWishList({
    required int babyNameId,
    required SelectedName selectedName,
  }) async {
    try {
      emit(state.copyWith(selectNameStatus: SelectNameStatus.loading));
      final response =
          await _babyNamesContractor.addToWishList(babyNameId: babyNameId);
      final isAdded = response.statusCode == 200 || response.statusCode == 201;

      if (isAdded) {
        // proccessing add name to wish list
        log('added name id: ${selectedName.toJson()}');
        selectedNames!.add(selectedName);
        final List<SelectedName> updatedSelectedNameList =
            List.from(selectedNames ?? []);
        emit(state.copyWith(
          selectedNamesList: updatedSelectedNameList.reversed.toList(),
          selectNameStatus: SelectNameStatus.success,
        ));
        return isAdded;
      } else {
        emit(state.copyWith(selectNameStatus: SelectNameStatus.error));
        return isAdded;
      }
    } on DioException catch (e) {
      emit(state.copyWith(selectNameStatus: SelectNameStatus.networkError));
      log('connection error: $e');
      return false;
    } catch (e, s) {
      log('error occured while adding name: $e', stackTrace: s);
      emit(state.copyWith(selectNameStatus: SelectNameStatus.error));
      return false;
    }
  }

  // void updateSelectedNameIndex(int v) {
  //   emit(state.copyWith(selectedNameIndex: v));
  // }

  // void changeIsSelected({int? v}) {
  //   log('isSelected: ${state.isSelected}');
  //   emit(state.copyWith(isSelected: v));
  //   log('isSelected: ${state.isSelected}');
  // }

  // Future<void> getCountriesAndSelectedNames() async {
  //   try {
  //     emit(state.copyWith(nameStateStatus: NameStateStatus.loading));
  //     final countriesData = await babyNamesService.getCountries();
  //     final selectedNames = await babyNamesService.getSelectedNames();
  //     emit(state.copyWith(
  //       countryList: countriesData,
  //       selectedNames: selectedNames,
  //       nameStateStatus: NameStateStatus.success,
  //     ));
  //   } catch (e, s) {
  //     emit(state.copyWith(nameStateStatus: NameStateStatus.error));
  //     log('Error: $e');
  //     log('Stack Trace: $s');
  //     throw Exception();
  //   }
  // }

  // Future<void> getNames(String countryId) async {
  //   try {
  //     emit(state.copyWith(nameStateStatus: NameStateStatus.loading));
  //     final data = await babyNamesService.getGenderNames(countryId);
  //     emit(state.copyWith(
  //       names: data,
  //       nameStateStatus: NameStateStatus.success,
  //     ));
  //     log('AFTER SUCCESS: ${state.nameStateStatus}');
  //   } catch (e, s) {
  //     emit(state.copyWith(nameStateStatus: NameStateStatus.error));
  //     log('Error: $e');
  //     log('Stack Trace: $s');
  //     throw Exception();
  //   }
  // }

  // Future<void> updateSelectedNames() async {
  //   try {
  //     // emit(state.copyWith(nameStateStatus: NameStateStatus.loading));
  //     final selecteds = await babyNamesService.getSelectedNames();
  //     // final updatedData = await babyNamesService.getGenderNames(countryId);
  //     emit(state.copyWith(
  //       selectedNames: selecteds,
  //       // nameStateStatus: NameStateStatus.success
  //     ));
  //   } catch (e, s) {
  //     // emit(state.copyWith(nameStateStatus: NameStateStatus.error));
  //     log('Error: $e');
  //     log('Stack Trace: $s');
  //     throw Exception();
  //   }
  // }

  // Future<void> selectName({String? nameId, String? countryId}) async {
  //   try {
  //     emit(state.copyWith(selectNameStatus: SelectNameStatus.loading));
  //     final isSuccess = await babyNamesService.selectName(nameId!);
  //     if (isSuccess) {
  //       log('Name selected successfully');
  //       await updateSelectedNames();
  //       if (countryId != null) {
  //         final data = await babyNamesService.getGenderNames(countryId);
  //         emit(state.copyWith(names: data));
  //       }
  //       emit(state.copyWith(selectNameStatus: SelectNameStatus.success));
  //     } else {
  //       log('Name selection failed');
  //       emit(state.copyWith(selectNameStatus: SelectNameStatus.error));
  //     }
  //   } catch (e, s) {
  //     emit(state.copyWith(selectNameStatus: SelectNameStatus.error));
  //     log('Error: $e');
  //     log('Stack Trace: $s');
  //     throw Exception();
  //   }
  // }
}
