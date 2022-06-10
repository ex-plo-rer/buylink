import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class CameraScreenNotifier extends BaseChangeNotifier {
  final Reader _reader;
  CameraScreenNotifier(this._reader);
}

final cameraScreenNotifierProvider =
    ChangeNotifierProvider<CameraScreenNotifier>(
        (ref) => CameraScreenNotifier(ref.read));
