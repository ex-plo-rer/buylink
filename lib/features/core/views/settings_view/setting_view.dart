import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/features/core/views/settings_view/term_of_use.dart';
import 'package:buy_link/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/svgs.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/settings_notifier/setting_notifier.dart';
import '../../notifiers/user_provider.dart';

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
              const Spacing.mediumHeight(),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    const Spacing.smallWidth(),
                    Image.asset("assets/images/setting.png"),
                    const Spacing.smallWidth(),
                    const Text(
                      'Settings',
                      style: const TextStyle(fontSize: 24),
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
              const Spacing.largeHeight(),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Account Settings",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey3),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                height: 220,
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
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Change User Name",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.user,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        ref
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.editUser);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(
                        color: AppColors.shade4,
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Change Email Address",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.document,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                      onTap: () {
                        ref
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.changeEmail);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(
                        color: AppColors.shade4,
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Change Password",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.key,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        ref
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.changePassword);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.shade4),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Delete Account",
                        style: const TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.trash,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                      onTap: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.deleteUser),
                    ),
                  ],
                ),
              ),
              const Spacing.smallHeight(),
              Container(
                margin: const EdgeInsets.all(20),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.shade1,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  children: <Widget>[
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Notification",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.bell2,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        ref
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.settingNotification);
                      },
                    )
                  ],
                ),
              ),
              const Spacing.smallHeight(),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Help",
                  style: TextStyle(
                      color: AppColors.grey3,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
              const Spacing.mediumHeight(),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 164,
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
                    // ListTile(
                    //   onTap: () {
                    //     // ref
                    //     //     .read(navigationServiceProvider)
                    //     //     .navigateToNamed(Routes.customerSupport);
                    //   },
                    //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    //   title: Text(
                    //     "Customer Support",
                    //     style: TextStyle(
                    //         color: AppColors.shade6,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    //   leading: SvgPicture.asset(
                    //     AppSvgs.headset,
                    //     width: 14,
                    //     height: 14,
                    //   ),
                    //   trailing: Icon(
                    //     Icons.keyboard_arrow_right,
                    //     color: AppColors.shade5,
                    //   ),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: const Divider(
                    //     color: AppColors.shade4,
                    //   ),
                    // ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Privacy policy",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.lock,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.shade5,
                      ),
                      onTap: () {
                        ref
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.privacyPolicy);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Divider(color: AppColors.shade4),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "Terms of use",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.document,
                        width: 14,
                        height: 14,
                      ),
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
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        "About Buylink",
                        style: TextStyle(
                            color: AppColors.shade6,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: SvgPicture.asset(
                        AppSvgs.info,
                        width: 14,
                        height: 14,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: AppColors.shade5),
                      onTap: () {
                        ref
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.about);
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
                          onText2Pressed: () => settingNotifier.logOut(),
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
