import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  Future<String?> changeName({
    required String name,

  }) async {
    final body = {
      'name': name,

    };
    print('Register params sent to server $body');

    var response = await networkService.post(
      'users/edit-name',
      body: body,
      headers: headers,
    );

    print('Register response $response');
    // storageService.writeSecureData(
    //     AppStrings.tokenKey, response['data']['auth_token']);
    await storageService.saveUser(response);
    // _reader(navigationServiceProvider).navigateOffAllNamed(
    //   Routes.dashboard,
    //       (p0) => false,
    // );

    print('Register response $response');
    return 'message';
  }}

final settingRepository = Provider(
  ((ref) => SettingRepository(
    ref.read,
    networkService: NetworkService(),
    storageService: LocalStorageService(),
  )),
);