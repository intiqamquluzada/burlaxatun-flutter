import 'dart:developer';

import 'package:hive/hive.dart';

class TokenHiveService {
  TokenHiveService._();

  static TokenHiveService? _instance;

  static TokenHiveService get instance => _instance ??= TokenHiveService._();

  Box<String>? _tokenBox;

  get token => null;

  Future<Box<String>> initBox() async =>
      _tokenBox ??= await Hive.openBox<String>('token');

  Future<bool> saveToken(String token) async {
    try {
      await initBox();
      await _tokenBox!.put('token', token);
      log('saved token is this: $token');
      return true;
    } catch (e) {
      log('token hive error: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    await initBox();
    final String? token = _tokenBox!.get('token');
    if (token == null) {
      return null;
    }
    return token;
  }

  Future<void> clearToken() async {
    await initBox();
    await _tokenBox!.clear();
    if (_tokenBox!.isEmpty) {
      log('Successfully cleared token box');
    } else {
      log('Error while clearing token');
    }
  }
}
