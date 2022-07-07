import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_review_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_dialog.dart';
import 'package:buy_link/widgets/review_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/loader.dart';
import '../../../widgets/add_review_rate_bar.dart';
import '../../../widgets/app_rating_bar.dart';
import '../notifiers/add_review_notifier.dart';

class AddReviewView extends ConsumerWidget {
  AddReviewView({
    Key? key,
    required this.storeId,
  }) : super(key: key);

  final int storeId;

  final _formKey = GlobalKey<FormState>();

  final reviewTitleFN = FocusNode();
  final reviewCommentFN = FocusNode();

  final reviewTitleController = TextEditingController();
  final reviewCommentController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final addReviewNotifier = ref.watch(addReviewNotifierProvider);
    return WillPopScope(
      onWillPop: () async {
        if (addReviewNotifier.rating > 0 ||
            reviewTitleController.text.isNotEmpty ||
            reviewCommentController.text.isNotEmpty) {
          await showDialog(
            context: context,
            builder: (context) => AppDialog(
              title: 'Are you sure you want to discard your review?',
              text1: 'No',
              text2: 'Yes',
              onText1Pressed: () {
                ref.read(navigationServiceProvider).navigateBack();
              },
              onText2Pressed: () {
                ref.read(navigationServiceProvider).navigateBack();
                ref.read(navigationServiceProvider).navigateBack();
              },
            ),
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.dark, //change your color here
          ),
          leading: IconButton(
            onPressed: () {
              ref.read(navigationServiceProvider).navigateBack();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              size: 12,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text(
            'Add Review',
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // vertical: 16,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Your reviews are public and would only include your name',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey2,
                        fontSize: 12,
                      ),
                    ),
                    const Spacing.bigHeight(),
                    const Divider(
                      thickness: 2,
                      color: AppColors.grey8,
                    ),
                    const Text(
                      'Your overall rating of the store',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey2,
                        fontSize: 12,
                      ),
                    ),
                    const Spacing.smallHeight(),
                    AppRatingBar(
                      initialRating: 0,
                      itemSize: 30,
                      onRatingUpdate: addReviewNotifier.onRatingUpdate,
                    ),
                    const Divider(
                      thickness: 2,
                      color: AppColors.grey8,
                    ),
                    Spacing.smallHeight(),
                    ReviewTextField(
                      hintText: 'summarize your review',
                      focusNode: reviewTitleFN,
                      controller: reviewTitleController,
                      title: 'Title of your review (optional)',
                      onChanged: addReviewNotifier.onTitleChanged,
                      noOfChar: addReviewNotifier.titleCharacters,
                      maxLength: 100,
                    ),
                    const Spacing.height(20),
                    ReviewTextField(
                      hintText:
                          'Describe your experience shopping at the store',
                      focusNode: reviewCommentFN,
                      controller: reviewCommentController,
                      title: 'How was your experience? (optional)',
                      onChanged: addReviewNotifier.onCommentChanged,
                      noOfChar: addReviewNotifier.commentCharacters,
                      maxLength: 300,
                      maxLine: 9,
                    ),
                    const Spacing.height(40),
                    AppButton(
                      // isLoading: addReviewNotifier.state.isLoading,
                      text: 'Post Review',
                      backgroundColor: addReviewNotifier.rating < 1
                          ? AppColors.grey6
                          : AppColors.primaryColor,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (addReviewNotifier.rating < 1) {
                            Alertify(
                              title: 'You must at least choose a rating',
                            ).error();
                            return;
                          }
                          Loader(context).showLoader(text: '');
                          await addReviewNotifier.addReview(
                            storeId: storeId,
                            star: addReviewNotifier.rating,
                            title: reviewTitleController.text,
                            body: reviewCommentController.text,
                          );
                          await ref
                              .refresh(storeReviewNotifierProvider(storeId));
                          Loader(context).hideLoader();
                          Alertify(title: 'Your review has been added')
                              .success();
                          ref.read(navigationServiceProvider).navigateBack();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
