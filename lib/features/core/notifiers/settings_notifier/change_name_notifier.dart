import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class EditUserNameNotifier extends BaseChangeNotifier {
  final Reader _reader;
  EditUserNameNotifier(this._reader) {
  }
}

final editUserNameNotifierProvider =
ChangeNotifierProvider<EditUserNameNotifier>((ref) => EditUserNameNotifier(ref.read));