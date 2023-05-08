import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/customer_repId.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/classes.dart';
import '../../utils/text_style.dart';

class CustomersOrderScreen extends StatefulWidget {
  const CustomersOrderScreen({
    Key? key, this.repId}) : super(key: key);

  final String? repId;

  @override
  State<CustomersOrderScreen> createState() => _CustomersOrderScreenState();
}

class _CustomersOrderScreenState extends State<CustomersOrderScreen> {

  CustomerOrderViewModel model  = CustomerOrderViewModel();
  List<OrderWithQuanity> orders = [];
  List price = [];

  var Price;

  @override
  void initState() {
    if(widget.repId == null){
      model.fetchCustomersOrders(null);
    }else{
      CustomerRepId rep = CustomerRepId();
      rep.id = widget.repId;
      model.fetchCustomersOrders(rep);
    }

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
              context, ConstantStrings.customerOrderHeading)),
      body: ChangeNotifierProvider<CustomerOrderViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<CustomerOrderViewModel>(
          builder: (context, value, _) {
            switch (value.customersOrderList.status!) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (kDebugMode) {
                  print(value.customersOrderList.message.toString());
                }
                return ErrorDialogue(
                  message: value.customersOrderList.message.toString(),
                );
              case Status.completed:
                return (value.customersOrderList.data!.data!.isNotEmpty && value.customersOrderList.data!.data != null)
                    ? ListView.builder(
                  itemCount: value.customersOrderList.data!.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    orders.clear();
                    for(var element in value.customersOrderList.data!.data![index].orderlist!){
                      if(element.product != null){
                        orders.add(OrderWithQuanity(quanity: element.quantity!,
                          name: element.product!.name!,packing: element.packingType));
                          calPrice(element.product!.price, element.quantity);
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
                                  TextWithStyle.customerDetails(context, value.customersOrderList.data!.data?[index].id),
                                ]),
                            const Divider(
                              thickness: 1,
                            ),
                            Row (
                                children: [
                                  Text('Order from:  ',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextWithStyle.customerDetails(context, value.customersOrderList.data!.data?[index].repName),
                                ]),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row (
                                children: [
                                  Text('Customer:  ',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextWithStyle.customerDetails(context, value.customersOrderList.data!.data?[index].customerName),
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
                                Expanded(child: TextWithStyle.customerProductDetails(context, pro)),
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
                                TextWithStyle.customerTimeDetails(context, value.customersOrderList.data?.data?[index].createdOn ?? 'Na'),
                                TextWithStyle.customerProductDetails(context, 'Rs.$Price'),
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
