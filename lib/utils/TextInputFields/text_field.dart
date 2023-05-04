import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/app_colors.dart';

class TextInputField extends StatelessWidget {
  TextInputField({

    this.title,
    this.node,
    this.hintText,
    this.labelText,
     this.icon,
    this.validator,

    Key? key}) : super(key: key);

  dynamic title;
  dynamic node;
  String? hintText;
  String? labelText;
  dynamic icon;
  dynamic validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      child: TextFormField(
        style: TextStyle(fontSize: 18.sp),
        controller: title,
        focusNode: node,
        maxLines: null,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: AppColors.primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: AppColors.primaryColor)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.red.shade700)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.red.shade700)),
          contentPadding: const EdgeInsets.fromLTRB(0,20,10,20),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.all(2.w),
            child: Icon(icon ,size: 3.h,),
          ),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
