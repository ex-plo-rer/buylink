import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/local_storage_service.dart';
import '../models/user_model.dart';

class UserProvider extends BaseChangeNotifier {
  final Reader _reader;
  UserProvider(this._reader) {
    setUser();
    // setToken();
  }

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  // String? _token;
  // String? get token => _token;

  Future<void> setUser() async {
    print('Get user called');
    _currentUser = await _reader(localStorageService).getUser();
    print(
        'getUser(), current user : ${_currentUser?.name}, ${_currentUser?.id}');
    notifyListeners();
    // return _currentUser;
  }

  // Future<void> setToken() async {
  //   String? tok =
  //       await _reader(localStorageService).readSecureData(AppStrings.tokenKey);
  //
  //   _token = 'Bearer $tok';
  //   print('getToken(), current _token : ${_token}');
  //   notifyListeners();
  //   // return _token;
  // }
}

final userProvider = Provider<UserProvider>((ref) => UserProvider(ref.read));
