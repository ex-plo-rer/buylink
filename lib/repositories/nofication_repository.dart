import 'package:buy_link/features/core/models/product_notification_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/core/notifiers/user_provider.dart';
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

  Future<List<ProductNotificationModel>> fetchNotifications() async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch products params sent to server $body');

    var response = await networkService.post(
      'users/product-notes',
      body: body,
      headers: headers,
    );

    print('Fetch products response $response');

    List<ProductNotificationModel> _notification = [];
    for (var notification in response) {
      _notification.add(ProductNotificationModel.fromJson(notification));
    }

    return _notification;


  }

}


final notificationRepository = Provider(
  ((ref) => NotificationRepository(
    ref.read,
    networkService: NetworkService(),
    storageService: LocalStorageService(),
  )),
);