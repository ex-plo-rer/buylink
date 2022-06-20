import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../models/product_model.dart';
import '../../notifiers/store_notifier/delete_store_validation_notifier.dart';
import '../../notifiers/store_notifier/store_notifier.dart';
import '../../notifiers/store_notifier/store_settings_notifier.dart';

class DeleteStoreVal extends ConsumerWidget {
  final Store store;
  DeleteStoreVal({
    Key? key,
    required this.store,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _passwordFN = FocusNode();

  final _passwordController = TextEditingController();

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
          'Delete store',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWithRich(
                  firstText: 'Delete',
                  secondText: 'store',
                  fontSize: 24,
                  secondColor: AppColors.primaryColor,
                ),
                const Spacing.smallHeight(),
                const Text(
                  "Enter your password, we just want to make sure its you",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.start,
                ),
                AppTextField(
                  style: TextStyle(color: AppColors.grey1, fontSize: 20, fontWeight: FontWeight.w500),
                  title: '',
                  hintText: 'Example123',
                  obscureText: !storeSettingsNotifier.passwordVisible,
                  controller: _passwordController,
                  focusNode: _passwordFN,
                  onChanged: storeSettingsNotifier.onPasswordChanged,
                  suffixIcon: _passwordController.text.isEmpty
                      ? null
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  storeSettingsNotifier.togglePassword(),
                              child: Icon(
                                storeSettingsNotifier.passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.dark,
                              ),
                            ),
                            const Spacing.smallWidth(),
                            GestureDetector(
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
                          ],
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
                  isLoading: storeSettingsNotifier.state.isLoading,
                  text: 'I want to delete my store',
                  textColor: _passwordController.text.isEmpty
                      ? AppColors.light
                      : AppColors.red,
                  backgroundColor: _passwordController.text.isEmpty
                      ? AppColors.grey6
                      : const Color(0xffF8EEEE),
                  onPressed: _passwordController.text.isEmpty
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => AppDialog(
                                title:
                                    'Are you sure you want to delete your store?',
                                text1: 'No',
                                text2: 'Yes',
                                onText1Pressed: () => ref
                                    .read(navigationServiceProvider)
                                    .navigateBack(),
                                onText2Pressed: () async {
                                  Loader(context)
                                      .showLoader(text: 'Please Wait');
                                  await storeSettingsNotifier.deleteStore(
                                    storeId: store.id,
                                    password: _passwordController.text,
                                  );
                                  if (storeSettingsNotifier.deleted) {
                                    await ref
                                        .refresh(storeNotifierProvider)
                                        .fetchMyStores();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    Alertify(
                                            title: 'Store deleted successfully')
                                        .success();
                                  } else {
                                    Alertify(title: 'Error deleting store')
                                        .error();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateBack();
                                  }
                                },
                              ),
                            );
                          }
                        },
                ),
                const Spacing.mediumHeight(),
                if (_passwordController.text.isNotEmpty)
                  const Text(
                    'You will permanently lose your reviews, messages, store data and profile info. After this there is no going back',
                    style: TextStyle(
                      color: AppColors.grey5,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
