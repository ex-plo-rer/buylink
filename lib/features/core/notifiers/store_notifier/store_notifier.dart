import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class StoreNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreNotifier(this._reader) {
  }
}

final storeNotifierProvider =
ChangeNotifierProvider<StoreNotifier>((ref) => StoreNotifier(ref.read));
