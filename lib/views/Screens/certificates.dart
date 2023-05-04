import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/about_company/about_company_response_model.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../resources/constant_imageString.dart';
import '../../utils/text_style.dart';


// ignore: must_be_immutable
class CertificateScreen extends StatelessWidget {
  CertificateScreen({Key? key,

    required this.value

  }) : super(key: key);

  List<AboutCompany> value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: TextWithStyle.appBarTitle(context, ConstantStrings.certificateHeading),
        ),
        body: value[0].certificates!.isNotEmpty
            ? ListView.builder(
            itemCount: value[0].certificates?.length,
            itemBuilder: (context,index){
              return Card(
                margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.w),
                elevation: 2,
                shadowColor: Colors.black38,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.h))),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(value[0].certificates![index].image!,
                    width: 100.w,),
                    SizedBox(height: 2.h,),
                    Container(
                      margin: EdgeInsets.only(left: 4.w,right: 4.w),
                      child: Text(value[0].certificates![index].title!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600
                      ),),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      margin: EdgeInsets.only(left: 4.w,right: 4.w),
                      child: Text(value[0].certificates![index].description!,
                        style: TextStyle(
                            fontSize: 16.sp,
                            //fontWeight: FontWeight.w600
                        ),),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              );
            })
            : Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ConstantImage.empty,
                  width: 70.w,
                  //height: 30.h,
                  fit: BoxFit.fill,),
                SizedBox(height: 2.h),
                TextWithStyle.appBarTitle(context, ConstantStrings.emptyScreen)
              ],
            ),
          ),
        )
    );
  }
}
