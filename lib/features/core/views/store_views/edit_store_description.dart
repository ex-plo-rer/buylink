import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/store_quick_model.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/loader.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../models/product_model.dart';
import '../../notifiers/store_notifier/edit_store_name_notifier.dart';
import '../../notifiers/store_notifier/store_settings_notifier.dart';

class EditStoreDesc extends ConsumerWidget {
  EditStoreDesc({Key? key, required this.store}) : super(key: key);
  final Store store;

  final _formKey = GlobalKey<FormState>();

  final _descriptionFN = FocusNode();

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final storeSettingsNotifier = ref.watch(storeSettingNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined,
              color: AppColors.dark, size: 14),
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
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
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  title: '',
                  hintText:
                      'We sell all fashion wears, shoes, bags, slides all at affordable rates',
                  focusNode: _descriptionFN,
                  controller: _descriptionController,
                  maxLines: 5,
                  onChanged: storeSettingsNotifier.onNameChanged,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _descriptionController.clear();
                    },
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
                  hasBorder: true,
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
                  backgroundColor: _descriptionController.text.isEmpty
                      ? AppColors.grey6
                      : AppColors.primaryColor,
                  onPressed: _descriptionController.text.isEmpty
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            Loader(context).showLoader(text: '');
                            await storeSettingsNotifier.editStore(
                              storeId: store.id,
                              attribute: 'desc',
                              newValue: _descriptionController.text,
                            );
                          }
                          ref.read(navigationServiceProvider).navigateToNamed(
                                Routes.storeSettings,
                                arguments: store,
                              );
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
