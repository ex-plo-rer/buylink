import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child : Stack (
            children:<Widget> [

              Positioned(
                top: 10,
                left:10,
                child: Text ("4.5"),
              ),

              Positioned(
                top: 10,
                left:10,
                child: Text ("Based on 60 reviews"),
              ),

              Positioned(
                top: 10,
                left:10,
                child: Text ("4.5"),
              ),

              Positioned (child: Column (children: <Widget>[
                Row (children: <Widget> [
                  Text ("5"),
                  Icon(Icons.star_border),

                  Text ("(40)"),

                ]),



              ],) ),
            ]
        )


    );}}