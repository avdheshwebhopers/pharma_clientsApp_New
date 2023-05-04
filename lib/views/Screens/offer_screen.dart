import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {

  OffersViewModel model = OffersViewModel();
  List images = [];


  @override
  void initState() {
    model.fetchOffers();
    images.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    images.clear();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              title: TextWithStyle.appBarTitle(context, ConstantStrings.offersheading)
          ),
          body: ChangeNotifierProvider<OffersViewModel>(
            create: (BuildContext context) => model,
            child: Consumer<OffersViewModel>(
              builder: (context,value, _){
                switch(value.offersList.status!){
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.error:
                    if (kDebugMode) {
                      print(value.offersList.message.toString());
                    }
                    return ErrorDialogue(message: value.offersList.message);
                  case Status.completed:
                    images.clear();
                    for (var element in value.offersList.data!.data!) {
                      if(element.images != null && element.images!.isNotEmpty){
                        for(var ele in element.images!){
                          images.add(ele);
                        }
                      }
                    }
                    return value.offersList.data!.data!.isNotEmpty
                        ? ListView.builder(
                        itemCount: value.offersList.data!.data?.length,
                        itemBuilder: (context,index){
                          return Card(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.w),
                            elevation: 2,
                            shadowColor: Colors.black38,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(2.h))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(images[index],
                                  width: 100.w,),
                                SizedBox(height: 2.h,),
                                Container(
                                  margin: EdgeInsets.only(left: 4.w,right: 4.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value.offersList.data!.data![index].title!,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      Text(value.offersList.data!.data![index].validUpto!,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600
                                        ),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 2.h,),
                                Container(
                                  margin: EdgeInsets.only(left: 4.w,right: 4.w),
                                  child: Text(value.offersList.data!.data![index].description!,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400
                                    ),),
                                ),
                                SizedBox(height: 2.h,),
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
                }
              },
            ),
          )
        );
  }
}
