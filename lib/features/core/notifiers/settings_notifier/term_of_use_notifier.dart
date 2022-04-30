import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class TermNotificationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  TermNotificationNotifier(this._reader);

}

final termNotifierProvider =
ChangeNotifierProvider<TermNotificationNotifier>((ref) => TermNotificationNotifier(ref.read));
