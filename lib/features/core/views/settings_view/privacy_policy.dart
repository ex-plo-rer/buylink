import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/settings_notifier/privacy_policy_notifier.dart';

class PrivacyPolicy extends ConsumerWidget {
  PrivacyPolicy ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final privacyNotifier = ref.watch(privacyNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading:  IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined, size: 15,
              color: AppColors.grey2,
            ),
            onPressed: () {},),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text("Privacy policy",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding (
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Column(children: <Widget>[
                  Spacing.mediumHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text ("Personal Information", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("Buylink collects your personal data including but not exclusive to your email, name, telephone at sign up. "
                      "Users might also provide more personal information when they have created their account."
                      "Note that the amount of information you provide is completely voluntary; however, "
                      "providing less information might limit your ability to access all of the site’s features."
                      "Users should carefully protect the personal information that they submit on "
                      "the site including but not exlusive to their passwords — so that third parties can’t manipulate "
                      "their accounts or assume their identities."
                      "Only information you are comfortable showing others might be uploaded."),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child:Text("Data Usage and Analytics", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("Buylink uses the data collected to analyze how users access and utilizes the site. "
                      "This data is valuable to the company for various internal purposes, including troubleshooting and "
                      "improving the site’s functionality."
                      "Information including but not exclusive to your operating system, IP address, web browser, "
                      "location etc might be collected."),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Notifications", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("Buylink might use personal information for periodic general announcements to users. "
                      "These can include notifications, updates regarding the company or the site, marketing communications, and so forth. "
                      "You can always unsuscribe from getting these notifications."),
                  Spacing.smallHeight(),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text ("Third Party Service Providers", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("Buylink might need to use personal user data in connection with but not exclusive to website maintenance, upgrades, "
                      "new releases, or analytics data review or compilation."
                      "Buylink might be required to share user data with any third-party service providers that it might engage to assist in"
                      " these efforts. Similarly, Buylink might have to share user information in connection with third-party marketing or"
                      " advertising services."
                      "Buylink will however ensure that these service providers employ adequate security measures with respect to user data."),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child:Text ("Data Sharing", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("As a general policy, we use personal information for internal purposes only. "
                      "We do not sell or rent information about you. We will never disclose personal information to third parties without your"
                      " consent, except as explained in this Privacy Policy."
                      "Buylink will be able to share user data with its affiliated entities, including parent companies and subsidiaries. "
                      "Furthermore, if Buylink participates in a merger, stock purchase, asset purchase, or other acquisition, "
                      "it will be required to share user information with the purchaser or surviving entity."
                      "Buylink cooperates with government and law enforcement officials to enforce and comply with the law. "
                      "We may therefore disclose personal information, usage data, and any other information about you, "
                      "if we deem that it is reasonably necessary to: (a) satisfy any applicable law, regulation, "
                      "legal process (such as a subpoena or court order), or enforceable governmental request; "
                      "(b) enforce the Terms of Use, including investigation of potential violations thereof; (c) "
                      "detect, prevent, or otherwise address fraud, security or technical issues; or (d) protect against "
                      "harm to the rights, property or safety of the Company, its users or the public, as required or permitted by law."),
                  Spacing.smallHeight(),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text ("Security", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("Buylink will use all necessary methods it can to secure it's users data. "
                      "Please note that it’s impossible for Buylink to completely guarantee that user data will be immune from malicious "
                      "attack or compromise; as such, users should understand that their transmission of personal data is always at their own risk."),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text ("Future Changes", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),)),
                  Spacing.smallHeight(),
                  Text ("Please note that Buylink might make changes to its privacy policy from time-to-time so you should periodically "
                      "revisit the policy for any updates. However, users who continue to interact with the site following a revision of "
                      "the company’s privacy policy will automatically be subject to the new terms.")
                ]))));}}