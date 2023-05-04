import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  FAQsViewModel model = FAQsViewModel();

  @override
  void initState() {
    model.fetchFAQs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            title: TextWithStyle.appBarTitle(context, ConstantStrings.faqsScreen)),
        body: ChangeNotifierProvider<FAQsViewModel>(
            create: (BuildContext context) => model,
            child: Consumer<FAQsViewModel>(builder: (context, value, _) {
              switch (value.faqs.status!) {
                case Status.loading:
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.backgroundColor,
                      child: Center(
                        child: Image.asset(
                          'assets/images/png/loading-gif.gif',
                          height: 6.h,
                        ),
                      ),
                    ),
                  );
                case Status.error:
                  return ErrorDialogue(
                    message: value.faqs.message.toString(),
                  );
                case Status.completed:
                  return value.faqs.data!.faqs != null && value.faqs.data!.faqs?.length !=0
                      ? ListView.builder(
                      itemCount: value.faqs.data!.faqs!.length,
                      itemBuilder: (context,index){
                        final item = value.faqs.data!.faqs![index];
                        return Container(
                          margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                          padding: EdgeInsets.only(bottom: 1.h,top: 1.h,),
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
                          child: ExpansionTile(
                            title: Text(item.question!,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),),
                            childrenPadding: EdgeInsets.only(left: 2.h,bottom: 1.h),
                            children: [
                              SizedBox(height: 1.h,),
                              Text(item.answer!,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                ),),
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
            })
        )
    );
  }
}
