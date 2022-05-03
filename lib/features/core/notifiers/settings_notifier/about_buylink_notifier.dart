import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class AboutNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AboutNotifier(this._reader);

}

final aboutNotifierProvider =
ChangeNotifierProvider<AboutNotifier>((ref) => AboutNotifier(ref.read));
