import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class DashboardNotifier extends BaseChangeNotifier {
  final Reader _reader;

  DashboardNotifier(this._reader);

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
}

final dashboardChangeNotifier = ChangeNotifierProvider<DashboardNotifier>(
    (ref) => DashboardNotifier(ref.read));
