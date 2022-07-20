import 'dart:io';

import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppErrorWidget extends ConsumerWidget {
  const AppErrorWidget({
    Key? key,
    this.message,
  }) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'ERROR',
          style: TextStyle(fontSize: 100),
        ),
        Text(
          message ?? '',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
