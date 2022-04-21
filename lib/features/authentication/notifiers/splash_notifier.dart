import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';

class SplashNotifier extends BaseChangeNotifier {

  final Reader _reader;

  SplashNotifier(this._reader);
}

final splashNotifierProvider =
ChangeNotifierProvider<SplashNotifier>((ref) => SplashNotifier(ref.read));
