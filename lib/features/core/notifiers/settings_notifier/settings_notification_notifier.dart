import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class SettingNotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SettingNotificationNotifier(this._reader);

}

final settingNotificationNotifierProvider =
ChangeNotifierProvider<SettingNotificationNotifier>((ref) => SettingNotificationNotifier(ref.read));
