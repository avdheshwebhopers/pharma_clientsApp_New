import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class SvgIconsWithFun extends StatelessWidget {
  SvgIconsWithFun({
    Key? key,
    this.image,
    this.onPress,
    @required this.title
  }) : super(key: key);

  dynamic onPress;
  dynamic image;
  dynamic title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(image,
              width: 4.h,
              height: 6.h,
            colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
          SizedBox(height: 0.5.h,),
          title != null ? TextWithStyle.svgIconTitle(context, title, Colors.black) : Container()
        ],
      ),
    );
  }
}
