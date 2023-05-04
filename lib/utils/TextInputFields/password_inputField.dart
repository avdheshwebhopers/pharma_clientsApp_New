import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../resources/app_colors.dart';

class PasswordInputField extends StatelessWidget {
  PasswordInputField({

    this.title,
    this.node,
    this.hintText,
    this.labelText,
    this.icon,
    this.obSecure,
    this.suffixIcon,
    this.validator,

    Key? key}) : super(key: key);

  dynamic title;
  dynamic node;
  String? hintText;
  String? labelText;
  dynamic icon;
  dynamic obSecure;
  dynamic suffixIcon;
  dynamic validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 2.h),
        child: TextFormField(
          style: TextStyle(fontSize: 18.sp),
          controller: title,
          obscureText: obSecure,
          focusNode: node,
          validator: validator,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.primaryColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: AppColors.primaryColor)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.red.shade700)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.red.shade700)),
            hintText: hintText,
            labelText: labelText,
            prefixIcon: Padding(
              padding: EdgeInsets.all(2.w),
              child: Icon(icon ,size: 3.h,),
            ),
            suffixIcon: suffixIcon,
          ),
        )
    );
  }
}
