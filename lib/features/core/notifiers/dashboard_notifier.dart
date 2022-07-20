import 'dart:collection';

import 'package:buy_link/features/core/models/check_msg_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/core_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';

class DashboardNotifier extends BaseChangeNotifier {
  final Reader _reader;

  DashboardNotifier(this._reader) {
    checkMsgs();
  }

  CheckMsgModel? _checkMsg;

  CheckMsgModel? get checkMsg => _checkMsg;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final ListQueue<int> _navigationQueue = ListQueue();

  ListQueue<int> get navigationQueue => _navigationQueue;

  Future<void> onBottomNavTapped(int index) async {
    _navigationQueue.addLast(_selectedIndex);
    _selectedIndex = index;
    notifyListeners();
  }

  void willPopM() {
    _selectedIndex = _navigationQueue.last;
    _navigationQueue.removeLast();
    notifyListeners();
  }

  void resetIndex() {
    _selectedIndex = 0;
    notifyListeners();
  }

  Future<void> checkMsgs() async {
    try {
      // _categoriesLoading = true;
      setState(state: ViewState.loading);
      _checkMsg = await _reader(coreRepository).checkMsg();
      // _categoriesLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      // _categoriesLoading = false;
      setState(state: ViewState.error);
      _reader(navigationServiceProvider).navigateBack();
      // Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }
}

final dashboardChangeNotifier = ChangeNotifierProvider<DashboardNotifier>(
    (ref) => DashboardNotifier(ref.read));
