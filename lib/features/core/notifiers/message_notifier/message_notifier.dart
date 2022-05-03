import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class MessageViewNotifier extends BaseChangeNotifier {
  final Reader _reader;

  MessageViewNotifier(this._reader);

}

final messageViewNotifierProvider =
ChangeNotifierProvider<MessageViewNotifier>((ref) => MessageViewNotifier(ref.read));
