import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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

  final List<List<ProductNotificationModel>> _notons = [];

  List<List<ProductNotificationModel>> get notifications => _notons;

  bool _notificationsLoading = false;

  bool get notificationsLoading => _notificationsLoading;

  List<String> _periods = [];

  List<String> get periods => _periods;

  void sortNotifications(List<ProductNotificationModel> _notifications) {
    final Set<String> _thePeriods = <String>{};
    for (var notification in _notifications) {
      if (DateFormat("dd/MM/yyyy").format(notification.dateTime) ==
          DateFormat("dd/MM/yyyy").format(DateTime.now())) {
        _thePeriods.add('Today');
      } else if (DateFormat("dd/MM/yyyy").format(notification.dateTime) ==
          DateFormat("dd/MM/yyyy")
              .format(DateTime.now().subtract(const Duration(days: 1)))) {
        _thePeriods.add('Yesterday');
      } else {
        _thePeriods.add(DateFormat("dd/MM/yyyy").format(notification.dateTime));
      }
    }
    _periods = _thePeriods.toList();
    for (var period in _periods) {
      List<ProductNotificationModel> notz = [];
      final Set<ProductNotificationModel> _theNotes =
          <ProductNotificationModel>{};
      for (var notification in _notifications) {
        String tP = DateFormat("dd/MM/yyyy").format(notification.dateTime) ==
                DateFormat("dd/MM/yyyy").format(DateTime.now())
            ? 'Today'
            : DateFormat("dd/MM/yyyy").format(notification.dateTime) ==
                    DateFormat("dd/MM/yyyy").format(
                        DateTime.now().subtract(const Duration(days: 1)))
                ? 'Yesterday'
                : DateFormat("dd/MM/yyyy").format(notification.dateTime);
        if (tP == period) {
          _theNotes.add(notification);
        }
      }
      _notons.add(_theNotes.toList());
    }
  }

  Future<void> fetchNotifications() async {
    try {
      _notificationsLoading = true;
      setState(state: ViewState.loading);
      List<ProductNotificationModel> _notifications =
          await _reader(notificationRepository).fetchNotifications();

/*
      _notifications.addAll([
        ProductNotificationModel(
            id: 1,
            product: 'product4',
            image: 'image',
            lat: 2,
            lon: 2,
            dateTime: DateTime.now().subtract(const Duration(days: 2))),
        ProductNotificationModel(
            id: 1,
            product: 'product5',
            image: 'image',
            lat: 2,
            lon: 2,
            dateTime: DateTime.now().subtract(const Duration(days: 1))),
        ProductNotificationModel(
            id: 1,
            product: 'product2',
            image: 'image',
            lat: 2,
            lon: 2,
            dateTime: DateTime.now().subtract(const Duration(hours: 3))),
        ProductNotificationModel(
            id: 1,
            product: 'product3',
            image: 'image',
            lat: 2,
            lon: 2,
            dateTime: DateTime.now().subtract(const Duration(hours: 2))),
        ProductNotificationModel(
            id: 1,
            product: 'product1',
            image: 'image',
            lat: 2,
            lon: 2,
            dateTime: DateTime.now()),
      ]);
*/
      sortNotifications(_notifications.reversed.toList());
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

  void dump() {
    _notons.clear();
    setState(state: ViewState.idle);
    notifyListeners();
  }
}

final notificationNotifierProvider =
    ChangeNotifierProvider<NotificationNotifier>(
        (ref) => NotificationNotifier(ref.read));
