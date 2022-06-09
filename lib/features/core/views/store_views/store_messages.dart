import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/features/core/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../models/product_model.dart';

class StoreMessagesView extends ConsumerWidget {
  const StoreMessagesView({
    Key? key,
    required this.store,
  }) : super(key: key);
  final Store store;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Messages",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(4),
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                "Emmanuel",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              leading: const CircleAvatar(
                backgroundColor: AppColors.shade1,
                child: Text('DE'),
                radius: 24,
              ),
              subtitle: const Text("Good evening i wanted to ask if you... "),
              trailing: Column(
                children: <Widget>[
                  const SizedBox(height: 6),
                  const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 12),
                    ),
                    radius: 10,
                  ),
                  const Text(
                    "6 Nov",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              onTap: () {
                ref.read(navigationServiceProvider).navigateToNamed(
                      Routes.messageView,
                      arguments: MessageModel(
                        id: 7,
                        storeId: store.id,
                        name: 'store.name',
                        imageUrl: AppStrings.ronaldo,
                        fromUser: false,
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
