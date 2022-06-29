import 'package:buy_link/features/core/models/fetch_notification_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';

class SettingNotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SettingNotificationNotifier(this._reader){fetchNotifications();}

  FetchNotificationModel? notifications;

  Future<void> fetchNotifications() async {
    try {
      setState(state: ViewState.loading);
      notifications = await _reader(settingRepository).fetchNotification(
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }

  }


  Future<void> setNotification({required String text, required bool fetchState}) async {
    try {
      // setState(state: ViewState.loading);
      await _reader(settingRepository).setNotification(
          type: text,
          state: fetchState

      );
      await fetchNotifications();
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
     // setState(state: ViewState.idle);
    }
  }


}

final settingNotificationNotifierProvider =
ChangeNotifierProvider<SettingNotificationNotifier>((ref) => SettingNotificationNotifier(ref.read));