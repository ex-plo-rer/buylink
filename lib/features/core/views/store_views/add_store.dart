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
    final addstoreNotifier = ref.watch(addstoreNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: addstoreNotifier.currentPage == 1
            ? null
            : IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.dark,
          ),
          onPressed: () {
            addstoreNotifier.moveBackward();
            print(addstoreNotifier.currentPage);
            _pageController.animateToPage(
              // array starts at 0 (lol)
              addstoreNotifier.currentPage - 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          AppStrings.signup,
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
                AppLinearProgress(
                  current: addstoreNotifier.currentPage,
                  total: addstoreNotifier.totalPage,
                  value: addstoreNotifier.currentPage / addstoreNotifier.totalPage,
                ),
                const Spacing.height(12),
                SizedBox(
                  height: 400,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          const TextWithRich(
                            firstText: 'What\'s the name your?',
                            secondText: 'store?',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          Text("This helps your customer identify your store"),
                          const Spacing.height(12),
                          AppTextField(
                            title: '',
                            hintText: 'Store name',
                            hasBorder: false,
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
                          TextField(

                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWithRich(
                            firstText: 'Check',
                            secondText: 'your email',
                            fontSize: 24,
                            firstColor: AppColors.primaryColor,
                          ),
                          const Spacing.height(12),
                          const Text(
                            'Please fill in the 4 digit code we sent to your email to verify your account',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
                      Column(
                        children: [
                        Container(
                        height: 200,
                        color: Color(0xffeeeeee),
                        padding: EdgeInsets.all(10.0),
                        child: new ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 200.0,
                          ),
                          child: new Scrollbar(
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: SizedBox(
                                height: 190.0,
                                child: new TextField(
                                  maxLines: 100,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Add your text here',
                                  ),
                                ),
                              ),)))),
                          const Spacing.height(12),
                          const Spacing.largeHeight(),

                        ],
                      ),

                      Column (
                        children:<Widget>[
                          Text ("Where is your store?"),

                          Image.asset ( "assets/images/urban-earth.png",),
                          Text ("Tap the button below to locate your store"),
                          AppButton(text: "Locate Store")

                        ]
                      )

                    ],
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                      text:
                      addstoreNotifier.currentPage == addstoreNotifier.totalPage
                          ? AppStrings.signup
                          : AppStrings.next,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        addstoreNotifier.moveForward();
                        print(addstoreNotifier.currentPage);
                        _pageController.animateToPage(
                          // array starts at 0 (lol)
                          addstoreNotifier.currentPage - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    const Spacing.mediumHeight(),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'By clicking “sign up” you are agreeing to the',
                        style: TextStyle(color: AppColors.grey5),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Terms of Use and Privacy Policy',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
