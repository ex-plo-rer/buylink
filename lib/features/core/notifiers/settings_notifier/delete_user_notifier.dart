import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class DeleteUserNotifier extends BaseChangeNotifier {
  final Reader _reader;
  DeleteUserNotifier(this._reader) {
  }
}

final deleteUserNotifierProvider =
ChangeNotifierProvider<DeleteUserNotifier>((ref) => DeleteUserNotifier(ref.read));