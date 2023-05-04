import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/chnagePassword_entity.dart';
import 'package:pharma_clients_app/utils/TextInputFields/password_inputField.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/button.dart';
import '../../utils/text_style.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obsecureOldPassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureNewPassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureConfirmPassword = ValueNotifier<bool>(true);

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ChangePasswordViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.changePasswordheading),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _obsecureOldPassword,
                    builder: (context , value, child){
                      return PasswordInputField(
                      title: oldPassword,
                      node: oldPasswordFocusNode,
                      obSecure: _obsecureOldPassword.value,
                      hintText: 'Enter Your Old Password',
                      labelText: 'Old Password',
                      icon: CupertinoIcons.lock_fill,
                      suffixIcon: InkWell(
                          onTap: (){
                            _obsecureOldPassword.value = !_obsecureOldPassword.value ;
                          },
                          child: Icon(
                              _obsecureOldPassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Old Password';
                        }else if(value!.length != 6){
                          return 'Please enter 6 Digits Old Password';
                        }
                        return null;
                      },
                    );}
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obsecureNewPassword,
                      builder: (context , value, child){
                        return PasswordInputField(
                          title: newPassword,
                          node: newPasswordFocusNode,
                          obSecure: _obsecureNewPassword.value,
                          hintText: 'Enter Your New Password',
                          labelText: 'New Password',
                          icon: CupertinoIcons.lock_rotation,
                          suffixIcon: InkWell(
                              onTap: (){
                                _obsecureNewPassword.value = !_obsecureNewPassword.value;
                              },
                              child: Icon(
                                  _obsecureNewPassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your New Password';
                            }else if(value!.length != 6){
                              return 'Please enter 6 Digits New Password';
                            }
                            return null;
                          },
                        );}
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obsecureConfirmPassword,
                      builder: (context , value, child){
                        return PasswordInputField(
                          title: confirmPassword,
                          node: confirmPasswordFocusNode,
                          obSecure: _obsecureConfirmPassword.value,
                          hintText: 'Enter Your Confirm Password',
                          labelText: 'Confirm Password',
                          icon: CupertinoIcons.lock_shield,
                          suffixIcon: InkWell(
                              onTap: (){
                                _obsecureConfirmPassword.value = !_obsecureConfirmPassword.value;
                              },
                              child: Icon(
                                  _obsecureConfirmPassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Old Password';
                            }else if(newPassword.text != confirmPassword.text){
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        );}
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Consumer<ChangePasswordViewModel>(
              builder: (BuildContext context, value, Widget? child) {
                return Button(
                  title: 'Change Password',
                  onPress: (){
                    final isValid = _formKey.currentState?.validate();
                    if (!isValid!) {
                      return;
                    }
                    ChangePasswordEntity entity = ChangePasswordEntity();
                    entity.oldPassword = oldPassword.text;
                    entity.newPassword = confirmPassword.text;
                    provider.changePassword(
                        entity,
                        context,
                        oldPassword,
                        newPassword,
                        confirmPassword
                    );
                  }, loading: value.loading,
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}
