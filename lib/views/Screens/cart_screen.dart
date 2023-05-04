import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/placeOrders/placeDistributorsOrder.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/requested_data_model/placeOrders/placeCustomerOrder.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/button.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key, required this.owner, required this.isOwner})
      : super(key: key);

  String? owner;
  bool? isOwner;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CustomersViewModel model = CustomersViewModel();
  DbCountViewModel count = DbCountViewModel();

  String? dropDownValue;
  var _chosenValue;

  @override
  void initState() {
    model.fetchCustomers();
    _chosenValue == null;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Cart>(context, listen: false);
    final myorder = Provider.of<PlaceOrderViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.cartHeading),
        centerTitle: false,
        elevation: 0,
      ),
      body: ChangeNotifierProvider<CustomersViewModel>(
        create: (BuildContext context) => model,
        child: Consumer3<Cart, CustomersViewModel, PlaceOrderViewModel>(
            builder: (context, value, value2, value3, _) {
          switch (value2.customersList.status!) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              if (kDebugMode) {
                print(value2.customersList.message.toString());
              }
              return ErrorDialogue(
                message: value2.customersList.message.toString(),
              );
            case Status.completed:
              return value.items.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.totalCount,
                            itemBuilder: (context, index) {
                              final item = value.items[index];
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 1.h, right: 1.h, top: 1.h),
                                    padding: EdgeInsets.only(
                                        left: 1.h, top: 1.h, bottom: 1.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1.h)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: const Offset(0, 0),
                                        )
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWithStyle.productTitle(
                                              context, item.name),
                                          SizedBox(height: 0.5.h),
                                          Row(
                                            children: [
                                              TextWithStyle.productDescription(
                                                  context, item.packingType),
                                              SizedBox(width: 1.h),
                                              TextWithStyle.productDescription(
                                                  context, '(${item.packing})'),
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(CupertinoIcons
                                                .minus_circle_fill),
                                            iconSize: 3.h,
                                            color: AppColors.primaryColor,
                                            onPressed: () {
                                              provider.removeItem(item);
                                            },
                                          ),
                                          TextWithStyle.containerTitle(context,
                                              item.quantity.toString()),
                                          IconButton(
                                            icon: const Icon(CupertinoIcons
                                                .add_circled_solid),
                                            iconSize: 3.h,
                                            color: AppColors.primaryColor,
                                            onPressed: () {
                                              provider.addItem(item);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1.h),
                          padding: EdgeInsets.fromLTRB(2.h, 1.h, 2.h, 2.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 0),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextWithStyle.customerStatus(
                                      context,
                                      _chosenValue == null || _chosenValue == 0
                                          ? 'Book for Customer ??'
                                          : 'Order for:',
                                      Colors.black),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      hint: const Text('Select Customer'),
                                      value: _chosenValue,
                                      items: [
                                        const DropdownMenuItem(
                                          value: 0,
                                          child: Text('Select Customer'),
                                        ),
                                        ...value2.customersList.data!.data!
                                            .map<DropdownMenuItem>((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: SizedBox(
                                              width: 30.w,
                                              child: Text(
                                                value.name!.toUpperCase(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _chosenValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                height: 2.h,
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWithStyle.customerStatus(
                                          context, 'Total:', Colors.black),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Consumer<Cart>(
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return TextWithStyle.productPrice(
                                              context,
                                              value.totalPrice.toString());
                                        },
                                      )
                                    ],
                                  ),
                                  Button(
                                    title: "Place Order",
                                    onPress: () {
                                      if (_chosenValue.toString().isEmpty ||
                                          _chosenValue == null) {
                                        if(widget.isOwner == true){
                                          PlaceDistributorOrder entity =
                                          PlaceDistributorOrder();
                                          entity.orderList = value.items
                                              .map((e) => Order(
                                              productId: e.id,
                                              packing: e.packing,
                                              packingType: e.packingType,
                                              price: e.price.toInt(),
                                              quantity: e.quantity))
                                              .toList();
                                          myorder.placeOrder(entity, context);
                                          // provider.clear();
                                          count.fetchCountApi(context);
                                        }else{
                                          Utils.flushBarErrorMessage('Please Select Customer!!', context);
                                        }
                                      } else {
                                        PlaceCustomerOrder entity =
                                            PlaceCustomerOrder();
                                        entity.customerId = _chosenValue.id;
                                        entity.orderList = value.items
                                            .map((e) => Orders(
                                                productId: e.id,
                                                packing: e.packing,
                                                packingType: e.packingType,
                                                price: e.price.toInt(),
                                                quantity: e.quantity))
                                            .toList();
                                        myorder.placeCustomerOrder(
                                            entity, context, _chosenValue.name);
                                        //provider.clear();
                                        count.fetchCountApi(context);
                                      }
                                    },
                                    loading: value3.loading,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 2.h,),
                        // Column(
                        //   children: [
                        //     DropdownButtonFormField(
                        //       value: _chosenValue,
                        //     //  style: TextStyle(fontSize: 18.sp,color: Colors.black),
                        //       // decoration: InputDecoration(
                        //       //   enabledBorder: OutlineInputBorder(
                        //       //       borderRadius: const BorderRadius.all(Radius.circular(20)),
                        //       //       borderSide: BorderSide(color: AppColors.primaryColor)
                        //       //   ),
                        //       //   focusedBorder: OutlineInputBorder(
                        //       //       borderRadius: const BorderRadius.all(Radius.circular(20)),
                        //       //       borderSide: BorderSide(color: AppColors.primaryColor)
                        //       //   ),
                        //       //   errorBorder: OutlineInputBorder(
                        //       //       borderRadius:
                        //       //       const BorderRadius.all(Radius.circular(20)),
                        //       //       borderSide: BorderSide(color: Colors.red.shade700)),
                        //       //   focusedErrorBorder: OutlineInputBorder(
                        //       //       borderRadius:
                        //       //       const BorderRadius.all(Radius.circular(20)),
                        //       //       borderSide: BorderSide(color: Colors.red.shade700)),
                        //       //   border: InputBorder.none,
                        //       //   prefixIcon: Padding(
                        //       //     padding: EdgeInsets.all(2.w),
                        //       //     child: Icon(Icons.people ,size: 3.h,),
                        //       //   ),
                        //       //   hintText: 'Select Customer',
                        //       //   labelText: 'Customer',
                        //       // ),
                        //       validator: (value) {
                        //         if (value!.isEmpty) {
                        //           return 'Please enter your Name';
                        //         }
                        //         return null;
                        //       },
                        //       items: value2.customersList.data!.data!.map<DropdownMenuItem>((value) {
                        //         return DropdownMenuItem(
                        //           value: value,
                        //           child: Text(value.name!),
                        //         );
                        //       }).toList(),
                        //       onChanged: (value) {
                        //         _chosenValue = value;
                        //       },
                        //     ),
                        //     Button(
                        //       title: "Book Customer's Order",
                        //       onPress: (){
                        //         // PlaceCustomerOrder entity = PlaceCustomerOrder();
                        //         // entity.customerId = _chosenValue.id;
                        //         // entity.orderList = value.items.map((e) => Orders(
                        //         //     productId: e.id,
                        //         //     packing: e.packing,
                        //         //     packingType: e.packingType,
                        //         //     price: e.price.toInt(),
                        //         //     quantity: e.quantity
                        //         // )).toList();
                        //         // myorder.placeCustomerOrder(entity, context);
                        //         // provider.clear();
                        //       }, loading: myorder.loading,
                        //     ),
                        //     SizedBox(height: 3.h,)
                        //   ],
                        // )
                      ],
                    );
          }
        }),
      ),
    );
  }
}
