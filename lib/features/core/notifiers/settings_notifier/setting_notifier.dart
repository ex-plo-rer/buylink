import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/user_model.dart';

class SettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  UserModel? _userDetails;
  UserModel get userDetails => _userDetails!;

  SettingNotifier(this._reader);


  Future<void> fetchUser(
    //required int id,
  ) async {
    try {
      //setState(state: ViewState.loading);
      _userDetails = await _reader(settingRepository).fetchUserDetails(
         // id: 0

      );

      // Alertify(title: 'User logged in').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }

}

final settingNotifierProvider =
ChangeNotifierProvider<SettingNotifier>((ref) => SettingNotifier(ref.read));
