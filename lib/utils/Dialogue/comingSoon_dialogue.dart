import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ComingSoonAlertDialogue extends StatelessWidget {
  const ComingSoonAlertDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: const Padding(
          padding:EdgeInsets.all(20),
          child: Icon(Icons.add_alert_sharp,textDirection: TextDirection.ltr,color: Colors.red,size: 50,),
        ),
        content: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Text("Coming Soon",textAlign: TextAlign.center,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
        ));
  }
}
