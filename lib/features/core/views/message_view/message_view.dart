import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/features/core/views/message_view/user_profile_view.dart';
import 'package:buy_link/features/core/views/settings_view/change_name.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/message_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../notifiers/message_notifier/chat_notifier.dart';
import '../../notifiers/message_notifier/message_notifier.dart';
import 'camera_screen.dart';

class MessageView extends ConsumerWidget {
  MessageView({Key? key}) : super(key: key);

  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final messageNotifier = ref.watch(messageViewNotifierProvider);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            "Atinuke Stores",
            style: TextStyle(color: Colors.white),
          ),
          leading:
              CircleAvatar(child: Image.asset("assets/images/user_avatar.png")),
          //leading: (Image.asset('assets/images/round_image.png')),
          subtitle: const Text("Online 3hr ago",
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        actions: <Widget>[
          //IconButton
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Setting Icon',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: AppColors.shade7,
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 16,
          ),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
        //IconButton
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // messageList(),
            StreamBuilder<QuerySnapshot>(
              stream: ref.read(chatNotifierProvider).fetchAllMessages(),
              builder: (context, snapshot) {
                List<MessageBubble> messageBubbles = [];
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.data != null) {
                  final messages = snapshot.data?.docs.reversed;
                  for (var message in messages!) {
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    final messageIsImage = message.get('isImage');
                    final timeStamp =
                        (message.get('timeStamp') as Timestamp).toDate();
                    messageBubbles.add(
                      MessageBubble(
                        sender: messageSender,
                        text: messageText,
                        currentUserEmail:
                            ref.read(userProvider).currentUser?.email ??
                                'user@gmail.com',
                        timeStamp: timeStamp,
                        isImage: messageIsImage,
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
                      return const SizedBox(height: 0);
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
                          IconButton(
                            // constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.grey5,
                            ),
                            onPressed: () => {
                              ref
                                  .read(navigationServiceProvider)
                                  .navigateToNamed(Routes.cameraScreen)
                            }, //onSendMessage(textEditingController.text, TypeMessage.text),
                            color: AppColors.dark,
                          ),
                          IconButton(
                            // iconSize: 10,
                            // padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Transform.rotate(
                              angle: 45 * math.pi / -180,
                              child: const Icon(
                                Icons.attachment,
                                color: AppColors.grey5,
                                size: 18,
                              ),
                            ),
                            onPressed: () => {
                              messageNotifier.pickFile()
                            }, //onSendMessage(textEditingController.text, TypeMessage.text),
                            color: AppColors.dark,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacing.smallWidth(),
                // AppButton(
                //   width: 48,
                //   height: 48,
                //   text: '',
                //   hasIcon: true,
                //   backgroundColor: AppColors.primaryColor,
                //   icon: Transform.rotate(
                //     angle: 45 * math.pi / -180,
                //     child: IconButton(
                //       icon: const Icon(
                //         Icons.send,
                //         color: Colors.white,
                //         size: 18,
                //       ),
                //       onPressed: () {
                //         if (messageTextController.value.text.isEmpty) {
                //           Alertify(title: 'Kindly enter some text').error();
                //           return;
                //         }
                //
                //         //Implement send functionality.
                //         ref.read(chatNotifierProvider).sendMessage(
                //             messageText: messageTextController.value.text);
                //         messageTextController.clear();
                //       },
                //       color: AppColors.dark,
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    if (messageTextController.value.text.isEmpty) {
                      Alertify(title: 'Kindly enter some text').error();
                      return;
                    }

                    //Implement send functionality.
                    ref.read(chatNotifierProvider).sendMessage(
                          messageText: messageTextController.value.text,
                          isImage: false,
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
    );
  }
}
