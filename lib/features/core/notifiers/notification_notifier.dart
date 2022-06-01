import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/nofication_repository.dart';
import '../../../services/base/network_exception.dart';
import '../models/product_notification_model.dart';

class NotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  NotificationNotifier(this._reader);



}

final notificationNotifierProvider =
ChangeNotifierProvider<NotificationNotifier>((ref) => NotificationNotifier(ref.read));