import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../resources/app_colors.dart';

class DropDownField extends StatelessWidget {
  DropDownField({

    this.val,
    required this.items,
    this.onChanged,
    this.validator,
    this.name,
    this.hintText,
    Key? key}) : super(key: key);

  dynamic val;
  List items;
  dynamic onChanged;
  dynamic validator;
  dynamic name;
  dynamic hintText;
  dynamic labelText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: val,
      elevation: 8,
      borderRadius: BorderRadius.all(Radius.circular(2.h)),
      menuMaxHeight: 40.h,
      style: TextStyle(fontSize: 18.sp,color: Colors.black,),
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
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: EdgeInsets.all(2.w),
          child: Icon(Icons.add_home_work ,size: 3.h,),
        ),
        contentPadding: const EdgeInsets.fromLTRB(0,20,20,20),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 18.sp,color: Colors.black,),
      ),
      items: items.map<DropdownMenuItem>((val) {
        return DropdownMenuItem(
          value: val,
          child: SizedBox(
              width: MediaQuery.of(context).size.width/1.8,
              child: Text(name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,)),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator
    );
  }
}
