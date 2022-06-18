import 'package:buy_link/features/core/models/fetch_notification_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/strings.dart';
import '../features/core/models/user_model.dart';
import '../features/core/notifiers/user_provider.dart';
import '../services/local_storage_service.dart';
import '../services/network/network_service.dart';

class SettingRepository {
  final Reader _reader;
  final NetworkService networkService;
  final LocalStorageService storageService;

  SettingRepository(
    this._reader, {
    required this.networkService,
    required this.storageService,
  });

  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
  //Future <>
  Future<UserModel> fetchUserDetails(
      // required int id,
      ) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch products params sent to server $body');

    var response = await networkService.post(
      'users/get-details',
      body: body,
      headers: headers,
    );

    print('Fetch products response $response');

    return UserModel.fromJson(response);
  }

  Future<String?> changeName({
    required String name,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'name': name,
    };
    print('change name parameter $body');

    var response = await networkService.post(
      'users/edit-name',
      body: body,
      headers: headers,
    );

    print('change name response $response');
    await storageService.saveUser(response);
    await _reader(userProvider).setUser();
    return 'message';
  }

  Future<String?> changePassword({
    required String password,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'password': password,
    };
    print('change password parameter $body');

    var response = await networkService.post(
      'users/change-password',
      body: body,
      headers: headers,
    );

    print('change password response $response');
    return 'message';
  }

  Future<int?> checkEmail({
    required String email,
    required String reason,
    // required String passwordConfirmation,
  }) async {
    final body = {
      'email': email,
      'reason': reason,
    };
    print('Check email params sent to server $body');
    var response = await networkService.post(
      'users/get-code',
      body: body,
      headers: headers,
    );

    print('Check email response $response');
    await storageService.writeSecureData(
        AppStrings.otpEmailKey, response['code'].toString());

    print('Check email response $response');
    return response['code'];
  }

  Future<bool> checkPassword({
    required String password,
    // required String passwordConfirmation,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'password': password,
    };
    print('Check password sent to server $body');

    var response = await networkService.post(
      'users/verify',
      body: body,
      headers: headers,
    );

    print('Check password response $response');
    return response['correct'];
  }

  Future<String?> changeEmail({
    // required int id,
    required String email,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'email': email,
    };
    print('change email parameter $body');
    var response = await networkService.post(
      'users/update-email',
      body: body,
      headers: headers,
    );

    print('Change email response $response');
    await storageService.saveUser(response);
    await _reader(userProvider).setUser();

    return 'message';
  }

  Future<bool> deleteAccount({
    required String reason,
    required String details,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'reason': reason,
      'details': details,
    };
    print('delete account $body');

    var response = await networkService.post(
      'users/terminate',
      body: body,
      headers: headers,
    );

    print('Delete account response $response');
    return response['success'];
  }

  Future<FetchNotificationModel> fetchNotification() async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('fetch notification parameter $body');

    var response = await networkService.post(
      'users/load-alerts',
      body: body,
      headers: headers,
    );
    print('fetch notification response $response');
    return FetchNotificationModel.fromJson(response);
  }

  Future<bool> setNotification({
    required String type,
    required bool state,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'type': type,
      'state': state,
    };
    print('set notification $body');

    var response = await networkService.post(
      'users/set-alert',
      body: body,
      headers: headers,
    );

    print('set notification $response');
    return response['success'];
  }
}



final settingRepository = Provider(
  ((ref) => SettingRepository(
        ref.read,
        networkService: NetworkService(),
        storageService: LocalStorageService(),
      )),
);
