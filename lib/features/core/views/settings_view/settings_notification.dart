import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/app_toggle_button.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../services/navigation_service.dart';
import '../../notifiers/settings_notifier/settings_notification_notifier.dart';

class SettingNotification extends ConsumerStatefulWidget {
  SettingNotification({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SettingNotificationClass();
}

class SettingNotificationClass extends ConsumerState<SettingNotification> {
  @override
  Widget build(BuildContext context) {
    final settingNotifier = ref.watch(settingNotificationNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 14,
            color: AppColors.dark,
          ),
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Notification",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: settingNotifier.state.isLoading
            ? Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 2) - 150),
                child: const CircularProgress(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: <Widget>[
                    const Spacing.mediumHeight(),
                    AppToggle(
                      state: settingNotifier.pushStatus ?? true,
                      type: "push",
                      title: "Push notifications",
                      subtitle:
                          "Notifies you of events even when you’re not in the app",
                      onChanged: (bool value) {
                        print(value);
                        settingNotifier.toggleStatus(
                            text: 'push', status: value);
                        // settingNotifier.setNotification(
                        //     text: 'push', fetchState: value);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.grey6),
                    ),
                    AppToggle(
                      state: settingNotifier.productStatus ?? true,
                      type: "product",
                      title: "Product alert notifications",
                      subtitle:
                          "Notifies you of your favorite products in range.",
                      onChanged: (bool value) {
                        print(value);
                        settingNotifier.toggleStatus(
                            text: 'product', status: value);
                        // settingNotifier.setNotification(
                        //     text: 'product', fetchState: value);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.grey6),
                    ),
                    AppToggle(
                      state: settingNotifier.chatStatus ?? true,
                      type: "chat",
                      title: "Chat notifications",
                      subtitle: "Notifies you of messages in your inbox",
                      onChanged: (bool value) {
                        settingNotifier.toggleStatus(
                            text: 'chat', status: value);
                        print(value);
                        // settingNotifier.setNotification(
                        //     text: 'chat', fetchState: value);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(
                        color: AppColors.grey6,
                      ),
                    ),
                    AppToggle(
                      state: settingNotifier.emailStatus ?? true,
                      type: "email",
                      title: "Email Notifications",
                      subtitle:
                          "Notifies you of important occurrences from Buylink",
                      onChanged: (bool value) {
                        settingNotifier.toggleStatus(
                            text: 'email', status: value);
                        print(value);
                        // settingNotifier.setNotification(
                        //     text: 'email', fetchState: value);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
