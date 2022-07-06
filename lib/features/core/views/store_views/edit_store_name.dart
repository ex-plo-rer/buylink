import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utilities/loader.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/store_settings_notifier.dart';

class EditStoreName extends ConsumerWidget {
  EditStoreName({Key? key, required this.store}) : super(key: key);
  final Store store;
  final _formKey = GlobalKey<FormState>();

  final _nameFN = FocusNode();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final storeSettingsNotifier = ref.watch(storeSettingNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.dark,
          ),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Change Name",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const TextWithRich(
                  firstText: 'What\'s the name your',
                  secondText: 'store?',
                  fontSize: 24,
                  secondColor: AppColors.primaryColor,
                ),
                const Spacing.smallHeight(),
                AppTextField(
                  style: TextStyle(
                      color: AppColors.grey1,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  title: '',
                  hintText: 'Atinuke Stores',
                  focusNode: _nameFN,
                  controller: _nameController,
                  onChanged: storeSettingsNotifier.onNameChanged,
                  suffixIcon: GestureDetector(
                    onTap: () {},
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
                  // isLoading: storeSettingsNotifier.state.isLoading,
                  text: "Save",
                  backgroundColor: _nameController.text.isEmpty
                      ? AppColors.grey6
                      : AppColors.primaryColor,
                  onPressed: _nameController.text.isEmpty
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            Loader(context).showLoader(text: '');
                            await storeSettingsNotifier.editStore(
                              storeId: store.id,
                              attribute: 'name',
                              newValue: _nameController.text,
                            );
                          }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
