import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class DashboardNotifier extends BaseChangeNotifier {
  final Reader _reader;

  DashboardNotifier(this._reader);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  // void setSelectedIndex(int? index) {
  //   if (index != null) {
  //     _selectedIndex = index;
  //     notifyListeners();
  //   }
  // }

  Future<void> onBottomNavTapped(int index) async {
    _selectedIndex = index;
    notifyListeners();
  }
}

final dashboardChangeNotifier = ChangeNotifierProvider<DashboardNotifier>(
    (ref) => DashboardNotifier(ref.read));
