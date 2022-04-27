import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class EmptyStateNotifier extends BaseChangeNotifier {
  final Reader _reader;

  EmptyStateNotifier(this._reader);
}

final emptyStateNotifierProvider =
ChangeNotifierProvider.autoDispose<EmptyStateNotifier>(
        (ref) => EmptyStateNotifier(ref.read));
