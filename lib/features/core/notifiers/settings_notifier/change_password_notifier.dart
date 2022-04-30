import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class EditUserPasswordNotifier extends BaseChangeNotifier {
  final Reader _reader;

  EditUserPasswordNotifier(this._reader) {
  }

  int _currentPage = 1;

  int get currentPage => _currentPage;

  int _totalPage = 2;

  int get totalPage => _totalPage;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void moveBackward() {
    if (_currentPage > 1) {
      _currentPage -= 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void moveForward() async {
    if (_currentPage < _totalPage) {
      _currentPage += 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }
}

final editUserPasswordNotifierProvider =
ChangeNotifierProvider<EditUserPasswordNotifier>((ref) => EditUserPasswordNotifier(ref.read));