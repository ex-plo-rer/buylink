import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';
import 'edit_store_description_notifier.dart';

class EditStoreNameNotifier extends BaseChangeNotifier {
  final Reader _reader;
  EditStoreNameNotifier(this._reader) {
  }
}

final editStoreNameNotifierProvider =
ChangeNotifierProvider<EditStoreNameNotifier>((ref) => EditStoreNameNotifier(ref.read));