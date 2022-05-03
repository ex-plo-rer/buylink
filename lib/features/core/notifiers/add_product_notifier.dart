import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class AddProductNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddProductNotifier(this._reader);
}

final addProductNotifierProvider =
ChangeNotifierProvider.autoDispose<AddProductNotifier>(
        (ref) => AddProductNotifier(ref.read));