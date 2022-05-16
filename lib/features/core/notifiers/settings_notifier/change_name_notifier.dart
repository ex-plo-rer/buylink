import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';

class EditUserNameNotifier extends BaseChangeNotifier {
  final Reader _reader;

  Future<void> changeName({
    required String name,

  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(settingRepository).changeName(
        name: name,
      );

    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }

  EditUserNameNotifier(this._reader) {
  }
}

final editUserNameNotifierProvider =
ChangeNotifierProvider<EditUserNameNotifier>((ref) => EditUserNameNotifier(ref.read));