import 'package:flutter/material.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class PngIconsWithFun extends StatelessWidget {
  PngIconsWithFun({Key? key,
    this.image,
    this.onPress,
    this.title
  }) : super(key: key);

  dynamic onPress;
  dynamic image;
  dynamic title;

  String count = '1';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 10.w,
          ),
          SizedBox(
            height: 0.h,
          ),
          title != null ? TextWithStyle.pngIconTitle(context, title) : Container()
        ],
      ),
    );
  }
}
