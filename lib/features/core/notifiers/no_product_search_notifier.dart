import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class NoProductNotifier extends BaseChangeNotifier {
  final Reader _reader;

  NoProductNotifier(this._reader);
}

final noProductNotifierProvider =
ChangeNotifierProvider.autoDispose<NoProductNotifier>(
        (ref) => NoProductNotifier(ref.read));