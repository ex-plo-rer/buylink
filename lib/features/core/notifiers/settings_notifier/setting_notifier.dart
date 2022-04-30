import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/utilities/base_change_notifier.dart';

class SettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SettingNotifier(this._reader);

}

final settingNotifierProvider =
ChangeNotifierProvider<SettingNotifier>((ref) => SettingNotifier(ref.read));
