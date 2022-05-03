import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class AddProductDescNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddProductDescNotifier(this._reader);
}

final addProductDescNotifierProvider =
ChangeNotifierProvider.autoDispose<AddProductDescNotifier>(
        (ref) => AddProductDescNotifier(ref.read));