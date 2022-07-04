import 'dart:io';

import 'package:buy_link/core/constants/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/core/notifiers/store_notifier/add_store_notifier.dart';

class SelectImageContainer extends ConsumerWidget {
  final void Function()? onTapped;
  final String text;
  final String? imageFile;

  const SelectImageContainer({
    Key? key,
    this.onTapped,
    required this.text,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
        child: SizedBox(
          height: 140,
          width: double.maxFinite,
          child: imageFile != null
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    image: DecorationImage(
                      image: FileImage(
                        File(imageFile!),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(5),
                  dashPattern: const [5, 2],
                  color: AppColors.primaryColor,
                  strokeWidth: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IconButton(
                        onPressed: onTapped,
                        icon: const Icon(
                          Icons.image_outlined,
                          size: 20,
                        ),
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.grey5,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
