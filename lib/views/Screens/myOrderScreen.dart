import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/classes.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {

  CompanyOrderViewModel model = CompanyOrderViewModel();

  List<OrderWithQuanity> orders = [];

  List price =[];

  var name;
  var Price;

  @override
  void initState() {
    model.fetchCompanyOrders();
    orders.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    calPrice( price, qauntity) {
      Price = price * qauntity;
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.myOrderHeading)),
      body: ChangeNotifierProvider<CompanyOrderViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<CompanyOrderViewModel>(
          builder: (context, value, _) {
            switch (value.myOrderList.status!) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (kDebugMode) {
                  print(value.myOrderList.message.toString());
                }
                return ErrorDialogue(
                  message: value.myOrderList.message.toString(),
                );
              case Status.completed:
                return value.myOrderList.data!.data!.isNotEmpty
                    ? ListView.builder(
                  itemCount: value.myOrderList.data!.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index){
                    orders.clear();
                    price.clear();
                    for(var element in value.myOrderList.data!.data![index].orderlist!){
                     if(element.product != null){
                       orders.add(OrderWithQuanity(quanity: element.quantity!,
                           name: element.product!.name!,packing: element.packingType));
                       calPrice(element.price, element.quantity);
                       price.add(Price);
                     }
                    }

                    for(var element in price){
                      Price += element;
                    }

                    String pro = orders.join('\n\n');
                    String packing = orders.map((e) => e.packing).join('\n\n');

                    return Container(
                      margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                      padding: EdgeInsets.only(left: 2.h,bottom: 2.h,top: 1.h,right: 2.h),
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
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row (
                              children: [
                                Text('OrderId #:  ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                TextWithStyle.customerDetails(context, value.myOrderList.data!.data?[index].id),
                              ]),
                            const Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWithStyle.customerProductDetails(context, pro),
                                TextWithStyle.customerDetails(context, packing),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                           const Divider(
                             thickness: 1,
                           ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWithStyle.customerTimeDetails(context, value.myOrderList.data?.data?[index].createdOn ?? 'Na'),
                                TextWithStyle.productPrice(context, '$Price'),
                              ],
                            )
                          ],
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


