import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../resources/app_colors.dart';

class ProfileContainer extends StatelessWidget {
   ProfileContainer({
    this.onPress,
     this.image,
     this.title,
    Key? key}) : super(key: key);

   dynamic onPress;
   dynamic image;
   dynamic title;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(left: 2.h,right: 2.h,bottom: 1.h),
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 0),
            )],
        ),
        height: MediaQuery.of(context).size.height/11,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 1.5.h,),
                SvgPicture.asset(image,
                  width: 3.h,
                  height: 3.h,
                  colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                ),
                SizedBox(width: 2.h,),
                TextWithStyle.mrProfileHeading(context, title)
              ],
            ),
            const Icon(Icons.chevron_right)
          ],),
      ),
    );
  }
}
