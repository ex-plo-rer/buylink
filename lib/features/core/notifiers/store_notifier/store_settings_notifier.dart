import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class StoreSettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreSettingNotifier(this._reader) {
  }


}

final storeSettingNotifierProvider =
ChangeNotifierProvider<StoreSettingNotifier>((ref) => StoreSettingNotifier(ref.read));