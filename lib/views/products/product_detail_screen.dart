import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/products/product_reponse_model.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/slider/Slider.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/requested_data_model/cartEntity.dart';
import '../Screens/visual_aids_screen.dart';
import 'product_list_widget.dart';
import '../../utils/utils.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {
  List<Products> value1;

  ProductDetailScreen(this.value1, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List img = [];
  List vis = [];
  dynamic data;

  SelectPacking packing = SelectPacking();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.value1.clear();
    img.clear();
    packing.selectedProducts.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final selectPacking = Provider.of<SelectPacking>(context,listen: false);
    final cartProvider = Provider.of<Cart>(context, listen: false);

    widget.value1[0].images?.forEach((element) {
      if (element.type == "IMG") {
        img.add(element.url);
      } else if (element.type == "VIS") {
        vis.add(element.url);
      }
    });

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        selectPacking.selectedProducts.clear();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
              centerTitle: false,
              elevation: 0,
              title: TextWithStyle.appBarTitle(
                  context, ConstantStrings.productDetails)),
          body: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        color: AppColors.backgroundColor,
                        margin: EdgeInsets.only(top: 1.h),
                        child: (widget.value1[0].images != null &&
                                widget.value1[0].images?.length != 0)
                            ? slider(
                                images: img,
                                aspectRatio: 1.1,
                                viewPortFraction: 1.0,
                              )
                            : Image.asset(
                                'assets/images/png/no_image.png',
                                height: 50.h,
                              )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(2.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWithStyle.appBarTitle(
                              context, widget.value1[0].name!),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(widget.value1[0].typeName!),
                          SizedBox(
                            height: 1.h,
                          ),
                          widget.value1[0].categoryName! == 'NA'
                              ? Container()
                              : Text(widget.value1[0].categoryName!),
                          Divider(
                            thickness: 1,
                            height: 3.h,
                          ),
                          Text(
                            widget.value1[0].description!.toLowerCase(),
                            style: TextStyle(
                                color: Colors.black54, fontSize: 18.sp),
                          ),
                          Divider(
                            thickness: 1,
                            height: 3.h,
                          ),
                          Text(
                            'Packing Variants:',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          widget.value1[0].packingVarient?.length != 0 &&
                                  widget.value1[0].packingVarient != null
                              ? Consumer<SelectPacking>(
                                  builder: (BuildContext context, value,
                                      Widget? child) {
                                    return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: widget.value1[0].packingVarient!.map((order) {
                                          return CheckboxListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            activeColor: AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.h),
                                            ),
                                            checkboxShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.h),
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      '${order.packingType!.label!}    (${order.packing})',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 18.sp)),
                                                ),
                                                TextWithStyle.productPrice(
                                                    context,
                                                    order.price?.toString() ??
                                                        '0'),
                                              ],
                                            ),
                                            value: value.isSelected(order),
                                            onChanged: (value) {
                                               selectPacking.toggleSelection(order);
                                            },
                                          );
                                        }).toList());
                                  },
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '${widget.value1[0].packingType!}   (${widget.value1[0].packing!})',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.sp)),
                                    ),
                                    TextWithStyle.productPrice(
                                        context,
                                        widget.value1[0].price?.toString() ??
                                            '0')
                                  ],
                                ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'Visual Aids',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 8,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: vis.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePage(imageUrl: vis[index])));
                                      },
                                        child: Image.network('${vis[index]}')),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 10.h,
              padding: EdgeInsets.all(2.h),
              color: Colors.white,
              child: Consumer2<SelectPacking, Cart>(
                builder: (BuildContext context, value, cart, Widget? child) {
                  final itemCount = cart.itemCount(widget.value1[0].id!);
                  final count = cart.items
                      .where((element) => element.id == widget.value1[0].id!)
                      .map((e) => e.quantity)
                      .join();
                  final price = cart.items
                      .where((element) => element.id == widget.value1[0].id!)
                      .map((e) => e.price)
                      .join();

                  String total = (double.parse(count.isEmpty ? '0' : count) *
                          double.parse(price.isEmpty ? '1' : price))
                      .toString();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWithStyle.appBarTitle(context,
                          "₹ ${total == '0' ? widget.value1[0].price : total}"),
                      itemCount > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                      CupertinoIcons.minus_circle_fill),
                                  iconSize: 4.h,
                                  color: AppColors.primaryColor,
                                  onPressed: () {
                                    cartProvider.removeItem(
                                      CartEntity(
                                        id: widget.value1[0].id!,
                                        name: widget.value1[0].name!,
                                        price: widget.value1[0].packingVarient![0].price!,
                                        packing: widget.value1[0].packingVarient![0].packing!,
                                        packingType: widget.value1[0].packingVarient![0].packingType!.value!,
                                      ),
                                    );
                                  },
                                ),
                                TextWithStyle.containerTitle(context, count.toString()),
                                IconButton(
                                  icon: const Icon(
                                      CupertinoIcons.add_circled_solid),
                                  iconSize: 4.h,
                                  color: AppColors.primaryColor,
                                  onPressed: () {
                                    cartProvider.addItem(
                                      CartEntity(
                                        id: widget.value1[0].id!,
                                        name: widget.value1[0].name!,
                                        price: widget.value1[0].packingVarient![0].price!,
                                        packing: widget.value1[0].packingVarient![0].packing!,
                                        packingType: widget.value1[0].packingVarient![0].packingType!.value!,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : widget.value1[0].packingVarient?.length != 0 &&
                                  widget.value1[0].packingVarient != null
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (value.selectedProducts.isEmpty) {
                                      Utils.flushBarErrorMessage(
                                          'Please Select a Packing Type!!!',
                                          context);
                                    } else {
                                      final cart = context.read<Cart>();
                                      cart.addItem(
                                        CartEntity(
                                          id: widget.value1[0].id!,
                                          name: widget.value1[0].name!,
                                          price: value.selectedProducts[0].price ??
                                                  widget.value1[0].price!,
                                          packing: value.selectedProducts[0].packing ??
                                              widget.value1[0].packing!,
                                          packingType: value.selectedProducts[0]
                                                  .packingType!.label ??
                                              widget.value1[0].packingType!,
                                        ),
                                      );
                                      //selectPacking.selectedProducts.clear();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                      elevation: 2,
                                      minimumSize: Size(15.h, 10.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.h)),
                                      )),
                                  child: TextWithStyle.addToCartTitles(
                                      context, ConstantStrings.addToCart))
                              : ElevatedButton(
                                  onPressed: () {
                                    final cart = context.read<Cart>();
                                    cart.addItem(
                                      CartEntity(
                                        id: widget.value1[0].id!,
                                        name: widget.value1[0].name!,
                                        price: widget.value1[0].price!,
                                        packing: widget.value1[0].packing!,
                                        packingType: widget.value1[0].packingType!,
                                      ),
                                    );
                                    // selectPacking.selectedProducts.clear();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                      elevation: 2,
                                      minimumSize: Size(15.h, 10.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.h)),
                                      )),
                                  child: TextWithStyle.addToCartTitles(
                                      context, ConstantStrings.addToCart))
                    ],
                  );

                  // : ElevatedButton(
                  // onPressed: () {
                  //   if(widget.value1[0].packingVarient != null
                  //       && widget.value1[0].packingVarient?.length != 0){
                  //     showModalBottomSheet<void>(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.vertical(
                  //               top: Radius.circular(5.h)
                  //           )),
                  //       isScrollControlled: true,
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return Container(
                  //           height: 40.h,
                  //           margin: EdgeInsets.fromLTRB(3.h, 5.h, 3.h, 5.h),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               TextWithStyle.customerName(context, 'Please Select Packing:'),
                  //               SizedBox(height: 1.h,),
                  //               Expanded(
                  //                   child: (widget.value1[0].packingVarient != null &&
                  //                       widget.value1[0].packingVarient?.length != 0)
                  //                       ? SingleChildScrollView(
                  //                     child: Consumer<SelectPacking>(
                  //                       builder: (BuildContext context, value, Widget? child) {
                  //                         return Column(
                  //                             mainAxisAlignment: MainAxisAlignment.center,
                  //                             mainAxisSize: MainAxisSize.min,
                  //                             children: widget.value1[0].packingVarient!.map((order){
                  //                               return CheckboxListTile(
                  //                                 activeColor: AppColors.primaryColor,
                  //                                 shape: RoundedRectangleBorder(
                  //                                   borderRadius: BorderRadius.circular(2.h),
                  //                                 ),
                  //                                 checkboxShape: RoundedRectangleBorder(
                  //                                   borderRadius: BorderRadius.circular(2.h),
                  //                                 ),
                  //                                 title: Row(
                  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                   children: [
                  //                                     Expanded(
                  //                                       child: Text('${order.packingType!.label!}    (${order.packing})',
                  //                                           style: TextStyle(color: Colors.black54, fontSize: 18.sp)),
                  //                                     ),
                  //                                     TextWithStyle.productPrice(
                  //                                         context,
                  //                                         order.price?.toString() ?? '0'),
                  //                                   ],
                  //                                 ),
                  //                                 value: value.isSelected(order),
                  //                                 onChanged: (value){
                  //                                   selectPacking.toggleSelection(order);
                  //                                 },
                  //                                 //groupValue: value.isSelectionMode,
                  //                               );
                  //                             }).toList()
                  //                         );
                  //                       },
                  //                     ),
                  //                   )
                  //                       : Text(widget.value1[0].packing ?? 'Na')
                  //               ),
                  //               Consumer<SelectPacking>(
                  //                 builder: (BuildContext context, value, Widget? child) {
                  //                   return Button(
                  //                       title: 'add',
                  //                       onPress: (){
                  //                         if(value.selectedProducts.isEmpty){
                  //                           Utils.flushBarErrorMessage('Please Select a Packing Type!!!', context);
                  //                         }else{
                  //                           final cart = context.read<Cart>();
                  //                           // cart.addItem(
                  //                           //   // CartEntity(
                  //                           //   //   id: product[index].id!,
                  //                           //   //   name: product[index].name!,
                  //                           //   //   price: value._selectedProducts[0].price ?? 0,
                  //                           //   //   packing: value._selectedProducts[0].packing ?? '',
                  //                           //   //   packingType: value._selectedProducts[0].packingType!.label ??'',
                  //                           //   // ),
                  //                           // );
                  //                           Navigator.pop(context);
                  //                         }
                  //                       }
                  //                   );
                  //                 },
                  //               )
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   }
                  //   else {
                  //     final cart = context.read<Cart>();
                  //     // cart.addItem(
                  //     //   // CartEntity(
                  //     //   //   id: product[index].id!,
                  //     //   //   name: product[index].name!,
                  //     //   //   price: product[index].price!,
                  //     //   //   packing: product[index].packing!,
                  //     //   //   packingType: product[index].packingType!,
                  //     //   // ),
                  //     // );
                  //   }
                  // },
                  // style: ElevatedButton
                  //     .styleFrom(
                  //     elevation: 0,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius
                  //             .all(
                  //             Radius
                  //                 .circular(
                  //                 1.2
                  //                     .h))
                  //     )
                  // ),
                  // child: TextWithStyle
                  //     .svgIconTitle(
                  //     context,
                  //     ConstantStrings
                  //         .addToCart));
                },
              ),
            )
          ])),
    );
  }
}
