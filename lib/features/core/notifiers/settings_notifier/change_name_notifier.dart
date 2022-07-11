import 'package:buy_link/core/routes.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';

class EditUserNameNotifier extends BaseChangeNotifier {
  final Reader _reader;

  EditUserNameNotifier(this._reader);

  String _name = '';

  String get name => _name;

  void onNameChanged(String text) {
    _name = text;
    print(_name);
    notifyListeners();
  }

  Future<void> changeName() async {
    try {
      setState(state: ViewState.loading);
      await _reader(settingRepository).changeName(
        name: name,
      );
      // await _reader(userProvider).setUser();
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.dashboard, (p0) => false);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
      _reader(navigationServiceProvider).navigateBack();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final editUserNameNotifierProvider =
    ChangeNotifierProvider<EditUserNameNotifier>(
        (ref) => EditUserNameNotifier(ref.read));
