import 'dart:io';

import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:buy_link/widgets/add_product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/core/notifiers/store_notifier/add_store_notifier.dart';

class SelectProductImageContainer extends ConsumerWidget {
  // final String text;
  // final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final void Function()? onDottedContainerTapped;
  const SelectProductImageContainer({
    Key? key,
    // required this.text,
    this.onDottedContainerTapped,
    // this.image1,
    this.image2,
    this.image3,
    this.image4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final addProductNotifier = ref.watch(addProductNotifierProvider);
    return SizedBox(
      height: 144,
      width: double.maxFinite,
      // Check if at least there is one image to display
      child: addProductNotifier.imageList.isNotEmpty
          ? Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AddProductImageContainer(
                        imagePath: addProductNotifier.imageList[0],
                        index: 0,
                      ),
                    ),
                    const Spacing.tinyWidth(),
                    Expanded(
                      child: AddProductImageContainer(
                        imagePath: addProductNotifier.imageList.length >= 2
                            ? addProductNotifier.imageList[1]
                            : null,
                        index: 1,
                      ),
                    ),
                  ],
                ),
                const Spacing.tinyHeight(),
                Row(
                  children: [
                    Expanded(
                      child: AddProductImageContainer(
                        imagePath: addProductNotifier.imageList.length >= 3
                            ? addProductNotifier.imageList[2]
                            : null,
                        index: 2,
                      ),
                    ),
                    const Spacing.tinyWidth(),
                    Expanded(
                        child: AddProductImageContainer(
                      imagePath: addProductNotifier.imageList.length >= 4
                          ? addProductNotifier.imageList[3]
                          : null,
                      index: 3,
                    )),
                  ],
                ),
              ],
            )
          : GestureDetector(
              onTap: onDottedContainerTapped,
              child: DottedBorder(
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image_outlined,
                        size: 20,
                      ),
                    ),
                    Text(
                      'You can only add upto 4 pictures of the product',
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
    );
  }
}
