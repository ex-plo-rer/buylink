import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class DefaultHomeNotifier extends BaseChangeNotifier {
  final Reader _reader;

  DefaultHomeNotifier(this._reader) {
    // decideNavigation();
  }
}

final defaultHomeNotifierProvider =
ChangeNotifierProvider<DefaultHomeNotifier>((ref) => DefaultHomeNotifier(ref.read));
