import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../widgets/review_summary.dart';
import '../../../../widgets/store_review_container.dart';
import '../../notifiers/store_notifier/store_review_notifier.dart';

class StoreReviewView extends ConsumerWidget {
  const StoreReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final storeReviewNotifier = ref.watch(storeReviewNotifierProvider);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 120,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Wishlist", style: TextStyle ( color: Colors.black,)),
              Row (children: <Widget> [
                Icon (Icons.arrow_back_ios),
                Text ("Store Reviews"),
              ]
              ),
              ReviewSummary(),
              TabBar(
                isScrollable: true,

                tabs: [
                  Tab(

                      child: Row (children: <Widget> [
                        Text("All"), Icon(Icons.star_border)
                      ])
                  ),
                  Tab(
                      child: Row (children: <Widget> [
                        Text("5"), Icon(Icons.star_border)])
                  ),
                  Tab(
                      child : Row (children: <Widget> [
                        Text("4"), Icon(Icons.star_border)])),
                  Tab(

                      child: Row (children: <Widget> [
                        Text("3"), Icon(Icons.star_border)])),

                  Tab(

                      child: Row (children: <Widget> [
                        Text("2"), Icon(Icons.star_border)])),
                  Tab(
                      child: Row (children: <Widget> [
                        Text("1"), Icon(Icons.star_border)]))
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllStarScreen(),
            FiveStarScreen(),
            FourStarScreen(),
            ThreeStarScreen(),
            TwoStarScreen(),
            OneStarScreen()

          ],
        ),
      ),
    );

  }}
class OneStarScreen extends StatefulWidget {
  @override
  _OneStarScreenState createState() => _OneStarScreenState();
}

class _OneStarScreenState extends State<OneStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
            child: Column (

                children: <Widget> [


                ]
            )));}}

class TwoStarScreen extends StatefulWidget {
  @override
  _TwoStarScreenState createState() => _TwoStarScreenState();
}

class _TwoStarScreenState extends State<TwoStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
            child: Column (

                children: <Widget> []
            )));}}

class ThreeStarScreen extends StatefulWidget {
  @override
  _ThreeStarScreenState createState() => _ThreeStarScreenState();
}

class _ThreeStarScreenState extends State<ThreeStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
            child: Column (

                children: <Widget> []
            )));}}

class FourStarScreen extends StatefulWidget {
  @override
  _FourStarScreenState createState() => _FourStarScreenState();
}

class _FourStarScreenState extends State<FourStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
            child: Column (

                children: <Widget> []
            )));}}


class FiveStarScreen extends StatefulWidget {
  @override
  _FiveStarScreenState createState() => _FiveStarScreenState();
}

class _FiveStarScreenState extends State<FiveStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
            child: Column (

                children: <Widget> []
            )));}}


class   AllStarScreen extends StatefulWidget {
  @override
  _AllStarScreenState createState() => _AllStarScreenState();
}

class _AllStarScreenState extends State<AllStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
            child: Column (

                children: <Widget> [ListView  (

                    children: <Widget>[
                      StoreReviewCard(),
                      StoreReviewCard ()

                    ]

                )]
            )));}}