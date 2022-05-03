import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class StoreMessagesNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreMessagesNotifier(this._reader) {
  }
}

final storeMessgaesNotifierProvider =
ChangeNotifierProvider<StoreMessagesNotifier>((ref) => StoreMessagesNotifier(ref.read));
