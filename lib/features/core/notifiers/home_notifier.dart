import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';

class HomeNotifier extends BaseChangeNotifier {
  final Reader _reader;

  HomeNotifier(this._reader) {
    // decideNavigation();
  }

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}

final homeNotifierProvider =
    ChangeNotifierProvider<HomeNotifier>((ref) => HomeNotifier(ref.read));
