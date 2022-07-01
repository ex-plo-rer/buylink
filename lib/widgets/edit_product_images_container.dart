import 'dart:io';

import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:buy_link/widgets/add_product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/core/notifiers/edit_product_notifier.dart';
import '../features/core/notifiers/store_notifier/add_store_notifier.dart';

class EditProductImagesContainer extends ConsumerWidget {
  // final String text;
  // final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final void Function()? onDottedContainerTapped;

  const EditProductImagesContainer({
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
    final editProductNotifier = ref.watch(editProductNotifierProvider);
    return SizedBox(
      height: 144,
      width: double.maxFinite,
      // Check if at least there is one image to display
      child: editProductNotifier.imageList.isNotEmpty
          ? Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AddProductImageContainer(
                        imagePath: editProductNotifier.imageList[0],
                        index: 0,
                      ),
                    ),
                    const Spacing.tinyWidth(),
                    Expanded(
                      child: AddProductImageContainer(
                        imagePath: editProductNotifier.imageList.length >= 2
                            ? editProductNotifier.imageList[1]
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
                        imagePath: editProductNotifier.imageList.length >= 3
                            ? editProductNotifier.imageList[2]
                            : null,
                        index: 2,
                      ),
                    ),
                    const Spacing.tinyWidth(),
                    Expanded(
                        child: AddProductImageContainer(
                      imagePath: editProductNotifier.imageList.length >= 4
                          ? editProductNotifier.imageList[3]
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
                color: AppColors.grey7,
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

// final String? image1;
// final String? image2;
// final String? image3;
// final String? image4;
//
// const EditProductImagesContainer({
//   Key? key,
//   this.image1,
//   this.image2,
//   this.image3,
//   this.image4,
// }) : super(key: key);
//
// @override
// Widget build(BuildContext context, ref) {
//   return SizedBox(
//     height: 144,
//     width: double.maxFinite,
//     // Check if at least there is one image to display
//     child: Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 68,
//                 // width: 160,
//                 decoration: BoxDecoration(
//                   color: AppColors.transparent,
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(4),
//                   ),
//                   image: image1 == null
//                       ? null
//                       : DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             image1!,
//                           ),
//                           fit: BoxFit.fill,
//                         ),
//                 ),
//               ),
//             ),
//             const Spacing.tinyWidth(),
//             Expanded(
//               child: Container(
//                 height: 68,
//                 // width: 160,
//                 decoration: BoxDecoration(
//                   color: AppColors.transparent,
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(4),
//                   ),
//                   image: image2 == null
//                       ? null
//                       : DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             image2!,
//                           ),
//                           fit: BoxFit.fill,
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const Spacing.tinyHeight(),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 68,
//                 // width: 160,
//                 decoration: BoxDecoration(
//                   color: AppColors.transparent,
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(4),
//                   ),
//                   image: image3 == null
//                       ? null
//                       : DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             image3!,
//                           ),
//                           fit: BoxFit.fill,
//                         ),
//                 ),
//               ),
//             ),
//             const Spacing.tinyWidth(),
//             Expanded(
//               child: Container(
//                 height: 68,
//                 // width: 160,
//                 decoration: BoxDecoration(
//                   color: AppColors.transparent,
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(4),
//                   ),
//                   image: image4 == null
//                       ? null
//                       : DecorationImage(
//                           image: CachedNetworkImageProvider(
//                             image4!,
//                           ),
//                           fit: BoxFit.fill,
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}
