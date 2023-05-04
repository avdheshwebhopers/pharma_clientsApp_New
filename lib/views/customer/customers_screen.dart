import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/customers/customers_responseModel.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';
import 'customers_profileScreen.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  CustomersViewModel model = CustomersViewModel();

  List<Customers> customer = [];

  @override
  void initState() {
    model.fetchCustomers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    rowWidget(String message, icon){
      return Row(
        children: [
          Icon(icon,size: 2.h,color: AppColors.primaryColor,),
          SizedBox(width: 2.w,),
          TextWithStyle.customerDetails(context, message)
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.customerHeading)),
      body: ChangeNotifierProvider<CustomersViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<CustomersViewModel>(
          builder: (context, value, _) {
            switch (value.customersList.status!) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (kDebugMode) {
                  print(value.customersList.message.toString());
                }
                return ErrorDialogue(
                  message: value.customersList.message.toString(),
                );
              case Status.completed:
                return value.customersList.data!.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: value.customersList.data!.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 1.h, right: 1.h, top: 1.h),
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
                            child: InkWell(
                              onTap: () {
                                customer.add(value.customersList.data!.data![index]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                           CustomersProfileScreen(
                                             profile: customer,
                                            )));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 3.h,bottom: 2.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Container(
                                            margin: EdgeInsets.only(top: 1.h),
                                              child: TextWithStyle.customerName(context, value.customersList.data!.data?[index].name),),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 1.h,right: 1.h,bottom: 0.8.h,top: 0.5.h),
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(1.h),bottomLeft: Radius.circular(0.5.h))
                                          ),
                                          child: TextWithStyle.customerStatus(context, value.customersList.data!.data?[index].profession,Colors.white),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    rowWidget(
                                        '${value.customersList.data!.data?[index].email}',
                                      CupertinoIcons.mail_solid
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),

                                    rowWidget(
                                        '${value.customersList.data!.data?[index].phone}',
                                        CupertinoIcons.phone_fill
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    rowWidget(
                                        '${value.customersList.data!.data?[index].address}',
                                        CupertinoIcons.location_solid
                                    ),
                                     Divider(thickness: 1,endIndent: 2.h,),
                                    TextWithStyle.customerTimeDetails(context, "${value.customersList.data!.data?[index].createdOn}")
                                  ],
                                ),
                              ),
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
