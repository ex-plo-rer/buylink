import 'package:buy_link/features/core/views/add_product_desc.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../services/navigation_service.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/text_with_rich.dart';

class AddProductView extends ConsumerWidget {
  const AddProductView({Key? key}) : super(key: key);

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
                      DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          dashPattern: [18, 10],
                          color: AppColors.grey6,
                          strokeWidth: 2,
                          child: SizedBox(
                              height: 190,
                              width: 310,
                              child: Column(children: const <Widget>[
                                const Spacing.largeHeight(),
                                const Spacing.largeHeight(),
                                 Icon(
                                    Icons.image,
                                    color: AppColors.grey5,
                                    size: 30,
                                  ),
                                Spacing.smallHeight(),

                                Text("You can only add upto 4 pictures of the product",
                                    style: TextStyle(
                                        color: AppColors.grey4, fontSize: 12))
                              ]))),

                      Text("Product Name"),
                      AppTextField(
                        hintText: 'Name of the product',
                      ),

                      Text ("Product Category"),
                      AppTextField(
                          hintText: 'Select Product Category',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_outlined
                        ),
                        ),

                      Text("Product Sub-Category"),
                      AppTextField(
                        hintText: 'Product Sub-Category',
                        suffixIcon: Icon(
                            Icons.arrow_drop_down_outlined
                        ),
                        prefixIcon: Icon(
                            Icons.search
                        ),
                      ),

                      Text ("Product Specifics"),
                      AppTextField(
                        hintText: 'Brand, Size, Color, Material,Mobile',
                        suffixIcon: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded, ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductDescView(),
                              ),
                            );

                          },)
                      ),

                      Text ("Product Description"),

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

                      AppButton(
                        text: "Save Productq",
                        backgroundColor: AppColors.primaryColor,
                        // onPressed: () => ref
                        //     .read(navigationServiceProvider)
                        //     .navigateToNamed(Routes.homeView),
                        onPressed: () {


                        },
                      ),

                    ]))));}}