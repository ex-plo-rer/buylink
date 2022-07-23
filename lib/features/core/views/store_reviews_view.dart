import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/features/core/models/store_review_arg_model.dart';
import 'package:buy_link/features/core/views/single_rating.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_rating_bar.dart';
import 'package:buy_link/widgets/expandable_text_rev.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/svgs.dart';
import '../../../widgets/auth_dialog.dart';
import '../../../widgets/circular_progress.dart';
import '../../../widgets/expandable_text.dart';
import '../notifiers/store_notifier/store_review_notifier.dart';
import '../notifiers/user_provider.dart';

class StoreReviewsView extends ConsumerWidget {
  const StoreReviewsView({
    Key? key,
    required this.storeReviewsArgs,
  }) : super(key: key);
  final StoreReviewArgModel storeReviewsArgs;

  @override
  Widget build(BuildContext context, ref) {
    final storeReviewNotifier =
        ref.watch(storeReviewNotifierProvider(storeReviewsArgs.storeId));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark,
        ),
        leading: IconButton(
          onPressed: () => ref.read(navigationServiceProvider).navigateBack(),
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 12,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: Text(
          storeReviewsArgs.storeName,
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            // vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Container(
                height: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.shade1,
                ),
                padding: const EdgeInsets.all(10),
                child: storeReviewNotifier.reviewStatsLoading
                    ? const CircularProgress()
                    : storeReviewNotifier.reviewStats == null
                        ? const Center(
                            child: Text('An error occured'),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${storeReviewNotifier.average.isNaN ? 0 : storeReviewNotifier.average}',
                                      style: const TextStyle(
                                        fontSize: 44,
                                        color: AppColors.grey1,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    // const Spacing.tinyHeight(),
                                    Text(
                                      'Based on ${storeReviewNotifier.reviewStats!.total} reviews',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grey5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacing.tinyHeight(),
                                    RatingBar.builder(
                                      itemSize: 15,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      unratedColor: AppColors.grey7,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) =>
                                          SvgPicture.asset(AppSvgs.starFilled),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SingleRating(
                                      starNumber: '5',
                                      noOfRatings: storeReviewNotifier
                                          .reviewStats!.the5Star,
                                      ratingValue: (storeReviewNotifier
                                              .reviewStats!.the5Star /
                                          storeReviewNotifier
                                              .reviewStats!.total),
                                    ),
                                    const Spacing.smallHeight(),
                                    SingleRating(
                                      starNumber: '4',
                                      noOfRatings: storeReviewNotifier
                                          .reviewStats!.the4Star,
                                      ratingValue: (storeReviewNotifier
                                              .reviewStats!.the4Star /
                                          storeReviewNotifier
                                              .reviewStats!.total),
                                    ),
                                    const Spacing.smallHeight(),
                                    SingleRating(
                                      starNumber: '3',
                                      noOfRatings: storeReviewNotifier
                                          .reviewStats!.the3Star,
                                      ratingValue: (storeReviewNotifier
                                              .reviewStats!.the3Star /
                                          storeReviewNotifier
                                              .reviewStats!.total),
                                    ),
                                    const Spacing.smallHeight(),
                                    SingleRating(
                                      starNumber: '2',
                                      noOfRatings: storeReviewNotifier
                                          .reviewStats!.the2Star,
                                      ratingValue: (storeReviewNotifier
                                              .reviewStats!.the2Star /
                                          storeReviewNotifier
                                              .reviewStats!.total),
                                    ),
                                    const Spacing.smallHeight(),
                                    SingleRating(
                                      starNumber: ' 1',
                                      noOfRatings: storeReviewNotifier
                                          .reviewStats!.the1Star,
                                      ratingValue: (storeReviewNotifier
                                              .reviewStats!.the1Star /
                                          storeReviewNotifier
                                              .reviewStats!.total),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),
              const Spacing.bigHeight(),
              const Divider(thickness: 2),
              const Spacing.tinyHeight(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (ref.watch(userProvider).currentUser == null) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: AppColors.transparent,
                            builder: (BuildContext context) {
                              return const AuthDialog();
                            },
                          );
                          return;
                        }
                        ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.addReview,
                              arguments: storeReviewsArgs.storeId,
                            );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppSvgs.addReviewIcon,
                              width: 16, height: 16),
                          const Spacing.tinyWidth(),
                          const Text(
                            ' Add Review',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                    ),
                  ],
                ),
              ),
              const Spacing.tinyHeight(),
              const Divider(thickness: 2),
              const Spacing.mediumHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconNTextContainer(
                    onTap: () {
                      storeReviewNotifier.starTapped(star: 0);
                    },
                    text: 'All',
                    textColor: storeReviewNotifier.textColor0,
                    containerColor: storeReviewNotifier.containerColor0,
                    icon: storeReviewNotifier.is0Selected
                        ? SvgPicture.asset(AppSvgs.starFilled)
                        : SvgPicture.asset(AppSvgs.star),
                    radius: 6,
                    fontSize: 14,
                  ),
                  IconNTextContainer(
                    onTap: () {
                      storeReviewNotifier.starTapped(star: 5);
                    },
                    text: '5',
                    textColor: storeReviewNotifier.textColor5,
                    containerColor: storeReviewNotifier.containerColor5,
                    icon: storeReviewNotifier.is5Selected
                        ? SvgPicture.asset(AppSvgs.starFilled)
                        : SvgPicture.asset(AppSvgs.star),
                    radius: 6,
                    fontSize: 14,
                  ),
                  IconNTextContainer(
                    onTap: () {
                      storeReviewNotifier.starTapped(star: 4);
                    },
                    text: '4',
                    textColor: storeReviewNotifier.textColor4,
                    containerColor: storeReviewNotifier.containerColor4,
                    icon: storeReviewNotifier.is4Selected
                        ? SvgPicture.asset(AppSvgs.starFilled)
                        : SvgPicture.asset(AppSvgs.star),
                    radius: 6,
                    fontSize: 14,
                  ),
                  IconNTextContainer(
                    onTap: () {
                      storeReviewNotifier.starTapped(star: 3);
                    },
                    text: '3',
                    textColor: storeReviewNotifier.textColor3,
                    containerColor: storeReviewNotifier.containerColor3,
                    icon: storeReviewNotifier.is3Selected
                        ? SvgPicture.asset(AppSvgs.starFilled)
                        : SvgPicture.asset(AppSvgs.star),
                    radius: 6,
                    fontSize: 14,
                  ),
                  IconNTextContainer(
                    onTap: () {
                      storeReviewNotifier.starTapped(star: 2);
                    },
                    text: '2',
                    textColor: storeReviewNotifier.textColor2,
                    containerColor: storeReviewNotifier.containerColor2,
                    icon: storeReviewNotifier.is2Selected
                        ? SvgPicture.asset(AppSvgs.starFilled)
                        : SvgPicture.asset(AppSvgs.star),
                    radius: 6,
                    fontSize: 14,
                  ),
                  IconNTextContainer(
                    onTap: () {
                      storeReviewNotifier.starTapped(star: 1);
                    },
                    text: '1',
                    textColor: storeReviewNotifier.textColor1,
                    containerColor: storeReviewNotifier.containerColor1,
                    icon: storeReviewNotifier.is1Selected
                        ? SvgPicture.asset(AppSvgs.starFilled)
                        : SvgPicture.asset(AppSvgs.star),
                    radius: 6,
                    fontSize: 14,
                  ),
                  Container(),
                ],
              ),
              const Spacing.mediumHeight(),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: storeReviewNotifier.reviewsLoading
                      ? 4
                      : storeReviewNotifier.reviews.isEmpty
                          ? 1
                          : storeReviewNotifier.reviews.length,
                  separatorBuilder: (context, index) =>
                      const Spacing.bigHeight(),
                  itemBuilder: (context, index) => storeReviewNotifier
                          .reviewsLoading
                      ? const CircularProgress()
                      : storeReviewNotifier.reviews.isEmpty
                          ? const Center(
                              child: Text('No reviews available'),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.grey8,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppColors.shade3,
                                              radius: 16,
                                              child: Text(
                                                'Goodness'.initials(),
                                                style: const TextStyle(
                                                    color: AppColors.light,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            const Spacing.tinyWidth(),
                                            const Spacing.tinyWidth(),
                                            Text(
                                              storeReviewNotifier
                                                      .reviews[index].name ??
                                                  'Goodness',
                                              style: const TextStyle(
                                                color: AppColors.grey1,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              storeReviewNotifier
                                                  .reviews[index].time,
                                              style: const TextStyle(
                                                color: AppColors.grey5,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Spacing.tinyWidth(),
                                            AppRatingBar(
                                              itemSize: 12,
                                              itemPadding: 0,
                                              ignoreGestures: true,
                                              onRatingUpdate: (rating) {},
                                              initialRating: storeReviewNotifier
                                                  .reviews[index].star
                                                  .toDouble(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacing.tinyHeight(),
                                  Visibility(
                                    visible: storeReviewNotifier
                                        .reviews[index].title.isNotEmpty,
                                    child: Text(
                                      storeReviewNotifier.reviews[index].title,
                                      style: const TextStyle(
                                          color: AppColors.grey2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const Spacing.tinyHeight(),
                                  /*ExpandableText(
                                    text:
                                        storeReviewNotifier.reviews[index].body,
                                    // text: 'A super-comfortable denim legging,built to contour curves, lengthen legs and celebrate your qwew ewewe dsfsfsd fwsfddwfwefd asfdsffsd wef',
                                    trimLines: 4,
                                  ),*/

                                  /*StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setState) {
                              return LayoutBuilder(
                                builder: (context, size) {
                                  // Build the textspan
                                  var span = TextSpan(
                                    text: storeReviewNotifier
                                        .reviews[index].body,
                                    // text: 'Love this app. I lost my vision three years ago and was told that this app is very useful. I use it almost daily on the go in at home. Everything works pretty seamless except for the color reader whicLove this app. I lost my vision three years ago and was told that this app is very useful. I use it almost daily on the go in at home. Everything works pretty seamless except for the color reader whic',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.grey5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );

                                  // Use a textpainter to determine if it will exceed max lines
                                  var tp = TextPainter(
                                      maxLines: 4,
                                      textDirection: TextDirection.ltr,
                                      text: span,
                                      ellipsis: '...');

                                  // trigger it to layout
                                  tp.layout(maxWidth: size.maxWidth);

                                  // whether the text overflowed or not
                                  var exceeded = tp.didExceedMaxLines;

                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        span,
                                        overflow: TextOverflow.fade,
                                        maxLines: 4,
                                      ),
                                      if (exceeded)
                                        GestureDetector(
                                          onTap: () {
                                            // setState(() => selectedRadio = value);
                                          },
                                          child: const Text(
                                            'See more',
                                            style: TextStyle(
                                              color: AppColors.grey4,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            }
                        ),*/
                                  ExpandableTextRev(
                                      text: storeReviewNotifier
                                          .reviews[index].body,
                                      trimLines: 4)
                                  // Text.rich(
                                  //   span,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   maxLines: maxLines,
                                  // ),
                                ],
                              ),
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
