import 'package:buy_link/features/core/models/fetch_notification_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';

class SettingNotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SettingNotificationNotifier(this._reader) {
    fetchNotifications();
  }

  FetchNotificationModel? _notifications;

  late bool _pushStatus;

  bool get pushStatus => _pushStatus;
  late bool _productStatus;

  bool get productStatus => _productStatus;
  late bool _chatStatus;

  bool get chatStatus => _chatStatus;
  late bool _emailStatus;

  bool get emailStatus => _emailStatus;

  toggleStatus({
    required String text,
    required bool status,
  }) {
    if (text == 'push') {
      _pushStatus = status;
    } else if (text == 'product') {
      _productStatus = status;
    } else if (text == 'chat') {
      _chatStatus = status;
    } else {
      _emailStatus = status;
    }
    _reader(settingRepository).setNotification(
      type: text,
      state: status,
    );
    notifyListeners();
  }

  Future<void> fetchNotifications() async {
    try {
      setState(state: ViewState.loading);
      _notifications = await _reader(settingRepository).fetchNotification();
      _pushStatus = _notifications!.pushAlert;
      _productStatus = _notifications!.productAlert;
      _chatStatus = _notifications!.chatAlert;
      _emailStatus = _notifications!.emailAlert;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }
}

final settingNotificationNotifierProvider =
    ChangeNotifierProvider<SettingNotificationNotifier>(
        (ref) => SettingNotificationNotifier(ref.read));
