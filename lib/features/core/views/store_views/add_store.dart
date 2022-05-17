import 'dart:io';
import 'dart:typed_data';

import 'package:buy_link/widgets/select_image_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_linear_progress.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/add_store_notifier.dart';

class AddStoreView extends ConsumerWidget {
  AddStoreView({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, ref) {
    final addStoreNotifier = ref.watch(addStoreNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: addStoreNotifier.currentPage == 1
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.dark,
                ),
                onPressed: () {
                  addStoreNotifier.moveBackward();
                  print(addStoreNotifier.currentPage);
                  _pageController.animateToPage(
                    // array starts at 0 (lol)
                    addStoreNotifier.currentPage - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Add a new store",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacing.mediumHeight(),
                AppLinearProgress(
                  current: addStoreNotifier.currentPage,
                  total: addStoreNotifier.totalPage,
                  value:
                      addStoreNotifier.currentPage / addStoreNotifier.totalPage,
                ),
                const Spacing.mediumHeight(),
                SizedBox(
                  height: 400,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: const [
                          TextWithRich(
                            firstText: 'What\'s the name your',
                            secondText: 'store?',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "This helps your customer identify your store",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Spacing.height(12),
                          AppTextField(
                            title: '',
                            hintText: 'Store name',
                            hasBorder: false,
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          TextWithRich(
                            firstText: 'Describe your Store',
                            secondText: '',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          Spacing.height(12),
                          // TextField(),
                          AppTextField(
                            hintText: 'Tell us about your store',
                            maxLines: 5,
                            hasPrefixIcon: false,
                            hasSuffixIcon: false,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWithRich(
                            firstText: 'Where is your store?',
                            secondText: "",
                            fontSize: 24,
                            firstColor: AppColors.grey1,
                          ),
                          const Spacing.height(12),
                          const Spacing.largeHeight(),
                          Center(
                            child: Image.asset(
                              "assets/images/add_store.png",
                            ),
                          ),
                          const Spacing.smallHeight(),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Text(
                              "Tap the button below to locate your store",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SelectImageContainer(
                            text: 'Add a picture of your store',
                            imageFile: addStoreNotifier.imageFile,
                            onTapped: () async {
                              print('Pick file Clicked');
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                withData: true,
                              );

                              if (result != null) {
                                File imageFile =
                                    File((result.files.single.path) as String);
                                print('File @@@@@@@@@@ : $imageFile');
                                // setState(() {
                                //   fileSelected = true;
                                // });
                                // Uint8List? fileBytes =
                                //     result.files.single.bytes;
                                // String fileName =
                                //     result.files.first.name;

                                // print(
                                //     'Filebyte $fileBytes: Filename $fileName');
                                print('imageFile.path: ${imageFile.path}');
                                // ref
                                //     .read(addStoreNotifierProvider)
                                //     .setImageFile(imageFile: imageFile.path);
                                addStoreNotifier.setImageFile(
                                  imageFile: imageFile.path,
                                  isImage: true,
                                );
                                // _staffImage = imageFile.path;
                                // _fileName =
                                result.files.first.name;
                              } else {
                                // User canceled the picker
                              }
                            },
                          ),
                          const Spacing.mediumHeight(),
                          SelectImageContainer(
                            text: 'Add your store\'s logo',
                            imageFile: addStoreNotifier.logoFile,
                            onTapped: () async {
                              print('Pick file Clicked');
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                withData: true,
                              );

                              if (result != null) {
                                File imageFile =
                                    File((result.files.single.path) as String);
                                print('File @@@@@@@@@@ : $imageFile');
                                print('imageFile.path: ${imageFile.path}');
                                addStoreNotifier.setImageFile(
                                  imageFile: imageFile.path,
                                  isImage: false,
                                );
                                result.files.first.name;
                              } else {
                                // User canceled the picker
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacing.largeHeight(),
                Column(
                  children: [
                    AppButton(
                      text: addStoreNotifier.currentPage ==
                              addStoreNotifier.totalPage
                          ? AppStrings.next
                          : AppStrings.next,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        addStoreNotifier.moveForward();
                        print(addStoreNotifier.currentPage);
                        _pageController.animateToPage(
                          // array starts at 0 (lol)
                          addStoreNotifier.currentPage - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    const Spacing.mediumHeight(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
