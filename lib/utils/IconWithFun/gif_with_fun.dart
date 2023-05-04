import 'package:flutter/material.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class GifIconsWithFun extends StatelessWidget {
  GifIconsWithFun({
    Key? key,
    this.image,
    this.onPress,
    @required this.title
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
          Image.asset(image,
            height: 13.w,
            width: 13.w,
          ),
          SizedBox(height: 0.5.h,),
          TextWithStyle.pngIconTitle(context, title)
        ],
      ),
    );
  }
}
