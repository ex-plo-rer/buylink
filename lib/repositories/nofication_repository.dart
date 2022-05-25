import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/local_storage_service.dart';
import '../services/network/network_service.dart';

class NotificationRepository {
  final Reader _reader;
  final NetworkService networkService;
  final LocalStorageService storageService;

  NotificationRepository(
      this._reader, {
        required this.networkService,
        required this.storageService,
      });

  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

}


final settingRepository = Provider(
  ((ref) => NotificationRepository(
    ref.read,
    networkService: NetworkService(),
    storageService: LocalStorageService(),
  )),
);