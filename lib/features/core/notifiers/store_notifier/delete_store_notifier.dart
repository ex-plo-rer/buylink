import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class DeleteStoreNotifier extends BaseChangeNotifier {
  final Reader _reader;
  DeleteStoreNotifier(this._reader) {
  }
}

final deleteStoreNotifierProvider =
ChangeNotifierProvider<DeleteStoreNotifier>((ref) => DeleteStoreNotifier(ref.read));