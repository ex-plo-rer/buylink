import 'dart:math' as math;

import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/message_notifier/chat_notifier.dart';

class CustomerSupportView extends ConsumerWidget {
  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    // final chatNotifier = ref.watch(chatNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        titleSpacing: 0,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 9,
          title: Text(
            "Name",
            style: const TextStyle(color: Colors.white),
          ),
          leading: CircleAvatar(
            backgroundColor: AppColors.shade3,
            // child:
            // args.imageUrl == null ? Text(args.name.initials()) : null,
            // backgroundImage: args.imageUrl == null
            //     ? null
            //     : CachedNetworkImageProvider(args.imageUrl!),
            radius: 20,
          ),
          subtitle: const Text(
            "Online 3hr ago",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        //<Widget>[]
        backgroundColor: AppColors.shade7,
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 16,
          ),
          tooltip: 'Back arrow',
          onPressed: () => ref.read(navigationServiceProvider).navigateBack(),
        ),
        //IconButton
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Positioned(
                bottom: 0,
                left: 2,
                right: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: AppTextField(
                          style: TextStyle(
                              color: AppColors.grey3,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                          hintText: 'Type something...',
                          controller: messageTextController,
                          fillColor: AppColors.grey10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          hasBorder: false,
                          contentPadding: 19,
                          borderRadius: 8,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                // iconSize: 10,
                                // padding: EdgeInsets.zero,
                                // constraints: const BoxConstraints(),
                                icon: Transform.rotate(
                                  angle: 45 * math.pi / -180,
                                  child: const Icon(
                                    Icons.attachment,
                                    color: AppColors.grey5,
                                    size: 24,
                                  ),
                                ),
                                onPressed: () async {
                                  print('Pick file Clicked');
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                    withData: true,
                                  );

                                  if (result != null) {
                                    Loader(context).showLoader(text: '');
                                    await ref
                                        .watch(chatNotifierProvider)
                                        .uploadFile(result.files.first);
                                    if (ref
                                            .watch(chatNotifierProvider)
                                            .imageUrl !=
                                        null) {}
                                    Loader(context).hideLoader();
                                    // File imageFile = File(
                                    //     (result.files.single.path) as String);
                                    // print('File @@@@@@@@@@ : $imageFile');
                                    // print('imageFile.path: ${imageFile.path}');
                                    // // addStoreNotifier.setImageFile(
                                    // //   imageFile: imageFile.path,
                                    // //   isImage: true,
                                    // // );
                                    // result.files.first.name;
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                //onSendMessage(textEditingController.text, TypeMessage.text),
                                color: AppColors.dark,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacing.smallWidth(),
                    GestureDetector(
                      onTap: () {
                        if (messageTextController.value.text.isEmpty) {
                          Alertify(title: 'Kindly enter some text').error();
                          return;
                        }

                        messageTextController.clear();
                      },
                      child: Container(
                        height: 52,
                        width: 49,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Transform.rotate(
                          angle: 45 * math.pi / -180,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
