import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Utils{

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding:  EdgeInsets.all(2.h),
        messageText: Text(message,style: TextStyle(fontSize: 16.sp,color: Colors.white),),
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10.h),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: const Color(0xFFC21B17),
        reverseAnimationCurve: Curves.bounceInOut,
        positionOffset: 5.h,
        icon: Icon(Icons.error , size: 3.h , color: Colors.white),
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(20),
        //message: message,
        messageText: Text(message,style: TextStyle(fontSize: 16.sp,color: Colors.white),),
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10.h),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: const Color(0xFF03A10E),
        reverseAnimationCurve: Curves.bounceInOut,
        positionOffset: 20,
        icon: Icon(CupertinoIcons.check_mark_circled_solid , size: 3.h , color: Colors.white,),
      )..show(context),
    );
  }

  static void errorAlertDialogue(String? message, BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: const Padding(
          padding:EdgeInsets.all(20),
          child: Icon(Icons.error,textDirection: TextDirection.ltr,color: Colors.red,size: 50,),
        ),
        content: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: Text(message!,textAlign: TextAlign.center,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
      ));
    });
  }

  static void successAlertDialogue(String? message, onPress, BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
          title: const Padding(
            padding:EdgeInsets.all(20),
            child: Icon(CupertinoIcons.check_mark_circled_solid,
              textDirection: TextDirection.ltr,
              color: Color(0xFF03A10E),
              size: 50,),
          ),
          content: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: Text(message!,textAlign: TextAlign.center,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
        actions: [
          CupertinoDialogAction(child: const Text('OK'),
              onPressed: onPress),
        ],
      );
    });
  }

  static void confirmationDialogue(String? message , String? title ,onPress, BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
          title: TextWithStyle.containerTitle(context, title!),
          content: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: Text(message!,textAlign: TextAlign.center,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),),
          ),
        actions: <Widget> [
          CupertinoDialogAction(child: const Text("Cancel"),
            onPressed: (){
              Navigator.of(context).pop();
            },),
          CupertinoDialogAction(child: const Text('OK'),
          onPressed: onPress),
        ],
      );
    });
  }

  static void comingSoonDialogue(onPress, BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return CupertinoAlertDialog(
          title: Image.asset("assets/images/png/comingSoon.png",width: 10.h,height: 10.h,),
          actions: [
            CupertinoDialogAction(child: const Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();
              },),
          ]
      );
    });
  }

}
