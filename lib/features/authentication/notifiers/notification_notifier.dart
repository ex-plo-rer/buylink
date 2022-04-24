import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class NotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  NotificationNotifier(this._reader);


}

final notificationNotifierProvider =
ChangeNotifierProvider<NotificationNotifier>((ref) => NotificationNotifier(ref.read));