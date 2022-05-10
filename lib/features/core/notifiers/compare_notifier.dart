import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/core_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';

class CompareNotifier extends BaseChangeNotifier {
  final Reader _reader;

  CompareNotifier(this._reader);

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  void nextPage(index, reason) {
    _activeIndex = index;
    print('$_activeIndex $index');
    notifyListeners();
  }
}

final compareNotifierProvider = ChangeNotifierProvider<CompareNotifier>(
  (ref) => CompareNotifier(ref.read),
);
