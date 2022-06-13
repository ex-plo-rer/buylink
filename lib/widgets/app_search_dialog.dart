import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:buy_link/widgets/special_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppSearchDialog extends StatelessWidget {
  const AppSearchDialog({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.onChangedMin,
    required this.onChangedMax,
    required this.onClearFilter

  }) : super(key: key);
  final double value;
  final void Function(double)? onChanged;
  final void Function(String)? onChangedMin;
  final void Function(String)? onChangedMax;
  final void Function ()? onClearFilter;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
    child:
    Stack(
    children: <Widget>[
      Positioned(
        right: 0.0,
        top: 0.0,
        child: InkResponse(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
              Icons.cancel,
              color: Colors.white,
            size: 26

          ),
        ),
      ),

     Container (
       margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
         padding: EdgeInsets.fromLTRB(10, 0, 10,0),
         height: 330,
         width: 330,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10

             ), color: Colors.white ),
         child:

     Column (

       children: <Widget>[
       Spacing.mediumHeight(),
      Container (
        child: Column (children: <Widget>[
          Text ("Filter", style:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.grey1),),
          Spacing.mediumHeight(),

         Align(
           alignment: Alignment.topLeft,
             child: Text ("Distance",style:
             TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey1), textAlign: TextAlign.start,)),
          Slider (onChanged: onChanged ,
            value: value,
              min: 1,
            max: 15,
          ),
          Spacing.smallWidth(),
          Align(
              alignment: Alignment.topLeft,
         child: Text ("Price Range", style:
         TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey1),)),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SpecialTextField(
                  tit: 'Min Price',
                  sub: '# ',
                  onChanged: onChangedMin,
                ),
              ),
              Spacing.mediumWidth(),
              Expanded(
                child: SpecialTextField(
                  tit: 'Max Price',
                  sub: '# ',
                  onChanged: onChangedMax,
                ),
              ),
            ],
          ),
          Spacing.smallHeight(),

          Spacing.smallHeight(),
          Align(
              alignment: Alignment.bottomRight,
              child:

          GestureDetector(
            onTap: onClearFilter,
              child:
              Text ("Clear Filter",style:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryColor), ))),

Spacing.largeHeight(),

GestureDetector(
  onTap: (){},
    child:
          Container (
            height: 50,
            width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10

                  ), color: AppColors.primaryColor ),
            child: Center(child:  Text ("Apply", style: TextStyle(color: Colors.white)))
          ))


        ])
      )

    ],
      )),

      ])  );
  }
}
