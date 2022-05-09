import 'package:flutter/material.dart';

class Loader {
  Loader(this.context);

  final BuildContext context;

  showLoader({
    required String text,
  }) {
    AlertDialog alert = AlertDialog(
      content: text.isEmpty
          ? const SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Row(
              children: [
                const CircularProgressIndicator(),
                Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: Text("$text...")),
              ],
            ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }

  // hideLoader() => Navigator.of(context).pop();
  hideLoader() => Navigator.of(context).pop();
}
