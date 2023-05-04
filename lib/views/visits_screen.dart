import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../data/model/requested_data_model/customer_repId.dart';
import '../data/response/status.dart';
import '../resources/app_colors.dart';
import '../resources/constant_imageString.dart';
import '../resources/constant_strings.dart';
import '../utils/Dialogue/error_dialogue.dart';
import '../utils/text_style.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({Key? key, this.repId}) : super(key: key);

  final String? repId;

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {

  VisitViewModel model = VisitViewModel();

  List<String> texts = [];

  @override
  void initState() {
    if(widget.repId == null){
      model.getVisits(null);
    }else{
      CustomerRepId rep = CustomerRepId();
      rep.id = widget.repId;
      model.getVisits(rep);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    rowWidget(String message, icon){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,size: 2.h,color: AppColors.primaryColor,),
          SizedBox(width: 2.w,),
          Expanded(
              child: TextWithStyle.customerDetails(context, message)
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.visitHeading)),
      body: ChangeNotifierProvider<VisitViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<VisitViewModel>(
          builder: (context, value, _) {
            switch (value.visitList.status!) {
              case Status.loading:
                return Container(
                  color: AppColors.backgroundColor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case Status.error:
                if (kDebugMode) {
                  print(value.visitList.message.toString());
                }
                return ErrorDialogue(
                  message: value.visitList.message.toString(),
                );
              case Status.completed:
                return value.visitList.data!.data!.isNotEmpty
                    ? ListView.builder(
                  itemCount: value.visitList.data!.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    texts.clear();
                    for(var element in value.visitList.data!.data![index].products!){
                      if(element.name != null){
                        texts.add(element.name!);
                      }
                    }
                    var pro = texts.join(',  ');

                    return Container(
                      margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                      padding: EdgeInsets.only(left: 2.h,bottom: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(1.h)),
                        boxShadow: [
                          BoxShadow(
                            color:
                            AppColors.primaryColor.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 1.h),
                                  child: TextWithStyle.customerName(context, value.visitList.data!.data?[index].customerName),),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 1.h,right: 1.h,bottom: 0.8.h,top: 0.5.h),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(1.h),bottomLeft: Radius.circular(0.5.h))
                                ),
                                child: TextWithStyle.customerStatus(context, value.visitList.data!.data?[index].customerProfession,Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon( CupertinoIcons.briefcase_fill,
                                      size: 2.h,
                                      color: AppColors.primaryColor,),
                                    SizedBox(width: 2.w,),
                                    Expanded(
                                        child: Text(
                                          pro,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w400
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon( CupertinoIcons.chat_bubble_2_fill,
                                      size: 2.3.h,
                                      color: AppColors.primaryColor,),
                                    SizedBox(width: 1.3.w,),
                                    Expanded(
                                        child: Text(
                                          '${value.visitList.data!.data?[index].remark}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w400
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                rowWidget(
                                    '${value.visitList.data!.data?[index].customerPhone}',
                                    CupertinoIcons.phone_fill
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                rowWidget(
                                    '${value.visitList.data!.data?[index].customerEmail}',
                                    CupertinoIcons.mail_solid
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                rowWidget(
                                    '${value.visitList.data!.data?[index].place}',
                                    CupertinoIcons.location_solid
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                TextWithStyle.customerTimeDetails(context, "${value.visitList.data!.data?[index].time}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ConstantImage.empty,
                        width: 70.w,
                        //height: 30.h,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 2.h),
                      TextWithStyle.appBarTitle(
                          context, ConstantStrings.emptyScreen)
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
