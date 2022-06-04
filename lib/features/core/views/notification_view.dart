import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/product_notification_model.dart';
import 'package:buy_link/features/core/views/message_view/message_view.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/spacing.dart';
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
        : ref.read(notificationNotifierProvider).fetchMessages();
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
                    : ref.read(notificationNotifierProvider).fetchMessages(),
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
    final notificationNotifier = ref.watch(notificationNotifierProvider);
    return Scaffold(
      body: notificationNotifier.messagesLoading
          ? const CircularProgress()
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: notificationNotifier.messages.isEmpty
                  ? 1
                  : notificationNotifier.messages.length,
              itemBuilder: (context, index) =>
                  notificationNotifier.messages.isEmpty
                      ? const Center(
                          child: Text('Empty'),
                        )
                      : GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            title: Text(
                              notificationNotifier.messages[index].name,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.shade3,
                              child: Text(notificationNotifier
                                  .messages[index].name
                                  .initials()),
                              radius: 24,
                            ),
                            subtitle: Text(
                              notificationNotifier.messages[index].msg,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Column(children: [
                              SizedBox(height: 6),
                              CircleAvatar(
                                backgroundColor: AppColors.shade3,
                                child: Text(
                                  notificationNotifier.messages[index].unread
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                radius: 10,
                              ),
                              Text(
                                notificationNotifier.messages[index].time,
                                // "${DateFormat.jm()
                                //     .format(notificationNotifier.messages[index].time)
                                //     .toString()}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ]),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => MessageView(),
                              //   ),
                              // );
                            },
                          ),
                        ),
              separatorBuilder: (__, _) => const Spacing.mediumHeight(),
            ),
    );
  }
}
