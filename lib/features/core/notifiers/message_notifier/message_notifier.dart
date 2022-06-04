import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class MessageViewNotifier extends BaseChangeNotifier {
  final Reader _reader;

  MessageViewNotifier(this._reader);

  void pickFile() async {

    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    final file = result.files.first;

    openFile(file);
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }


}

final messageViewNotifierProvider =
ChangeNotifierProvider<MessageViewNotifier>((ref) => MessageViewNotifier(ref.read));
