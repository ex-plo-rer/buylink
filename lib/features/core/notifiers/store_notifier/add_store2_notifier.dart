import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class AddStore2Notifier extends BaseChangeNotifier {
  final Reader _reader;

  AddStore2Notifier(this._reader);
}

final addStore2NotifierProvider =
ChangeNotifierProvider.autoDispose<AddStore2Notifier>(
        (ref) => AddStore2Notifier(ref.read));