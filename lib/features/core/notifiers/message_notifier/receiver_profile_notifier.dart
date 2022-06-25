import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class ReceiverProfileNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ReceiverProfileNotifier(this._reader);
}

final receiverProfileNotifierProvider =
    ChangeNotifierProvider<ReceiverProfileNotifier>(
        (ref) => ReceiverProfileNotifier(ref.read));
