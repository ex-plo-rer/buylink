import 'package:buy_link/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../widgets/app_button.dart';

class AddProductDescView extends ConsumerWidget {
  const AddProductDescView({Key? key}) : super(key: key);

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
          title: Text(
            "Product Specifics",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : <Widget>[
                      Text ("This helps your costumers locate your products faster, "
                          "all the fields are optional, so fill the field that applies to"
                          " your product"),

                      Text ("Brand", style: TextStyle(color: AppColors.grey2, fontSize: 12, fontWeight: FontWeight.w500),),

                      AppTextField(
                        style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
                        hintText: "Levi",
                      ),

                      Text ("Colors (seperate the colors by a comma(,))", style: TextStyle(color: AppColors.grey2, fontSize: 12, fontWeight: FontWeight.w500),),

                      AppTextField(
                        hintText: "Blue,Black", style: TextStyle(color: AppColors.primaryColor,
                          fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text ("Size of the product (separate the colors by a comma(,))", style: TextStyle(color: AppColors.grey2, fontSize: 12, fontWeight: FontWeight.w500),),

                      AppTextField(
                        hintText: "M,XL,L", style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
                      ),

                      Text ("Model",
                        style: TextStyle(color: AppColors.grey2, fontSize: 12, fontWeight: FontWeight.w500),),

                      AppTextField(
                        hintText: "Highwaist", style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text ("Highwaist"),

                      Container(
                          height: 200,
                          color: AppColors.light,
                          padding: EdgeInsets.all(10.0),
                          child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: new TextField(
                                        maxLines: 100,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Describe your product',
                                        ),
                                      ),
                                    ),)))),

                      Text("Care"),

                      Container(
                          height: 200,
                          color: AppColors.light,
                          padding: EdgeInsets.all(10.0),
                          child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: new TextField(
                                        maxLines: 100,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'How to take care of the product',
                                        ),
                                      ),
                                    ),)))),

                      AppButton(
                        text: "Continue",
                        backgroundColor: AppColors.primaryColor,
                        // onPressed: () => ref
                        //     .read(navigationServiceProvider)
                        //     .navigateToNamed(Routes.homeView),
                        onPressed: () {


                        },
                      ),




                    ]))));}}