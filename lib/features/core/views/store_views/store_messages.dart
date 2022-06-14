import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/message_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/message_notifier/message_list_notifier.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/circular_progress.dart';

class StoreMessagesView extends ConsumerStatefulWidget {
  const StoreMessagesView({
    Key? key,
    required this.store,
  }) : super(key: key);
  final Store store;

  @override
  ConsumerState<StoreMessagesView> createState() => _StoreMessagesViewState();
}

class _StoreMessagesViewState extends ConsumerState<StoreMessagesView> {
  @override
  void initState() {
    // TODO: implement initState
    print('_StoreMessagesViewState Init state called');
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref
          .read(messageListNotifierProvider)
          .getChatList(sessionId: '${widget.store.id}s');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messageListNotifier = ref.watch(messageListNotifierProvider);
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
      body: messageListNotifier.state.isLoading
          ? const CircularProgress()
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(4),
              itemCount: messageListNotifier.chats.isEmpty
                  ? 1
                  : messageListNotifier.chats.length,
              itemBuilder: (context, index) => messageListNotifier.chats.isEmpty
                  ? const Center(
                      child: Text(
                          'You don\'t have an active conversation going on'),
                    )
                  : ListTile(
                      title: Text(
                        messageListNotifier.chats[index].name,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.shade1,
                        child: Text(
                            messageListNotifier.chats[index].name.initials()),
                        radius: 24,
                      ),
                      subtitle: Text(messageListNotifier.chats[index].msg),
                      trailing: messageListNotifier.chats[index].unreadCount < 1
                          ? const Spacing.empty()
                          : Column(
                              children: <Widget>[
                                const SizedBox(height: 6),
                                CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                    messageListNotifier.chats[index].unreadCount
                                        .toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  radius: 10,
                                ),
                                Text(
                                  messageListNotifier.chats[index].parsedTime,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                      onTap: () {
                        ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.messageView,
                              arguments: MessageModel(
                                // This should be the id of this specific index in this listview
                                id: '${messageListNotifier.chats[index].userId}u',
                                storeId: widget.store.id,
                                storeName: widget.store.name,
                                name: messageListNotifier.chats[index].name,
                                imageUrl:
                                    messageListNotifier.chats[index].image,
                                from: 'storeMessages',
                              ),
                            );
                      },
                    ),
              separatorBuilder: (_, __) => const Spacing.smallHeight(),
            ),
    );
  }
}
