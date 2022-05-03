import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class UserProfileNotifier extends BaseChangeNotifier {
  final Reader _reader;

  UserProfileNotifier(this._reader);

}

final userProfileNotifierProvider =
ChangeNotifierProvider<UserProfileNotifier>((ref) => UserProfileNotifier(ref.read));
