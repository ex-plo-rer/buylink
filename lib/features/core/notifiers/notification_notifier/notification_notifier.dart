import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/nofication_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/message_notification_model.dart';
import '../../models/product_notification_model.dart';

class NotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  NotificationNotifier(this._reader);

  List<ProductNotificationModel> _notifications = [];
  List<ProductNotificationModel> get notifications => _notifications;

  List<MessageNotificationModel> _messages = [];
  List<MessageNotificationModel> get messages => _messages;

  bool _notificationsLoading = false;
  bool get notificationsLoading => _notificationsLoading;

  bool _messagesLoading = false;
  bool get messagesLoading => _messagesLoading;

  Future<void> fetchNotifications() async {
    try {
      _notificationsLoading = true;
      setState(state: ViewState.loading);
      _notifications =
      await _reader(notificationRepository).fetchNotifications();
      _notificationsLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _notificationsLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
      _notificationsLoading = false;
    }
  }

  Future<void> fetchMessages() async {
    try {
      _messagesLoading = true;
      setState(state: ViewState.loading);
      _messages = await _reader(notificationRepository).fetchMessages();
      _messagesLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _messagesLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
      _notificationsLoading = false;
    }
  }
}

final notificationNotifierProvider =
ChangeNotifierProvider<NotificationNotifier>(
        (ref) => NotificationNotifier(ref.read));