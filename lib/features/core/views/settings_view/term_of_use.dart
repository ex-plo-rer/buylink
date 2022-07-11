import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../services/navigation_service.dart';
import '../../notifiers/settings_notifier/term_of_use_notifier.dart';

class TermOfUse extends ConsumerWidget {
  TermOfUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final termNotifier = ref.watch(termNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.grey2,
              size: 14,
            ),
            onPressed: () {
              ref.read(navigationServiceProvider).navigateBack();
            },
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text(
            "Terms of use",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(children: <Widget>[
                  Spacing.mediumHeight(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "User Prohibitions ",
                      style: TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacing.smallHeight(),
                  Text(
                    "Users are prohibited from: leasing, selling, copying, sublicensing, transferring, or assigning any"
                    " information, intellectual property, goods, or services provided on the site.gaining unauthorized access "
                    "to the company’s data or the data of other users."
                    "altering, modifying, adapting, reverse engineering, decompiling, disassembling, or hacking the company’s intellectual property."
                    "altering or modifying another website to falsely imply that it is associated with the company’s website."
                    "violating anyone else’s legal rights (for example, privacy rights) or any laws (for example, copyright laws) in the user’s jurisdiction."
                    "using the website or the company’s services to transmit content that could be deemed unlawful, threatening, harassing, racist, abusive, libelous, pornographic, vulgar,"
                    " defamatory, obscene, indecent, or otherwise inappropriate, including any messages constituting or encouraging criminal conduct."
                    "breaching, or attempting to breach, the website’s security systems or enabling third parties to violate the Terms of Use."
                    "using the site for any illegal purpose",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                    //maxLines: 5,
                  ),
                  Spacing.smallHeight(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age Restriction ",
                      style: TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Buylink users can be of any age group.")),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Service Interruptions and Updates  ",
                        style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Spacing.smallHeight(),
                  Text(
                    "Any website can suffer either scheduled interruptions (for maintenance and upgrades purposes) or unintended shutdowns "
                    "(for whatever reason)."
                    "There is a possibility of these happening to Buylink, in "
                    "these situation users would be notifies at least 72 hours prior and if the "
                    "occurence was unforseen, Buylink will be fully operational in at most 14 days. "
                    "Users can mail us(mail@buylink.app) about any service issue at any time.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  ),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Survival",
                        style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Spacing.smallHeight(),
                  Text(
                    "This Agreement shall be effective as of the date the User accepts the terms herein or first accesses, "
                    "downloads or uses any of the services or information on the site and shall remain in effect for"
                    " so long as the User uses or accesses any of the services provided by Buylink."
                    " The terms herein that contemplate obligations after the termination, including but not limited to "
                    "[Indemnification, Disclaimer, Limitation of Liability, Controlling Law and Severability, "
                    "and Confidentiality], shall survive termination.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  ),
                  Spacing.smallHeight(),
                  Text(
                    "Users must ensure that all of the information it submits or transmits fully complies with the law. "
                    "However, Buylink won’t be liable whatsoever for the user’s misuse of its data."
                    "Buylink also has the right to revoke or restrict the user’s access to its website, "
                    "products, or services in the event that the user violates the Terms of Use or any applicable law."
                    "Any information provided by a user will be assumed as the users sole own or that the user has enough "
                    "authorization to the data provided. Therefore Buylink will not be at risk of infringing any intellectual "
                    "property rights of third parties."
                    "All the information the company provides on its website must by treated with strict confidentiality.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  ),
                  Spacing.smallHeight(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Amendments",
                        style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                  Spacing.smallHeight(),
                  Text(
                    "Please note that Buylink might make changes to its Terms of Use from time-to-time so you should "
                    "periodically revisit the terms for any updates. However, users who continue to interact "
                    "with the site following a revision of the company’s privacy Terms of Use will automatically be subject to the new terms.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  )
                ]))));
  }
}
