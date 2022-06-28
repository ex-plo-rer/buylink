import 'package:buy_link/core/routes.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/strings.dart';
import '../features/core/models/user_model.dart';
import '../services/local_storage_service.dart';
import '../services/network/network_service.dart';

class AuthenticationRepository {
  final Reader _reader;
  final NetworkService networkService;
  final LocalStorageService storageService;

  AuthenticationRepository(
    this._reader, {
    required this.networkService,
    required this.storageService,
  });

  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
    // required String passwordConfirmation,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      // 'password_confirmation': passwordConfirmation,
    };
    print('Register params sent to server $body');

    var response = await networkService.post(
      'users/signup',
      body: body,
      headers: headers,
    );

    print('Register response $response');
    // storageService.writeSecureData(
    //     AppStrings.tokenKey, response['data']['auth_token']);
    await storageService.saveUser(response);
    _reader(navigationServiceProvider).navigateOffAllNamed(
      Routes.dashboard,
      (p0) => false,
    );

    print('Register response $response');
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

  Future<bool> checkEmailUniqueness({
    required String email,
  }) async {
    final body = {
      'email': email,
    };
    print('Check email uniqueness params sent to server $body');

    var response = await networkService.post(
      'users/check-email',
      body: body,
      headers: headers,
    );

    print('Check email uniqueness response $response');
    return response['unique'];
  }

  Future<bool> changePassword({
    required String email,
    required String password,
    // required String passwordConfirmation,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };
    print('Change password params sent to server $body');

    var response = await networkService.post(
      'users/change-password',
      body: body,
      headers: headers,
    );

    print('Change password response $response');
    return response['success'];
  }

  // Future<UserModel> login({
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };
    print('Login params sent to server $body');

    var response = await networkService.post(
      'users/login',
      body: body,
      headers: headers,
    );
    print('Login response $response');

    // await storageService.writeSecureData(
    //     AppStrings.tokenKey, response['data']['token']);
    await storageService.saveUser(response);
    // return response['success'];
    return UserModel.fromJson(response);
  }

// Future<String?> verifyOTP({
//   required String email,
//   required String otp,
// }) async {
//   final body = {
//     'email': email,
//     'otp': otp,
//   };
//   print('Verify otp params sent to server $body');
//
//   var response = await networkService.post(
//     'otp/verify',
//     body: body,
//     headers: headers,
//   );
//
//   print('Verify otp response $response');
//
//   return response['message'] ?? 'eeeeeeeeeeeeeee';
// }

// Future<void> logout() async {
//   print('_reader(userProvider).token: ${_reader(userProvider).token}');
//   await networkService.get('user/logout',
//       headers: {'Authorization': _reader(userProvider).token!, ...headers});
//
//   storageService.deleteSecureData(AppStrings.userKey);
//   storageService.deleteSecureData(AppStrings.tokenKey);
//   storageService.deleteSecureData(AppStrings.lastPlaceKey);
// }

// Future<String> forgotPassword({
//   required String email,
// }) async {
//   var body = {'email': email};
//   print('Body sent to server: $body');
//   var response = await networkService.post(
//     'user/password/forgot',
//     body: body,
//     headers: headers,
//   );
//   print('Response received: $response');
//   return response['message'];
// }

// Future<String> createPassword({
//   required String email,
//   required String password,
//   required String passwordConfirm,
// }) async {
//   var body = {
//     'email': email,
//     'password': password,
//     'password_confirmation': passwordConfirm,
//   };
//   print('Body sent to server: $body');
//   var response = await networkService.put(
//     'user/password/reset',
//     body: body,
//     headers: headers,
//   );
//   print('Response received: $response');
//   return response['message'];
// }
}

final authenticationRepository = Provider(
  ((ref) => AuthenticationRepository(
        ref.read,
        networkService: NetworkService(),
        storageService: LocalStorageService(),
      )),
);
