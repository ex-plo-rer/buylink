import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/product_notification_model.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/features/core/views/message_view/message_view.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../services/navigation_service.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/chat_tile.dart';
import '../../../widgets/spacing.dart';
import '../models/message_model.dart';
import '../notifiers/message_notifier/message_list_notifier.dart';
import '../notifiers/notification_notifier.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  ConsumerState<NotificationView> createState() => _NotificationState();
}

class _NotificationState extends ConsumerState<NotificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(notificationNotifierProvider).fetchNotifications();
    });
    super.initState();
  }

  void _handleTabChange() {
    _tabController.index == 0
        ? ref.read(notificationNotifierProvider).fetchNotifications()
        : ref.read(messageListNotifierProvider).getChatList(
            sessionId: '${ref.read(userProvider).currentUser!.id}u');
  }

  // TODO: Make the third product fill the screen's width
  @override
  Widget build(BuildContext context) {
    // final notificationNotifier = ref.watch(notificationNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notification',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacing.mediumHeight(),
              TabBar(
                labelColor: AppColors.shade5,
                unselectedLabelColor: AppColors.grey5,
                padding: const EdgeInsets.only(bottom: 10),
                controller: _tabController,
                //isScrollable: true,
                tabs: const [
                  Tab(text: "Product Alert"),
                  Tab(text: "Messages"),
                ],
                onTap: (index) => index == 0
                    ? ref
                        .read(notificationNotifierProvider)
                        .fetchNotifications()
                    : ref.read(messageListNotifierProvider).getChatList(
                        sessionId:
                            '${ref.read(userProvider).currentUser!.id}u'),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    ProductAlertScreen(),
                    MessageScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductAlertScreen extends ConsumerWidget {
  const ProductAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final notificationNotifier = ref.watch(notificationNotifierProvider);
    return Scaffold(
      body: notificationNotifier.notificationsLoading
          ? const CircularProgress()
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: notificationNotifier.notifications.isEmpty
                  ? 1
                  : notificationNotifier.notifications.length,
              itemBuilder: (context, int index) =>
                  notificationNotifier.notifications.isEmpty
                      ? const Center(
                          child: const Text('Empty'),
                        )
                      : Column(
                          children: <Widget>[
                            ListTile(
                              title: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: "A ",
                                    ),
                                    TextSpan(
                                      text: notificationNotifier
                                          .notifications[index].product,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const TextSpan(
                                      text:
                                          " store is around your present location",
                                    )
                                  ],
                                ),
                              ),
                              leading: const CircleAvatar(
                                backgroundColor: AppColors.shade3,
                                child: Text('DE'),
                                radius: 24,
                              ),
                              trailing: Text(
                                DateFormat.jm()
                                    .format(notificationNotifier
                                        .notifications[index].dateTime)
                                    .toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
            ),
    );
  }
}

class MessageScreen extends ConsumerWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final messageListNotifier = ref.watch(messageListNotifierProvider);
    return Scaffold(
      body: messageListNotifier.state.isLoading
          ? const CircularProgress()
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: messageListNotifier.chats.isEmpty
                  ? 1
                  : messageListNotifier.chats.length,
              itemBuilder: (context, index) => messageListNotifier.chats.isEmpty
                  ? const Center(child: Text('Empty'))
                  : ChatTile(
                      title: messageListNotifier.chats[index].name,
                      subtitle: messageListNotifier.chats[index].msg,
                      unreadCount: messageListNotifier.chats[index].unreadCount,
                      time: messageListNotifier.chats[index].parsedTime,
                      imageUrl: messageListNotifier.chats[index].image,
                      onTap: () {
                        ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.messageView,
                              arguments: MessageModel(
                                // This should be the id of this specific index in this listview
                                id: '${messageListNotifier.chats[index].storeId}s',
                                storeId: null,
                                name: messageListNotifier.chats[index].name,
                                imageUrl:
                                    messageListNotifier.chats[index].image,
                                from: 'notification',
                              ),
                            );
                      },
                    ),
              separatorBuilder: (__, _) => const Spacing.mediumHeight(),
            ),
    );
  }
}
