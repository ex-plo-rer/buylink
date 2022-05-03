import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class PrivacyNotifier extends BaseChangeNotifier {
  final Reader _reader;

  PrivacyNotifier(this._reader);

}

final privacyNotifierProvider =
ChangeNotifierProvider<PrivacyNotifier>((ref) => PrivacyNotifier(ref.read));
