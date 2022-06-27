import 'dart:io';

import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/message_notifier/message_list_notifier.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/features/core/views/message_view/receiver_profile_view.dart';
import 'package:buy_link/features/core/views/settings_view/change_name.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/message_bubble.dart';
import '../../../../widgets/spacing.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../notifiers/message_notifier/chat_notifier.dart';
import '../../notifiers/message_notifier/message_notifier.dart';
import 'camera_screen.dart';

class MessageView extends ConsumerWidget {
  MessageView({
    Key? key,
    required this.args,
  }) : super(key: key);
  final MessageModel args;

  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    // final chatNotifier = ref.watch(chatNotifierProvider);
    return WillPopScope(
      onWillPop: () async {
        // if (ref.watch(chatNotifierProvider).canSaveSession) {
        if (ref.watch(chatNotifierProvider).lastMessage != null) {
          Loader(context).showLoader(text: 'Saving session');
          await ref.read(chatNotifierProvider).saveSession(
                chatId: ref.watch(chatNotifierProvider).chatId,
                message: ref.watch(chatNotifierProvider).lastMessage ?? '',
                actor: args.from == 'storeMessages' ? 'store' : 'user',
              );
          // args.from == 'storeMessages'
          //     ? '${args.storeId}s'
          //     : '${ref.read(userProvider).currentUser!.id}u',
          if (args.from == 'storeMessages') {
            ref
                .read(messageListNotifierProvider)
                .getChatList(sessionId: '${args.storeId}s');
          } else if (args.from == 'notification') {
            ref.read(messageListNotifierProvider).getChatList(
                sessionId: '${ref.read(userProvider).currentUser!.id}u');
          }
          Loader(context).hideLoader();
        }
        // }

        print('Done...');
        ref.read(navigationServiceProvider).navigateBack();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          titleSpacing: 0,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 9,
            title: Text(
              args.name,
              style: const TextStyle(color: Colors.white),
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.shade3,
              child: args.imageUrl == null ? Text(args.name.initials()) : null,
              backgroundImage: args.imageUrl == null
                  ? null
                  : CachedNetworkImageProvider(args.imageUrl!),
              radius: 20,
            ),
/*
            subtitle: const Text(
              "Online 3hr ago",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
*/
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Setting Icon',
              onPressed: () {
                ref.read(navigationServiceProvider).navigateToNamed(
                    Routes.receiverProfileView,
                    arguments: args);
              },
            ), //IconButton
          ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // messageList(),
              StreamBuilder<QuerySnapshot>(
                stream: ref.read(chatNotifierProvider).fetchAllMessages(
                      senderId: args.from == 'storeMessages'
                          ? '${args.storeId}s'
                          : '${ref.read(userProvider).currentUser!.id}u',
                      // else, You are either coming from storeDetails or notification. hence, the sender is the currentuser's id
                      // The only time I'll be passing the receiver id is when I want to initiate a chat.
                      // I'll have to use the id gotten from the server in other places (storeMessages & notification)
                      receiverId:
                          args.from == 'storeDetails' ? '${args.id}s' : args.id,
                    ),
                builder: (context, snapshot) {
                  List<MessageBubble> messageBubbles = [];
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data != null) {
                    final messages = snapshot.data?.docs.reversed;
                    if (messages!.isNotEmpty) {
                      print('messages is not empty');
                      ref.read(chatNotifierProvider).saveLastMessage(
                            message: messages.first.get('text'),
                            messageTime:
                                (messages.first.get('timeStamp') as Timestamp)
                                    .toDate(),
                          );
                    }
                    for (var message in messages) {
                      final messageText = message.get('text');
                      final messageSenderId = message.get('senderId');
                      print('Sender id: $messageSenderId');
                      final messageIsImage = message.get('isImage');
                      final timeStamp =
                          (message.get('timeStamp') as Timestamp).toDate();
                      messageBubbles.add(
                        MessageBubble(
                          senderId: messageSenderId,
                          text: messageText,
                          currentUserId:
                              '${ref.read(userProvider).currentUser!.id}u',
                          timeStamp: timeStamp,
                          isImage: messageIsImage,
                          // isUser: args.fromUser,
                          storeId: args.storeId != null
                              ? '${args.storeId}s'
                              : args.storeId,
                        ),
                      );
                    }
                  }

                  return Expanded(
                    child: ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Spacing.empty();
                      },
                      itemCount: messageBubbles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messageBubbles[index];
                      },
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AppTextField(
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
                        contentPadding: 15,
                        borderRadius: 8,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // IconButton(
                            //   // constraints: const BoxConstraints(),
                            //   icon: const Icon(
                            //     Icons.camera_alt_outlined,
                            //     color: AppColors.grey5,
                            //   ),
                            //   onPressed: () => {
                            //     ref
                            //         .read(navigationServiceProvider)
                            //         .navigateToNamed(Routes.cameraScreen)
                            //   },
                            //   //onSendMessage(textEditingController.text, TypeMessage.text),
                            //   color: AppColors.dark,
                            // ),
                            IconButton(
                              // iconSize: 10,
                              // padding: EdgeInsets.zero,
                              // constraints: const BoxConstraints(),
                              icon: Transform.rotate(
                                angle: 45 * math.pi / -180,
                                child: const Icon(
                                  Icons.attachment,
                                  color: AppColors.grey5,
                                  size: 18,
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
                                      null) {
                                    ref.watch(chatNotifierProvider).sendMessage(
                                          messageText: ref
                                              .watch(chatNotifierProvider)
                                              .imageUrl!,
                                          senderId: args.from == 'storeMessages'
                                              ? '${args.storeId}s'
                                              : '${ref.read(userProvider).currentUser!.id}u',
                                          // else, You are either coming from storeDetails or notification. hence, the sender is the currentuser's id
                                          // senderId: args.from
                                          //     ? '${ref.read(userProvider).currentUser!.id}u'
                                          //     : '${args.storeId}s',
                                          senderName:
                                              args.from == 'storeMessages'
                                                  ? args.storeName
                                                  : ref
                                                      .read(userProvider)
                                                      .currentUser!
                                                      .name,
                                          // senderImage: args.from ? null : args.imageUrl,
                                          isImage: true,
                                          // The only time I'll be passing the receiver id is when I want to initiate a chat.
                                          // I'll have to use the id gotten from the server in other places (storeMessages & notification)
                                          receiverId:
                                              args.from == 'storeDetails'
                                                  ? '${args.id}s'
                                                  : args.id,
                                        );
                                    ref.read(chatNotifierProvider).resetImage();
                                  }
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

                      //Implement send functionality.
                      ref.read(chatNotifierProvider).sendMessage(
                            messageText: messageTextController.value.text,
                            senderId: args.from == 'storeMessages'
                                ? '${args.storeId}s'
                                : '${ref.read(userProvider).currentUser!.id}u',
                            // else, You are either coming from storeDetails or notification. hence, the sender is the currentuser's id
                            // senderId: args.from
                            //     ? '${ref.read(userProvider).currentUser!.id}u'
                            //     : '${args.storeId}s',
                            senderName: args.from == 'storeMessages'
                                ? args.storeName
                                : ref.read(userProvider).currentUser!.name,
                            // senderImage: args.from ? null : args.imageUrl,
                            isImage: false,
                            // The only time I'll be passing the receiver id is when I want to initiate a chat.
                            // I'll have to use the id gotten from the server in other places (storeMessages & notification)
                            receiverId: args.from == 'storeDetails'
                                ? '${args.id}s'
                                : args.id,
                          );
                      messageTextController.clear();
                    },
                    child: Container(
                      height: 48,
                      width: 48,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
