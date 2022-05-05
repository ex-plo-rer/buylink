import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/strings.dart';
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

  Future<String?> register({
    required String name,
    required String email,
    required String mobileNum,
    required String password,
    required String passwordConfirmation,
    String? referredBy,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'mobile_number': mobileNum,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'referred_by': referredBy,
    };
    print('Register params sent to server $body');

    var response = await networkService.post(
      'user/register',
      body: body,
      headers: headers,
    );

    // storageService.writeSecureData(
    //     AppStrings.tokenKey, response['data']['auth_token']);
    storageService.writeSecureData(
      AppStrings.otpEmailKey,
      response['data']['user']['email'],
    );

    print('Register response $response');
    return response['message'];
  }

  // Future<UserModel> login({
  Future<bool> login({
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
    // await storageService.saveUser(response['data']['user']);
    return response['success'];
    // return UserModel.fromJson(response['data']['user']);
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
