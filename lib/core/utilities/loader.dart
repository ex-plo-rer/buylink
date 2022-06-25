import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

class Loader {
  Loader(this.context);

  final BuildContext context;

  showLoader({
    required String text,
  }) {
    // AlertDialog alert = AlertDialog(
    //     actionsPadding: EdgeInsets.zero,
    //     buttonPadding: EdgeInsets.zero,
    //     contentPadding: EdgeInsets.zero,
    //     insetPadding: EdgeInsets.zero,
    //     titlePadding: EdgeInsets.zero,
    //     content: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 50),
    //           child: Image.asset(AppImages.staticLoader),
    //         ),
    //         Image.asset(AppImages.loader),
    //         const Spacing.empty(),
    //       ],
    //     ));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return WillPopScope(onWillPop: () async => false, child: alert);
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            decoration: const BoxDecoration(color: Color(0xffE5E5E5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                    AppImages.staticLoader,
                    width: 28,
                    height: 25,
                  ),
                ),
                Image.asset(
                  AppImages.loader,
                  width: 38,
                  height: 25,
                ),
                const Spacing.empty(),
              ],
            ),
          ),
        );
      },
    );
  }

  // hideLoader() => Navigator.of(context).pop();
  hideLoader() => Navigator.of(context).pop();
}
