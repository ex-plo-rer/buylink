import 'dart:io';

import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddProductImageContainer extends ConsumerWidget {
  const AddProductImageContainer({
    Key? key,
    required this.imagePath,
    required this.index,
  }) : super(key: key);
  final String? imagePath;
  final int index;

  @override
  Widget build(BuildContext context, ref) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            print('Pick file Clicked');
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.image,
              withData: true,
            );

            if (result != null) {
              File imageFile = File((result.files.single.path) as String);
              print('File @@@@@@@@@@ : $imageFile');
              print('imageFile.path: ${imageFile.path}');
              ref.read(addProductNotifierProvider).setImageFile(
                    imageFile: imageFile.path,
                    imageIndex: index,
                  );
            } else {
              // User canceled the picker
            }
          },
          child: Container(
            height: 68,
            // width: 160,
            decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              image: imagePath == null
                  ? null
                  : DecorationImage(
                      image:
                          imagePath != null && imagePath!.contains('https://')
                              ? CachedNetworkImageProvider(imagePath!)
                                  as ImageProvider
                              : FileImage(
                                  File(imagePath ?? ''),
                                ),
                      fit: BoxFit.fill,
                    ),
            ),
            child: imagePath == null
                ? const Center(
                    child: Icon(
                    Icons.image_outlined,
                    color: AppColors.grey1,
                  ))
                : null,
          ),
        ),
        Visibility(
          visible: imagePath != null,
          child: GestureDetector(
            onTap: () {
              print('Close Image was tapped');
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.dark.withOpacity(0.41),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.light,
                    size: 6.29,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
