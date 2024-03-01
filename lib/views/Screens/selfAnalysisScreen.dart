import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/views/Screens/visitWiseRecord.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:badges/badges.dart' as badge;
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';

class SelfAnalysisScreen extends StatefulWidget {
  const SelfAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<SelfAnalysisScreen> createState() => _SelfAnalysisScreenState();
}

class _SelfAnalysisScreenState extends State<SelfAnalysisScreen> {

  SelfAnalysisViewModel model = SelfAnalysisViewModel();

  @override
  void initState() {
    model.selfAnalysis(context);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.selfAnalysis),
          elevation: 0,
        ),
        body: ChangeNotifierProvider<SelfAnalysisViewModel>(
            create: (BuildContext context) => model,
            child: Consumer<SelfAnalysisViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                    switch (value.analysisList.status!) {
                    case Status.loading:
                    return const Center(
                    child: CircularProgressIndicator(),
                    );
                    case Status.error:
                    if (kDebugMode) {
                    print(value.analysisList.message.toString());
                    }
                    return ErrorDialogue(
                    message: value.analysisList.message.toString(),
                    );
                    case Status.completed:
                  final data = value.analysisList.data!.data!;
                  return data.mrView!.isNotEmpty && data.mrView != null
                      ? ListView.builder(
                      itemCount: data.mrView!.length,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
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
                              Padding(
                                padding: EdgeInsets.only(left: 2.h,bottom: 2.h,top: 1.h,right: 2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.mrView?[index].mrInfo?.name ?? 'NA',
                                    style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w600),
                                  ),
                                  TextWithStyle.productDescription(context, data.mrView?[index].mrInfo?.opArea ?? 'NA'),
                                  SizedBox(height: 1.h),
                                  TextWithStyle.productDescription(context, data.mrView?[index].mrInfo?.phone ?? 'NA'),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWithStyle.containerTitle(context, 'Visits'),
                                      badge.Badge(
                                        badgeAnimation: const badge.BadgeAnimation.slide(),
                                        badgeStyle: badge.BadgeStyle(
                                          badgeColor: AppColors.primaryColor,
                                          shape: badge.BadgeShape.circle

                                          //padding: EdgeInsets.all(0)
                                        ),
                                        badgeContent: Container(
                                          padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                          child: Text(
                                              data.mrView?[index].mrToCustomerVisitCount.toString() ??
                                                  '1',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 1.h),
                                      )
                                      ),
                                    ],
                                  ),
                                ],
                              ),),
                              InkWell(
                                onTap: (){
                                  if(data.mrView!.length != 0 && data.mrView !=null){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        VisitWiseRecordScreen(data: data.mrView![index].customers!)));
                                  }else{
                                    Utils.flushBarErrorMessage("No Data Found", context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 5.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(1.h),
                                      bottomRight: Radius.circular(1.h)
                                    ),
                                  ),
                                  child: Text('Visit Wise Details',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                    wordSpacing: 0,
                                    fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),),
                                ),
                              )
                            ],
                          ),
                        );
                      })
                      : Center(
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
                  );
                }}))
    );
  }
}
