import 'package:hooks_riverpod/hooks_riverpod.dart';

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
   // required int id,
    required String name,

  }) async {

    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id' : id,
      'name': name,

    };
    print('change name parameter $body');

    var response = await networkService.post(
      'users/edit-name',
      body: body,
      headers: headers,
    );

    print('Register response $response');
    print ('${response.statusCode}');
    // storageService.writeSecureData(
    //     AppStrings.tokenKey, response['data']['auth_token']);
    // storageService.saveUser(response);
    // _reader(navigationServiceProvider).navigateOffAllNamed(
    //   Routes.dashboard,
    //       (p0) => false,
    // );

    //print('Register response $response');
    return 'message';
  }}

final settingRepository = Provider(
  ((ref) => SettingRepository(
    ref.read,
    networkService: NetworkService(),
    storageService: LocalStorageService(),
  )),
);