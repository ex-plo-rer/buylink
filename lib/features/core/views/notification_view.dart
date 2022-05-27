import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/views/message_view/message_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/spacing.dart';
import '../notifiers/notification_notifier.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({Key? key}) : super(key: key);
  @override
  ConsumerState<NotificationView> createState() => _NotificationState();
}

class _NotificationState extends ConsumerState<NotificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // TODO: Make the third product fill the screen's width
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notification',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacing.mediumHeight(),
              TabBar(
                labelColor: AppColors.shade5,
                unselectedLabelColor: AppColors.grey5,
                padding: const EdgeInsets.only(bottom: 10),
                controller: _tabController,
                //isScrollable: true,
                tabs: const [
                  Tab(
                      text: "Product Alert"),
                  Tab(
                      text : "Messages"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ProductAlertScreen(),
                    MessageScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductAlertScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
             // itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
              return Column (
              children: <Widget>[
                ListTile(
                    title: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,),
                            children: <TextSpan>[
                              TextSpan ( text:
                              "A",),
                              TextSpan ( text:
                             "",
                                  style: TextStyle( fontWeight: FontWeight.bold)),
                              TextSpan ( text:
                              " store is around your present location",
                                  )
                            ]
                        )),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.shade3,
                      child: const Text('DE'),
                      radius: 24,
                    ),
                    trailing: Text("2hrs ago", style: TextStyle(fontSize: 12))),
              ],
            );}
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
                padding: EdgeInsets.zero,
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
