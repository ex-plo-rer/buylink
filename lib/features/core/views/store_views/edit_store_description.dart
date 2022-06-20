import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/edit_store_name_notifier.dart';
import '../../notifiers/store_notifier/store_settings_notifier.dart';

class EditStoreDesc extends ConsumerWidget {
  EditStoreDesc({Key? key}) : super(key: key);
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
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w500),
                  title: '',
                  hintText:
                      'We sell all fashion wears, shoes, bags, slides all at affordable rates',
                  focusNode: _descriptionFN,
                  controller: _descriptionController,
                  maxLines: 5,
                  onChanged: storeSettingsNotifier.onNameChanged,
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
                  isLoading: storeSettingsNotifier.state.isLoading,
                  text: "Save",
                  backgroundColor: _descriptionController.text.isEmpty
                      ? AppColors.grey6
                      : AppColors.primaryColor,
                  onPressed: _descriptionController.text.isEmpty
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            await storeSettingsNotifier.editStore(
                              storeId: 23,
                              attribute: 'desc',
                              newValue: _descriptionController.text,
                            );
                            await ref
                                .refresh(storeNotifierProvider)
                                .fetchMyStores();
                            ref.read(navigationServiceProvider).navigateBack();
                            Alertify(
                                    title:
                                        'Store description changed successfully')
                                .success();
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
