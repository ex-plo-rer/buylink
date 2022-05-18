import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/features/core/views/settings_view/change_name.dart';
import 'package:buy_link/features/core/views/settings_view/privacy_policy.dart';
import 'package:buy_link/features/core/views/settings_view/settings_notification.dart';
import 'package:buy_link/features/core/views/settings_view/term_of_use.dart';
import 'package:buy_link/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/settings_notifier/setting_notifier.dart';
import '../../notifiers/user_provider.dart';
import 'about_buylink.dart';
import 'change_email.dart';
import 'change_password.dart';

class SettingView extends ConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settingNotifier = ref.watch(settingNotifierProvider);
    final userProv = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: const <Widget>[
                    SizedBox(width: 20),
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.shade3,
                  child: Text(
                    userProv.currentUser?.name.initials() ?? 'US',
                    style: const TextStyle(color: Colors.white),
                  ),
                  radius: 40,
                ),
              ),
              const Spacing.smallHeight(),
              Text(
                userProv.currentUser?.name ?? 'User',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.grey1,
                ),
              ),
              const Spacing.smallHeight(),
              Text(userProv.currentUser?.email ?? 'user@gmail.com'),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Account Settings",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  color: AppColors.shade1,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        "Change Username",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.shade5,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUserName(),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(
                        color: AppColors.shade4,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Change Email Address",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: const Icon(
                        Icons.email_outlined,
                        color: AppColors.shade5,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeEmail(),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(
                        color: AppColors.shade4,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Change Password",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: const Icon(
                        Icons.vpn_key_rounded,
                        color: AppColors.shade5,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePassword(),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.shade4),
                    ),
                    const ListTile(
                      title: Text(
                        "Delete Account",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: Icon(Icons.delete, color: AppColors.shade5),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.shade1,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        "Notification",
                        style: TextStyle(color: AppColors.shade6),
                      ),
                      leading: const Icon(Icons.notifications_none,
                          color: AppColors.shade5),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingNotification(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const Spacing.mediumHeight(),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Help",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacing.mediumHeight(),
              Container(
                margin: const EdgeInsets.all(20),
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  color: AppColors.shade1,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  children: <Widget>[
                    const ListTile(
                      title: Text(
                        "Customer Support",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: Icon(
                        Icons.headset_mic_outlined,
                        color: AppColors.shade5,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(
                        color: AppColors.shade4,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Privacy policy",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: const Icon(
                        Icons.lock_outline_rounded,
                        color: AppColors.shade5,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicy(),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.shade4),
                    ),
                    ListTile(
                      title: const Text(
                        "Terms of use",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: const Icon(Icons.insert_drive_file_outlined,
                          color: AppColors.shade5),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermOfUse()));
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.shade4),
                    ),
                    ListTile(
                      title: const Text(
                        "About Buylink",
                        style: TextStyle(
                          color: AppColors.shade6,
                        ),
                      ),
                      leading: const Icon(Icons.info_outline_rounded,
                          color: AppColors.shade5),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => About()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  color: AppColors.redshade1,
                ),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(
                        Icons.power_settings_new_outlined,
                        color: AppColors.red,
                      ),
                      Spacing.smallWidth(),
                      Text(
                        "Log Out",
                        style: TextStyle(color: AppColors.red, fontSize: 16),
                      ),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppDialog(
                          title: 'Are you sure you want to log out?',
                          text1: 'No',
                          text2: 'Yes',
                          onText2Pressed: () => ref
                              .read(navigationServiceProvider)
                              .navigateToNamed(Routes.login),
                        );
                      },
                    );
                  },
                  textColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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