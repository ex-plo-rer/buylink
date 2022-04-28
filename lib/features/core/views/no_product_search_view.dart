import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/no_product_search_notifier.dart';

class NoProductView extends ConsumerWidget {
  NoProductView({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, ref) {
    final noProductNotifier = ref.watch(noProductNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center (child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacing.largeHeight(),
            Image.asset("assets/images/no_product.png"),
            const Spacing.largeHeight(),
            const Padding(
                padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                child: Text("Oops we couldn’t find any match", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,)),
            const Text ("Try searching with another keyword ", style: TextStyle(fontSize: 12),)
          ],
        )));}}