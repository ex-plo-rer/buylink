import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/edit_store_description_notifier.dart';

class EditStoreDesc extends ConsumerWidget {
  EditStoreDesc ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final editStoreNotifier = ref.watch(editStoreDescNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading:  IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.dark,
            ),
            onPressed: () {
            },
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text("Store Description",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding (
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

            child: Column(

              children: [
                const TextWithRich(
                  firstText: 'Describe your Store',
                  secondText: '',
                  fontSize: 24,
                  firstColor: AppColors.grey1,
                ),

                Spacing.mediumHeight(),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: AppColors.grey7)
                      ),
                    height: 200,
                    //color: AppColors.light,
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
                                    hintText: 'We sell all fashion wears, shoes, bags, slides all at affordable rates ',
                                  ),
                                ),
                              ),)))),
                const Spacing.height(12),
                const Spacing.largeHeight(),
                const Spacing.largeHeight(),
                const Spacing.largeHeight(),

                AppButton(
                  text: "Save",
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () => ref

                ),

              ],
            ),)



        ));}}