import 'package:buy_link/core/routes.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/spacing.dart';
import '../../models/product_model.dart';
import '../../notifiers/store_notifier/store_settings_notifier.dart';

class StoreSetting extends ConsumerWidget {
  final Store store;

  StoreSetting({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final storeSettingsNotifier = ref.watch(storeSettingNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined,
              color: AppColors.dark, size: 14),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Store Settings",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Spacing.mediumHeight(),
            ListTile(
              title: const Text(
                "Store Name",
                style: TextStyle(
                  color: AppColors.grey3,
                ),
              ),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.storefront_outlined,
                  size: 18,
                  color: AppColors.grey2,
                ),
                backgroundColor: AppColors.grey8,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey5,
              ),
              onTap: () {
                ref.read(navigationServiceProvider).navigateToNamed(
                      Routes.editStoreName,
                      arguments: store,
                    );
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Divider(
                color: AppColors.grey7,
              ),
            ),
            ListTile(
                title: const Text(
                  "Store Description",
                  style: TextStyle(
                    color: AppColors.grey3,
                  ),
                ),
                leading: const CircleAvatar(
                  child: Icon(Icons.vpn_key_rounded,
                      size: 18, color: AppColors.grey2),
                  backgroundColor: AppColors.grey8,
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.grey5,
                ),
                onTap: () {
                  ref.read(navigationServiceProvider).navigateToNamed(
                        Routes.editStoreDesc,
                        arguments: store,
                      );
                }),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Divider(
                color: AppColors.grey7,
              ),
            ),
            ListTile(
              title: const Text(
                "Store Location",
                style: TextStyle(
                  color: AppColors.grey3,
                ),
              ),
              leading: const CircleAvatar(
                child:
                    Icon(Icons.location_city, size: 18, color: AppColors.grey2),
                backgroundColor: AppColors.grey8,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey5,
              ),
              onTap: () {
                print(
                    'LatLng(store.lat, store.lon): ${store.lat}: ${store.lon}');
                ref.read(navigationServiceProvider).navigateToNamed(
                      Routes.editStoreLocationView,
                      arguments: store,
                    );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditStoreName(),
                //   ),
                // );
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const Divider(color: AppColors.grey7),
            ),
            ListTile(
              title: const Text(
                "Delete Store",
                style: TextStyle(
                  color: AppColors.grey3,
                ),
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.delete, size: 18, color: AppColors.grey2),
                backgroundColor: AppColors.grey8,
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey5,
              ),
              onTap: () {
                ref.read(navigationServiceProvider).navigateToNamed(
                      Routes.deleteStore,
                      arguments: store,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
