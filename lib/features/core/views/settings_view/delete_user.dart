import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_circular_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_dialog.dart';
import '../../../../widgets/app_linear_progress.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/settings_notifier/delete_user_notifier.dart';
import '../../notifiers/user_provider.dart';

class DeleteUser extends ConsumerWidget {
  DeleteUser ({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final _detailController = TextEditingController();
  final _detailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final deleteUserNotifier = ref.watch(deleteUserNotifierProvider);
    final userProv = ref.watch(userProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: deleteUserNotifier.currentPage == 1
              ? null
              : IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.dark,
            ),
            onPressed: () {
              deleteUserNotifier.moveBackward();
              print(deleteUserNotifier.currentPage);
              _pageController.animateToPage(
                // array starts at 0 (lol)
                deleteUserNotifier.currentPage - 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: Text(
            AppStrings.deleteaccount,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  AbsorbPointer(
                      absorbing: deleteUserNotifier.state.isLoading,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLinearProgress(
                                  current: deleteUserNotifier.currentPage,
                                  total: deleteUserNotifier.totalPage,
                                  value:
                                  deleteUserNotifier.currentPage / deleteUserNotifier.totalPage,
                                ),
                                const Spacing.height(12),
                                SizedBox(
                                  height: 500,
                                  child: PageView(
                                      controller: _pageController,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        Column(
                                            children: <Widget>[
                                              Text ("Hi ${userProv.currentUser?.name ?? 'User'}, can you please let us why you want to terminate your account", style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.grey1,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              AppCCheckBox(onChanged: (){
                                                deleteUserNotifier.onReasonClicked(deleteUserNotifier.reasons[0]);
                                              },
                                                checked: false, text: 'I’m getting too much notifications',),
                                              AppCCheckBox(onChanged: (){
                                                deleteUserNotifier.onReasonClicked(deleteUserNotifier.reasons[1]);
                                              },
                                                checked: false, text: 'I opened another account',),
                                              AppCCheckBox(onChanged: (){
                                                deleteUserNotifier.onReasonClicked(deleteUserNotifier.reasons[2]);
                                              },
                                                checked: false, text: 'The app is buggy',),
                                              AppCCheckBox(onChanged: (){ deleteUserNotifier.onReasonClicked(deleteUserNotifier.reasons[3]);},
                                                checked: false, text: 'I have a privacy concern',),
                                              AppCCheckBox(onChanged: (){ deleteUserNotifier.onReasonClicked(deleteUserNotifier.reasons[4]);},
                                                checked: false, text: 'Others',),

                                              Container(
                                                  height: 200,
                                                  color: AppColors.grey10,
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
                                                                style: TextStyle(color: AppColors.grey5, fontSize: 14, fontWeight: FontWeight.w500),
                                                                onChanged: deleteUserNotifier.onDetailChanged,
                                                                focusNode: _detailFN,
                                                                controller: _detailController,
                                                                maxLines: 100,
                                                                decoration: new InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: 'Kindly shed more light on the reason for termination(optional)',
                                                                ),
                                                              ),
                                                            ),)))),
                                            ]
                                        ),

                                        Column (
                                            children: <Widget>[
                                              Spacing.largeHeight(),
                                              // Spacing.smallHeight(),
                                              CircleAvatar(
                                                  child: Icon  (Icons.delete_outline_rounded, color: AppColors.red, size: 30,),
                                                  backgroundColor: AppColors.redshade1,
                                                  radius: 30
                                              ),

                                              Spacing.largeHeight(),

                                              Center (
                                                  child: Text (AppStrings.deleteUserNote2,
                                                    textAlign: TextAlign.center, style:
                                                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey2 ),)
                                              )
                                            ]
                                        ),

                                        Column(
                                          children: [
                                            TextWithRich(
                                              firstText: 'Delete',
                                              secondText: 'account',
                                              fontSize: 24,
                                              secondColor: AppColors.primaryColor,
                                            ),
                                            const Spacing.height(12),
                                            Text ("Enter your password, we just want to make sure its you", style:
                                            TextStyle(color: AppColors.grey2, fontSize: 12, fontWeight: FontWeight.w500)),
                                            AppTextField(
                                              title: '',
                                              hintText: 'Password123',
                                              keyboardType: TextInputType.emailAddress,
                                              focusNode: _passwordFN,
                                              controller: _passwordController,
                                              onChanged: deleteUserNotifier.onPasswordChanged,
                                              suffixIcon: _passwordController.text.isEmpty
                                                  ? null
                                                  : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () =>
                                                        deleteUserNotifier.togglePassword(),
                                                    child: Icon(
                                                      deleteUserNotifier.passwordVisible
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
                                          ],
                                        ),
                                      ] ),
                                ),
                                AppButton(
                                   // isLoading: deleteUserNotifier.state.isLoading,
                                    text: deleteUserNotifier.currentPage ==
                                        deleteUserNotifier.totalPage
                                        ? AppStrings.deleteUserNote4
                                        : "Continue >>",
                                    backgroundColor: deleteUserNotifier.currentPage == 3 &&
                                        _passwordController.text.isEmpty
                                        ? AppColors.grey6
                                        : AppColors.primaryColor,
                                    //backgroundColor: AppColors.primaryColor,
                                    // onPressed: () => ref
                                    //     .read(navigationServiceProvider)
                                    //     .navigateToNamed(Routes.homeView),
                                    onPressed:  () async {
                                        if (deleteUserNotifier.currentPage == 1 &&
                                          _detailController.text.isNotEmpty
                                      ){
                                        deleteUserNotifier.deleteAccount(
                                          details: _detailController.text,
                                          );

                                        //: deleteUserNotifier.currentPage == 2 ?
                                        deleteUserNotifier.moveForward();
                                        _pageController.animateToPage(
                                          // array starts at 0 (lol)
                                          deleteUserNotifier.currentPage - 1,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.easeIn,);
                                      }
                                      //else (deleteUserNotifier.currentPage == 2){
                                       else if (deleteUserNotifier.currentPage == 2) {
                                          deleteUserNotifier.moveForward();
                                        _pageController.animateToPage(
                                        // array starts at 0 (lol)
                                        deleteUserNotifier.currentPage - 1,
                                        duration: const Duration(
                                        milliseconds: 500),
                                        curve: Curves.easeIn,);
                                        }
                                        else if (deleteUserNotifier.currentPage ==
                                            3 && _passwordController.text
                                            .isNotEmpty) {
                                           deleteUserNotifier
                                              .checkPassword(
                                            password: _passwordController.text,
                                          );
                                          deleteUserNotifier.moveForward();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AppDialog(
                                                  title: 'Are you sure you want to delete your account?',
                                                  text1: 'No',
                                                  text2: 'Yes',
                                                  onText2Pressed: () =>



                                                      ref
                                                          .read(
                                                          navigationServiceProvider)
                                                          .navigateToNamed(
                                                          Routes.login),
                                                );
                                              });
                                        }
                                      }
                                      //   ref
                                      // .read(navigationServiceProvider)
                                      // .navigateToNamed(Routes.)
                                     ),])
                      ))])));}}