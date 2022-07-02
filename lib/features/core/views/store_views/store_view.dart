import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/add_store_button.dart';
import 'package:buy_link/widgets/app_empty_states.dart';
import 'package:buy_link/widgets/circular_progress.dart';
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
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(
      //     color: AppColors.dark, //change your color here
      //   ),
      //   elevation: 0,
      //   backgroundColor: AppColors.transparent,
      //   title: const Text(
      //     'My Stores',
      //     style: TextStyle(
      //       color: AppColors.dark,
      //       fontSize: 14,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
        body: SafeArea(
            child:Padding(
              padding:  EdgeInsets.fromLTRB(18, 24, 18, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      'My Stores',
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacing.largeHeight(),
                    storeNotifier.state.isLoading
                        ? const CircularProgress()
                        : storeNotifier.state.isError
                        ? const Center(
                      child: Text('Errrrrrrrror'),
                    )
                        : storeNotifier.myStores.isEmpty
                        ? AppEmptyStates(
                      imageString: AppImages.emptyStore,
                      message1String: 'No Store Added Yet',
                      message2String:
                      'Tap the button below to create your first store',
                      onButtonPressed: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.addstoreView),
                      hasButton: true,
                      buttonString: 'Create Store',
                    )
                        : Expanded(
                      child: MasonryGridView.count(
                        itemCount: storeNotifier.myStores.length + 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 12,
                        itemBuilder: (context, index) {
                          if (index == storeNotifier.myStores.length) {
                            return AddStoreContainer(
                              onTapped: () => ref
                                  .read(navigationServiceProvider)
                                  .navigateToNamed(Routes.addstoreView),
                            );
                          } else {
                            return StoreContainer(
                              storeName: storeNotifier.myStores[index].name,
                              starRate: storeNotifier.myStores[index].star,
                              storeImage: storeNotifier.myStores[index].logo,
                              onTap: () => ref
                                  .read(navigationServiceProvider)
                                  .navigateToNamed(
                                Routes.storeDashboard,
                                arguments: storeNotifier.myStores[index],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ] ),
            )));
  }
}