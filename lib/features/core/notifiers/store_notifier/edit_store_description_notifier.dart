import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class EditStoreDescNotifier extends BaseChangeNotifier {
  final Reader _reader;
  EditStoreDescNotifier(this._reader) {
  }
}

final editStoreDescNotifierProvider =
ChangeNotifierProvider<EditStoreDescNotifier>((ref) => EditStoreDescNotifier(ref.read));