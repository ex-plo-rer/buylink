import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';


class AddStoreNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddStoreNotifier(this._reader);
  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 4;
  int get totalPage => _totalPage;

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

final addstoreNotifierProvider =
ChangeNotifierProvider.autoDispose<AddStoreNotifier>(
        (ref) => AddStoreNotifier(ref.read));
