import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class DeleteStoreValNotifier extends BaseChangeNotifier {
  final Reader _reader;
  DeleteStoreValNotifier(this._reader) {
  }
}

final deleteStoreValNotifierProvider =
ChangeNotifierProvider<DeleteStoreValNotifier>((ref) => DeleteStoreValNotifier(ref.read));