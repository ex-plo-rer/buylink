import 'package:buy_link/widgets/add_store_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/store_container.dart';
import '../../notifiers/store_notifier/store_notifier.dart';

class StoreView extends ConsumerWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final storeNotifier = ref.watch(storeNotifierProvider);
    return Scaffold(
      body:  SingleChildScrollView(
        child:

            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacing.largeHeight(),
              const Spacing.smallHeight(),
              const Text(
                'My Stores',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacing.smallHeight(),
              const Spacing.smallHeight(),

       Row (
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget> [
        StoreContainer(
          storeName: 'Atinuke Store',
          starRate: 5,
          storeImage: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        ),
        StoreContainer(
          storeName: 'Atinuke Store',
          starRate: 5,
          storeImage: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        ),
      ],),


              AddStoreContainer()
            ],
          ),)
        ),

    );
  }
}