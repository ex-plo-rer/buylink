import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/views/message_view/message_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/notification_notifier.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final notificationNotifier = ref.watch(notificationNotifierProvider);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    elevation: 0,
                    title: Text(
                      'Notification',
                      style: TextStyle(color: AppColors.grey1, fontSize: 24),
                    ),
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      unselectedLabelColor: AppColors.shade6,
                      indicatorColor: AppColors.shade6,
                      labelColor: AppColors.shade6,
                      labelStyle: TextStyle(color: AppColors.shade6),
                      tabs: [
                        Tab(text: "Product Alert"),
                        Tab(text: "Messages"),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(children: [
                ProductAlertScreen(),
                MessageScreen(),
              ])),
        )));
  }
}

class ProductAlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(4),
          children: <Widget>[
            ListTile(
                title: Text(
                  "The Levi Jeans store is around your present location",
                  style: TextStyle(fontSize: 12),
                ),
                leading: CircleAvatar(
                  backgroundColor: AppColors.shade3,
                  child: const Text('DE'),
                  radius: 24,
                ),
                trailing: Text("2hrs ago", style: TextStyle(fontSize: 12))),
          ],
        )));
  }
}

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(4),
                children: <Widget>[
              GestureDetector(
                  onTap: () {},
                  child: ListTile(
                      title: Text(
                        "Atinuke Stores",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.shade3,
                        child: const Text('DE'),
                        radius: 24,
                      ),
                      subtitle: Text("Good evening i wanted to ask if you... "),
                      trailing: Column(children: <Widget>[
                        SizedBox(height: 6),
                        CircleAvatar(
                          backgroundColor: AppColors.shade3,
                          child:
                              const Text('1', style: TextStyle(fontSize: 12)),
                          radius: 10,
                        ),
                        Text("10 am", style: TextStyle(fontSize: 12)),
                      ]),
                    onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=> MessageView()));
        },

                  ))
            ])));
  }
}
