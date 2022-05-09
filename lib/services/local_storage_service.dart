import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/constants/strings.dart';
import '../features/core/models/user_model.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  // static SharedPreferences? _preferences;
  final _storage = const FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
    print('value saved $value');
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _storage.read(key: key);
    print('readData $readData');
    return readData;
  }

  Future deleteSecureData(String key) async {
    var deleteData = await _storage.delete(key: key);
    print('Secure data with key $key deleted');
    return deleteData;
  }

  Future saveUser(var user) async {
    if (user != null) {
      print('UserModel detail $user');
      UserModel us = UserModel.fromJson(user);
      print('UserModel email @ UserModel.fromJson(user): ${us.email}');
      final value = json.encode(us.toJson());
      print('Saving json.encode(us.toJson()) $value');
      await _storage.write(key: AppStrings.userKey, value: value);
    } else {
      print('UserModel is null!');
    }
  }

  Future<UserModel?> getUser() async {
    final value = await _storage.read(key: AppStrings.userKey);
    print(
        'Getting saved user @ UserModel.fromJson(json.decode(value)) :$value');
    return value == null ? null : UserModel.fromJson(json.decode(value));
  }
}

final localStorageService = Provider((ref) => LocalStorageService());
