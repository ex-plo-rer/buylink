import 'dart:io';
import 'dart:typed_data';

import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/select_image_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/loader.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_linear_progress.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/add_store_notifier.dart';

class AddStoreView extends ConsumerStatefulWidget {
  const AddStoreView({Key? key}) : super(key: key);

  @override
  ConsumerState<AddStoreView> createState() => _AddStoreViewState();
}

class _AddStoreViewState extends ConsumerState<AddStoreView> {
  final PageController _pageController = PageController();
  final _nameFN = FocusNode();
  final _storeDescriptionFN = FocusNode();

  final _nameController = TextEditingController();
  final _storeDescriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    ref.read(addStoreNotifierProvider).initLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        children: [
                          const TextWithRich(
                            firstText: 'What\'s the name your',
                            secondText: 'store?',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "This helps your customer identify your store",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const Spacing.height(12),
                          AppTextField(
                            title: '',
                            hintText: 'Store name',
                            hasBorder: false,
                            focusNode: _nameFN,
                            controller: _nameController,
                            onChanged: addStoreNotifier.onNameChanged,
                            suffixIcon: _nameController.text.isEmpty
                                ? null
                                : GestureDetector(
                                    onTap: () => _nameController.clear(),
                                    child: const CircleAvatar(
                                      backgroundColor: AppColors.grey7,
                                      radius: 10,
                                      child: Icon(
                                        Icons.clear_rounded,
                                        color: AppColors.light,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const TextWithRich(
                            firstText: 'Describe your Store',
                            secondText: '',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          const Spacing.height(12),
                          // TextField(),
                          AppTextField(
                            hintText: 'Tell us about your store',
                            maxLines: 5,
                            focusNode: _storeDescriptionFN,
                            controller: _storeDescriptionController,
                            onChanged: addStoreNotifier.onDescriptionChanged,
                            suffixIcon: _storeDescriptionController.text.isEmpty
                                ? null
                                : GestureDetector(
                                    onTap: () {
                                      _storeDescriptionController.clear();
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: AppColors.grey7,
                                      radius: 10,
                                      child: Icon(
                                        Icons.clear_rounded,
                                        color: AppColors.light,
                                        size: 15,
                                      ),
                                    ),
                                  ),
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
                          const Spacing.height(40),
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
/*
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppButton(
                                width: MediaQuery.of(context).size.width - 100,
                                text: 'Locate Store',
                                fontSize: 16,
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ],
                          )
*/
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
                                print('imageFile.path: ${imageFile.path}');
                                addStoreNotifier.setImageFile(
                                  imageFile: imageFile.path,
                                  isImage: true,
                                );
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
                      // isLoading: addStoreNotifier.state.isLoading,
                      text: addStoreNotifier.currentPage ==
                              addStoreNotifier.totalPage
                          ? 'Create store'
                          : addStoreNotifier.currentPage == 3
                              ? 'Locate Store'
                              : AppStrings.next,
                      backgroundColor: addStoreNotifier.currentPage == 1 &&
                              _nameController.text.isEmpty
                          ? AppColors.grey6
                          : addStoreNotifier.currentPage == 2 &&
                                  _storeDescriptionController.text.isEmpty
                              ? AppColors.grey6
                              : addStoreNotifier.currentPage == 4 &&
                                      (addStoreNotifier.imageFile == null ||
                                          addStoreNotifier.logoFile == null)
                                  ? AppColors.grey6
                                  : AppColors.primaryColor,
                      onPressed: addStoreNotifier.currentPage == 1 &&
                              _nameController.text.isEmpty
                          ? null
                          : addStoreNotifier.currentPage == 2 &&
                                  _storeDescriptionController.text.isEmpty
                              ? null
                              : addStoreNotifier.currentPage == 4 &&
                                      (addStoreNotifier.imageFile == null ||
                                          addStoreNotifier.logoFile == null)
                                  ? null
                                  : () async {
                                      if (addStoreNotifier.currentPage == 3) {
                                        ref
                                            .read(navigationServiceProvider)
                                            .navigateToNamed(
                                              Routes.storeLocationPickerView,
                                            );
                                        addStoreNotifier.moveForward();
                                        _pageController.animateToPage(
                                          // array starts at 0 (lol)
                                          addStoreNotifier.currentPage - 1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn,
                                        );
                                      } else if (addStoreNotifier.currentPage ==
                                          4) {
                                        Loader(context).showLoader(text: '');
                                        await addStoreNotifier.createStore(
                                          storeName: _nameController.text,
                                          storeDescription:
                                              _storeDescriptionController.text,
                                          lon: addStoreNotifier.storeLon,
                                          lat: addStoreNotifier.storeLat,
                                          storeLogo: addStoreNotifier.logoFile!,
                                          storeImage:
                                              addStoreNotifier.imageFile!,
                                        );
                                        await ref
                                            .refresh(storeNotifierProvider)
                                            .fetchMyStores();
                                        Loader(context).hideLoader();
                                        ref
                                            .read(navigationServiceProvider)
                                            .navigateBack();
                                        addStoreNotifier.moveForward();
                                        print(addStoreNotifier.currentPage);
                                        _pageController.animateToPage(
                                          // array starts at 0 (lol)
                                          addStoreNotifier.currentPage - 1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn,
                                        );
                                      } else {
                                        addStoreNotifier.moveForward();
                                        print(addStoreNotifier.currentPage);
                                        _pageController.animateToPage(
                                          // array starts at 0 (lol)
                                          addStoreNotifier.currentPage - 1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn,
                                        );
                                      }
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
