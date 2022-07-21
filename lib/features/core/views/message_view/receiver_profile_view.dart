import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/features/core/models/message_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/models/user_model.dart';
import 'package:buy_link/features/core/notifiers/message_notifier/chat_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/svgs.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/loader.dart';
import '../../../../widgets/app_dialog.dart';
import '../../../../widgets/app_dialog_2.dart';
import '../../notifiers/category_notifier.dart';
import '../../notifiers/message_notifier/receiver_profile_notifier.dart';

class ReceiverProfileView extends ConsumerWidget {
  const ReceiverProfileView({Key? key, required this.args}) : super(key: key);
  final MessageModel args;

  @override
  Widget build(BuildContext context, ref) {
    final receiverNotifier = ref.watch(receiverProfileNotifierProvider);
    final fromStore = args.from == 'storeMessages';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.dark,
            size: 14,
          ),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              CircleAvatar(
                backgroundColor: AppColors.shade3,
                child:
                    args.imageUrl == null ? Text(args.name.initials()) : null,
                backgroundImage: args.imageUrl == null
                    ? null
                    : CachedNetworkImageProvider(args.imageUrl!),
                radius: 30,
              ),
              const Spacing.smallHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    !fromStore
                        ? args.name
                        : args.imageUrl == null
                            ? args.name
                            : args.storeName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey1,
                    ),
                  ),
                  if (!fromStore) const SizedBox(width: 4),
                  if (!fromStore)
                    SvgPicture.asset(
                      AppSvgs.starFilled,
                      color: Colors.amber,
                      width: 12,
                      height: 12,
                    ),
                  if (!fromStore) const SizedBox(width: 4),
                  if (!fromStore)
                    const Text(
                      "4.6",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              // Text("Online 3hr ago"),
              const Spacing.mediumHeight(),
              if (!fromStore)
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.shade1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextButton(
                    //style: ButtonStyle( backgroundColor: Colors.),
                    onPressed: () async {
                      print('Store id: ${args.id}');
                      print(
                          'Store id with s: ${args.id.toString().substring(0, args.id.toString().length - 1)}');
                      // if (ref
                      //     .read(categoryNotifierProvider)
                      //     .storeCategories
                      //     .isEmpty) {
                      // Loader(context).showLoader(text: '');
                      // await ref
                      //     .read(categoryNotifierProvider)
                      //     .fetchStoreCategories(
                      //         storeId: args.id
                      //             .toString()
                      //             .substring(0, args.id.toString().length - 1));
                      // Loader(context).hideLoader();
                      ref.read(navigationServiceProvider).navigateToNamed(
                            Routes.storeDetails,
                            //TODO: Argument should be store object.
                            arguments: int.parse(args.id
                                .toString()
                                .substring(0, args.id.toString().length - 1)),
                          );
                      // } else {
                      //   ref.read(navigationServiceProvider).navigateToNamed(
                      //         Routes.storeDetails,
                      //         arguments: int.parse(args.id
                      //             .toString()
                      //             .substring(0, args.id.toString().length - 1)),
                      //       );
                      // }
                    },
                    child: const Text(
                      "View Store",
                      style: TextStyle(fontSize: 14, color: AppColors.shade5),
                    ),
                  ),
                ),
              const Spacing.largeHeight(),
              const Divider(color: AppColors.grey6),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppDialog2(
                          title: 'Delete Conversation?',
                          text1: 'No',
                          text2: 'Yes',
                          onText1Pressed: () => ref
                              .read(navigationServiceProvider)
                              .navigateBack(),
                          onText2Pressed: () async {
                            await ref
                                .read(chatNotifierProvider)
                                .deleteConversation();
                            ref.read(navigationServiceProvider).navigateBack();
                            ref.read(navigationServiceProvider).navigateBack();
                          },
                          title2:
                              '${fromStore ? args.storeName : args.name} won’t be able to send you messages',
                        );
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Block ${fromStore ? args.storeName : args.name}",
                      style: const TextStyle(color: AppColors.red),
                    ),
                  ),
                ),
              ),
              const Divider(color: AppColors.grey6),
              ListTile(
                title: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AppDialog2(
                            title: 'Delete Conversation?',
                            title2:
                                'The messages would be cleared only from your inbox',
                            text1: 'No',
                            text2: 'Yes',
                            onText1Pressed: () => ref
                                .read(navigationServiceProvider)
                                .navigateBack(),
                            onText2Pressed: () async {
                              await ref
                                  .read(chatNotifierProvider)
                                  .deleteConversation();
                              ref
                                  .read(navigationServiceProvider)
                                  .navigateBack();
                              ref
                                  .read(navigationServiceProvider)
                                  .navigateBack();
                            },
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Delete Conversation",
                      style: TextStyle(color: AppColors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
