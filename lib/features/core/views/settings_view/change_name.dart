import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/settings_notifier/change_name_notifier.dart';

class EditUserName extends ConsumerWidget {
  EditUserName ({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _nameFN = FocusNode();

  @override
  Widget build(BuildContext context, ref) {
    final editUserNameNotifier = ref.watch(editUserNameNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading:  IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.dark,
            ),
            onPressed: () {},),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text("Change Name",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding (
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                    children: <Widget>[
                      const TextWithRich(
                        firstText: 'What\'s your',
                        secondText: 'name?',
                        fontSize: 24,
                        secondColor: AppColors.primaryColor,
                      ),
                      Spacing.smallHeight(),

                      AppTextField(
                        title: '',
                        hintText: 'Deji',
                        focusNode: _nameFN,
                        controller: _nameController,
                        onChanged: editUserNameNotifier.onNameChanged,
                        suffixIcon: GestureDetector(
                          onTap: () => _nameController.clear(),
                          child: const CircleAvatar(
                            backgroundColor: AppColors.grey7,
                            radius: 10,
                            child: Icon(
                              Icons.clear_rounded,
                              color: AppColors.light,
                              size: 15,
                            ),
                          ),
                        ),
                        hasBorder: false,
                      ),

                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),

                      AppButton(
                          text: "Save",
                          backgroundColor: AppColors.primaryColor,
                          onPressed: () async{
                          await editUserNameNotifier.changeName(
                           // id : 1,
                          name: _nameController.text,
                          );
                          }
                      ),

                    ]


                )

            )));}}
