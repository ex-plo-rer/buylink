import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/message_model.dart';
import 'package:buy_link/features/core/notifiers/message_notifier/message_list_notifier.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/circular_progress.dart';
import '../../models/product_model.dart';

class StoreMessagesView extends ConsumerWidget {
  const StoreMessagesView({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context, ref) {
    final messageListNotifier = ref.watch(messageListNotifierProvider(id));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Messages",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: messageListNotifier.fetchingList
          ? const CircularProgress()
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(4),
              itemCount: messageListNotifier.chats.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  messageListNotifier.chats[index].name,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                leading: const CircleAvatar(
                  backgroundColor: AppColors.shade1,
                  child: Text('DE'),
                  radius: 24,
                ),
                subtitle: const Text("Good evening i wanted to ask if you... "),
                trailing: Column(
                  children: const <Widget>[
                    SizedBox(height: 6),
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Text(
                        '1',
                        style: TextStyle(fontSize: 12),
                      ),
                      radius: 10,
                    ),
                    Text(
                      "6 Nov",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(navigationServiceProvider).navigateToNamed(
                        Routes.messageView,
                        arguments: MessageModel(
                          id: 7,
                          storeId: id,
                          name: 'store.name',
                          imageUrl: AppStrings.ronaldo,
                          fromUser: false,
                        ),
                      );
                },
              ),
              separatorBuilder: (_, __) => const Spacing.smallHeight(),
            ),
    );
  }
}
