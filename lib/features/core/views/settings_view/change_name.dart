import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/loader.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/settings_notifier/change_name_notifier.dart';
import '../../notifiers/user_provider.dart';

class EditUserName extends ConsumerStatefulWidget {
  const EditUserName({Key? key}) : super(key: key);

  @override
  ConsumerState<EditUserName> createState() => _EditUserNameState();
}

class _EditUserNameState extends ConsumerState<EditUserName> {
  final _formKey = GlobalKey<FormState>();

  final _nameFN = FocusNode();

  final _nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = ref.read(userProvider).currentUser!.name;
  }

  @override
  Widget build(BuildContext context) {
    final userProv = ref.watch(userProvider);
    final editUserNameNotifier = ref.watch(editUserNameNotifierProvider);
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
                  firstText: 'What\'s your',
                  secondText: 'name?',
                  fontSize: 24,
                  secondColor: AppColors.primaryColor,
                ),
                const Spacing.smallHeight(),
                AppTextField(
                  style: const TextStyle(
                      color: AppColors.grey1,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  title: '',
                  hintText: userProv.currentUser?.name,
                  focusNode: _nameFN,
                  controller: _nameController,
                  onChanged: editUserNameNotifier.onNameChanged,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _nameController.clear();
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
                  // isLoading: editUserNameNotifier.state.isLoading,
                  text: "Save",
                  backgroundColor: _nameController.text.isEmpty
                      ? AppColors.grey6
                      : AppColors.primaryColor,
                  onPressed: _nameController.text.isEmpty
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            if (_nameController.text !=
                                userProv.currentUser!.name) {
                              Loader(context).showLoader(text: '');
                              await editUserNameNotifier.changeName(
                                  newName: _nameController.text);
                              Alertify(title: 'Name changed successfully')
                                  .success();
                            }
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
