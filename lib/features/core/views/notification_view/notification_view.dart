import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/product_notification_model.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/features/core/views/message_view/message_view.dart';
import 'package:buy_link/widgets/app_empty_states.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/notification_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/chat_tile.dart';
import '../../../../widgets/spacing.dart';
import '../../models/message_model.dart';
import '../../notifiers/dashboard_notifier.dart';
import '../../notifiers/message_notifier/message_list_notifier.dart';
import '../../notifiers/notification_notifier/notification_notifier.dart';

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
    // _tabController.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationNotifierProvider).fetchNotifications();
      ref
          .read(messageListNotifierProvider)
          .getChatList(sessionId: '${ref.read(userProvider).currentUser!.id}u');
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
    final dashboardNotifier = ref.watch(dashboardChangeNotifier);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacing.mediumHeight(),
              DecoratedBox(
                  decoration: BoxDecoration(
                    //This is for background color
                    color: Colors.white.withOpacity(0.0),

                    //This is for bottom border that is needed
                    border: const Border(
                        bottom: BorderSide(color: AppColors.grey8, width: 2)),
                  ),
                  child: TabBar(
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: AppColors.grey5,
                    padding: const EdgeInsets.only(bottom: 0),
                    indicatorColor: AppColors.primaryColor,
                    controller: _tabController,
                    //isScrollable: true,
                    tabs: [
                      const Tab(text: "Product Alert"),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        const Tab(text: "Messages"),
                        const Spacing.tinyWidth(),
                        dashboardNotifier.checkMsg == null
                            ? const Spacing.empty()
                            : !dashboardNotifier.checkMsg!.unread
                                ? const Spacing.empty()
                                : const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.red,
                                      radius: 4,
                                    ),
                                  )
                      ]),
                    ],
                    // onTap: (index) => index == 0
                    //     ? ref
                    //         .read(notificationNotifierProvider)
                    //         .fetchNotifications()
                    //     : ref.read(messageListNotifierProvider).getChatList(
                    //         sessionId:
                    //             '${ref.read(userProvider).currentUser!.id}u'),
                  )),
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
          : RefreshIndicator(
              onRefresh: () async =>
                  await notificationNotifier.fetchNotifications(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: ListView.separated(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: notificationNotifier.periods.isEmpty
                        ? 1
                        : notificationNotifier.periods.length,
                    itemBuilder: (context, parentIndex) => notificationNotifier
                            .periods.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: (MediaQuery.of(context).size.height / 2) -
                                    200),
                            child: const AppEmptyStates(
                              imageString: "assets/images/no_notifications.png",
                              message1String: "No notifications yet",
                              hasButton: false,
                              buttonString: "",
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notificationNotifier.periods[parentIndex]),
                              const Spacing.mediumHeight(),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: notificationNotifier
                                    .notifications[parentIndex].length,
                                itemBuilder: (context, index) =>
                                    NotificationTile(
                                  product: notificationNotifier
                                      .notifications[parentIndex][index],
                                ),
                                separatorBuilder: (__, _) =>
                                    const Spacing.smallHeight(),
                              ),
                            ],
                          ),
                    separatorBuilder: (__, _) => const Spacing.bigHeight()),
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
          : RefreshIndicator(
              onRefresh: () async => await messageListNotifier.getChatList(
                  sessionId: '${ref.read(userProvider).currentUser!.id}u'),
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: messageListNotifier.chats.isEmpty
                    ? 1
                    : messageListNotifier.chats.length,
                itemBuilder: (context, index) => messageListNotifier
                        .chats.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                            top:
                                (MediaQuery.of(context).size.height / 2) - 200),
                        child: const AppEmptyStates(
                          imageString: "assets/images/no_messages.png",
                          message1String: "No messages yet",
                          hasButton: false,
                          buttonString: "",
                        ),
                      )
                    : ChatTile(
                        title: messageListNotifier.chats[index].name,
                        subtitle: messageListNotifier.chats[index].msg,
                        unreadCount:
                            messageListNotifier.chats[index].unreadCount,
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
                //separatorBuilder: (__, _) => const Spacing.tinyHeight(),
              ),
            ),
    );
  }
}
