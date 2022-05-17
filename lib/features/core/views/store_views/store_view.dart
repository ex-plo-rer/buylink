import 'package:buy_link/widgets/add_store_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/store_container.dart';
import '../../notifiers/store_notifier/store_notifier.dart';

class StoreView extends ConsumerWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final storeNotifier = ref.watch(storeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          'My Stores',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MasonryGridView.count(
                itemCount: 3,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
                itemBuilder: (context, index) {
                  if (index == 2) {
                    return AddStoreContainer(
                      onTapped: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.addstoreView),
                    );
                  } else {
                    return const StoreContainer(
                      storeName: 'Atinuke Store',
                      starRate: 5,
                      storeImage:
                          'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                    );
                  }
                },
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const <Widget>[
            //     Expanded(
            //       child: StoreContainer(
            //         storeName: 'Atinuke Store',
            //         starRate: 5,
            //         storeImage:
            //             'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
            //       ),
            //     ),
            //     Spacing.mediumWidth(),
            //     Expanded(
            //       child: StoreContainer(
            //         storeName: 'Atinuke Store',
            //         starRate: 5,
            //         storeImage:
            //             'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
            //       ),
            //     ),
            //   ],
            // ),
            // Spacing.mediumHeight(),
            // AddStoreContainer(
            //   onTapped: () => ref
            //       .read(navigationServiceProvider)
            //       .navigateToNamed(Routes.addstoreView),
            // ),
          ],
        ),
      ),
    );
  }
}
