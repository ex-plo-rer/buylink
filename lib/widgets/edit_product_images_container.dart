import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProductImagesContainer extends ConsumerWidget {
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;

  const EditProductImagesContainer({
    Key? key,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 144,
      width: double.maxFinite,
      // Check if at least there is one image to display
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 68,
                  // width: 160,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: image1 == null
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                              image1!,
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              const Spacing.tinyWidth(),
              Expanded(
                child: Container(
                  height: 68,
                  // width: 160,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: image2 == null
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                              image2!,
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
            ],
          ),
          const Spacing.tinyHeight(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 68,
                  // width: 160,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: image3 == null
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                              image3!,
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              const Spacing.tinyWidth(),
              Expanded(
                child: Container(
                  height: 68,
                  // width: 160,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: image4 == null
                        ? null
                        : DecorationImage(
                            image: CachedNetworkImageProvider(
                              image4!,
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
