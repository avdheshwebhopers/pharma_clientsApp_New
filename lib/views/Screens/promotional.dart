import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/response/status.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/constant_imageString.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';

class PromotionalScreen extends StatefulWidget {
  const PromotionalScreen({Key? key}) : super(key: key);

  @override
  State<PromotionalScreen> createState() => _PromotionalScreen();
}

class _PromotionalScreen extends State<PromotionalScreen> {

  AboutPromotionalViewModel model = AboutPromotionalViewModel();

  @override
  void initState() {
    // TODO: implement initState
    model.fetchPromotional();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: TextWithStyle.appBarTitle(context, ConstantStrings.promotionalHeading),
        ),
        body: ChangeNotifierProvider<AboutPromotionalViewModel>(
          create: (BuildContext context) => model,
          child: Consumer<AboutPromotionalViewModel>(
            builder: (context,value, _){
              switch(value.promotional.status!){
                case Status.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.error:
                  return ErrorDialogue(message: value.promotional.message);
                case Status.completed:
                  return value.promotional.data!.data!.isNotEmpty && value.promotional.data?.data != null
                      ? ListView.builder(
                      itemCount: value.promotional.data!.data?.length,
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
                              FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/png/loading.gif',
                                  width: 100.w,
                                  image: value.promotional.data!.data![index].image!),

                              SizedBox(height: 2.h,),
                              Container(
                                margin: EdgeInsets.only(left: 4.w,right: 4.w),
                                child: Text(value.promotional.data!.data![index].title!,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600
                                  ),),
                              ),
                              SizedBox(height: 2.h,),
                              Container(
                                margin: EdgeInsets.only(left: 4.w,right: 4.w),
                                child: Text(value.promotional.data!.data![index].description!,
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
                  );
              }
            },
          ),
        ),
    );
  }
}
