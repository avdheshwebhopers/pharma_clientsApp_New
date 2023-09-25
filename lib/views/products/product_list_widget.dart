import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/cartEntity.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/response_model/products/product_reponse_model.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import '../Screens/visual_aids_screen.dart';
import 'product_detail_screen.dart';
import '../../utils/text_style.dart';
import '../../utils/before_login_utils/CustomClipper.dart';

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  ProductList({
    Key? key,
    required this.product
  }) : super(key: key);

  final List<Products> product;
  List<Products> value1 = [];
  List img = [];
  List order = [];
  dynamic data;

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<Cart>(context, listen: false);
    final provider = Provider.of<ProductViewModel>(context, listen: false);
    final selectPacking = Provider.of<SelectPacking>(context, listen: false);

    img.clear();

    for (var element in product) {
      if(element.images != null && element.images!.isNotEmpty){
        data = element.images?.firstWhere((ele) => ele.type == "IMG", orElse: () => Images(url: null,type: null));
        if(data != null){
          img.add(data!.url);
        }
      }else{
        img.add(data == false);
      }
    }

    List<FocusNode> focusNodes = List.generate(
      product.length,
          (index) => FocusNode(),
    );

    return product.isNotEmpty
        ? ListView.builder(
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return Consumer<ProductViewModel>(
                      builder: (BuildContext context, value, Widget? child) {
                        final isSelected = value.isSelected(product[index]);
                        return InkWell(
                            onTap: () {
                              if (value.isSelectionMode) {
                                provider.toggleSelection(product[index]);
                              } else {
                                value1.add(product[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ProductDetailScreen(value1)),);
                              }
                            },
                            onLongPress: () {
                              provider.toggleSelection(product[index]);
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.centerStart,
                              children: [
                                ClipPath(
                                  clipper: CustomClipPath(),
                                  child: Container(
                                      margin: EdgeInsets.only(left: 3.w,
                                          right: 3.w,
                                          top: 2.w,
                                          bottom: 1.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.h)),
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
                                      child: Container(
                                        margin: EdgeInsets.only(left: 16.5.h,
                                              //right: 3.w,
                                            top: 2.h,
                                            bottom: 1.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: TextWithStyle
                                                            .productTitle(
                                                            context,
                                                            product[index].name!
                                                                .toUpperCase()),),
                                                      if(isSelected)
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right: 3.w,
                                                          ),
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .check_mark_circled_solid,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  TextWithStyle.productTypeName(
                                                      context,
                                                      product[index].typeName!
                                                          .toUpperCase()),
                                                  SizedBox(height: 1.6.h,),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 2.w,),
                                                    child: TextWithStyle.productDescription(
                                                        context,
                                                        product[index].description
                                                            ?.toLowerCase() ??
                                                            'Na'),
                                                  ),
                                                  SizedBox(height: 1.6.h,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: TextWithStyle.productPrice(
                                                            context,
                                                            product[index].packingVarient?[0].price.toString() ??
                                                                '0'),
                                                      ),
                                                      Consumer<Cart>(
                                                        builder: (BuildContext context, cart, Widget? child) {
                                                          final itemCount = cart.itemCount(product[index].id!);
                                                          final count = cart.items.where((element) =>
                                                          element.id == product[index].id!).map((e) => e.quantity).join();
                                                          if(itemCount > 0){
                                                            TextEditingController qty = TextEditingController(text: count.toString());
                                                            return Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                IconButton(
                                                                  icon: const Icon(CupertinoIcons.minus_circle_fill),
                                                                  iconSize: 3.h,
                                                                  color: AppColors.primaryColor,
                                                                  onPressed: () {
                                                                    cartProvider.removeItem(
                                                                      CartEntity(
                                                                        id: product[index].id!,
                                                                        name: product[index].name!,
                                                                        price: product[index].packingVarient![0].price!,
                                                                        packing: product[index].packingVarient![0].packing!,
                                                                        packingType: product[index].packingVarient![0].packingType!.value!,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                  height: 4.h,
                                                                  child: TextFormField(
                                                                      style: TextStyle(fontSize: 18.sp,),
                                                                      controller: qty,
                                                                      focusNode: focusNodes[index],
                                                                      textAlign: TextAlign.center,
                                                                      // keyboardType: TextInputType.number,
                                                                      // onChanged: (value) {
                                                                      //   cartProvider.updateItemQuantity(
                                                                      //     CartEntity(
                                                                      //       id: product[index].id!,
                                                                      //       name: product[index].name!,
                                                                      //       price: product[index].packingVarient![0].price!,
                                                                      //       packing: product[index].packingVarient![0].packing!,
                                                                      //       packingType: product[index].packingVarient![0].packingType!.value!,
                                                                      //     ),
                                                                      //     int.tryParse(value) ?? 0,
                                                                      //   );
                                                                        // if (value.isNotEmpty && int.parse(value) > 0 && index < product.length - 1) {
                                                                        //   FocusScope.of(context).requestFocus(focusNodes[index]);
                                                                        // }
                                                                        //qty.selection = TextSelection.fromPosition(TextPosition(offset: qty.text.length));
                                                                      onFieldSubmitted: (value){
                                                                        cartProvider.updateItemQuantity(
                                                                          CartEntity(
                                                                          id: product[index].id!,
                                                                          name: product[index].name!,
                                                                          price: product[index].price!,
                                                                          packing: product[index].packing!,
                                                                          packingType: product[index].packingType!,
                                                                          ),
                                                                          int.tryParse(value) ?? 0,
                                                                        );},
                                                                  )),
                                                                IconButton(
                                                                  icon: const Icon(CupertinoIcons.add_circled_solid),
                                                                  iconSize: 3.h,
                                                                  color: AppColors.primaryColor,
                                                                  onPressed: () {
                                                                    cartProvider.addItem(
                                                                      CartEntity(
                                                                        id: product[index].id!,
                                                                        name: product[index].name!,
                                                                        price: product[index].packingVarient![0].price!,
                                                                        packing: product[index].packingVarient![0].packing!,
                                                                        packingType: product[index].packingVarient![0].packingType!.value!,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          }else{
                                                            return Container(
                                                              margin: EdgeInsets.only(
                                                                right: 3.w,
                                                              ),
                                                              child: ElevatedButton(
                                                                  onPressed: () {
                                                                    if(product[index].packingVarient != null
                                                                        && product[index].packingVarient?.length != 0){
                                                                      showModalBottomSheet<void>(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.vertical(
                                                                                top: Radius.circular(5.h)
                                                                            )),
                                                                        isScrollControlled: true,
                                                                        isDismissible: false,
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return Container(
                                                                            height: 40.h,
                                                                            margin: EdgeInsets.fromLTRB(3.h, 5.h, 3.h, 5.h),
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                TextWithStyle.customerName(context, 'Please Select Packing:'),
                                                                                SizedBox(height: 1.h,),
                                                                                Expanded(
                                                                                    child: (product[index].packingVarient != null &&
                                                                                        product[index].packingVarient?.length != 0)
                                                                                        ? SingleChildScrollView(
                                                                                      child: Consumer<SelectPacking>(
                                                                                        builder: (BuildContext context, value, Widget? child) {
                                                                                          return Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: product[index].packingVarient!.map((order){
                                                                                                return CheckboxListTile(
                                                                                                    activeColor: AppColors.primaryColor,
                                                                                                    shape: RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(2.h),
                                                                                                    ),
                                                                                                    checkboxShape: RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(2.h),
                                                                                                    ),
                                                                                                    title: Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Text('${order.packingType!.label!}    (${order.packing})',
                                                                                                          style: TextStyle(color: Colors.black54, fontSize: 18.sp)),
                                                                                                        ),
                                                                                                        TextWithStyle.productPrice(
                                                                                                            context,
                                                                                                            order.price?.toString() ?? '0'),
                                                                                                      ],
                                                                                                    ),
                                                                                                    value: value.isSelected(order),
                                                                                                    onChanged: (value){
                                                                                                      selectPacking.toggleSelection(order);
                                                                                                    },
                                                                                                  //groupValue: value.isSelectionMode,
                                                                                                );
                                                                                              }).toList(),
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    )
                                                                                        : Text(product[index].packing ?? 'Na')
                                                                                ),
                                                                                Consumer<SelectPacking>(
                                                                                  builder: (BuildContext context, value, Widget? child) {
                                                                                    return Button(
                                                                                        title: 'add',
                                                                                        onPress: (){
                                                                                          if(value._selectedProducts.isEmpty){
                                                                                            Utils.flushBarErrorMessage('Please Select a Packing Type!!!', context);
                                                                                          }else{
                                                                                            final cart = context.read<Cart>();
                                                                                            cart.addItem(
                                                                                              CartEntity(
                                                                                                id: product[index].id!,
                                                                                                name: product[index].name!,
                                                                                                price: value._selectedProducts[0].price ?? 0,
                                                                                                packing: value._selectedProducts[0].packing ?? '',
                                                                                                packingType: value._selectedProducts[0].packingType!.label ??'',
                                                                                              ),);
                                                                                            Navigator.pop(context);
                                                                                           // selectPacking.selectedProducts.clear();
                                                                                          }
                                                                                        }, loading: false,
                                                                                    );
                                                                                  },
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    } else {
                                                                      final cart = context.read<Cart>();
                                                                      cart.addItem(
                                                                        CartEntity(
                                                                          id: product[index].id!,
                                                                          name: product[index].name!,
                                                                          price: product[index].price!,
                                                                          packing: product[index].packing!,
                                                                          packingType: product[index].packingType!,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                      elevation: 1,
                                                                      minimumSize: Size(MediaQuery.of(context).size.width / 4,
                                                                          MediaQuery.of(context).size.height / 22),
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius
                                                                              .all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10))
                                                                      )
                                                                  ),
                                                                  child: TextWithStyle
                                                                      .svgIconTitle(
                                                                      context,
                                                                      ConstantStrings
                                                                          .addToCart)),
                                                            );
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePage(imageUrl: img[index])));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 3.w, top: 1.5.h, bottom: 1.h),
                                      height: 15.h,
                                      width: 15.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.h)),
                                          boxShadow: const [ BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: Offset(-1, 0),
                                              blurStyle: BlurStyle.normal
                                          )
                                          ]
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.h)),
                                          child:
                                          (img[index] != false && img[index] != null)
                                              ? CachedNetworkImage(
                                              placeholderFadeInDuration: const Duration(seconds: 2),
                                              placeholder: (context, url) => Container(
                                                height: MediaQuery.of(context).size.height,
                                                width: MediaQuery.of(context).size.width,
                                                color: AppColors.backgroundColor,
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/images/png/loading.gif',
                                                    // height: 6.h,
                                                  ),
                                                ),
                                              ),
                                              imageUrl:'${img[index]}')
                                              : Image.asset(
                                              'assets/images/png/no_image.png',
                                              width: 15.h,
                                              height: 15.h,
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    )
                                ),
                              ],
                            )
                        );
                      });
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
}

class SelectPacking extends ChangeNotifier {

  List<PackingVarient> _products = [];
  List<PackingVarient> _selectedProducts = [];
  List<PackingVarient> get selectedProducts => _selectedProducts;

  bool get isSelectionMode => _selectedProducts.isNotEmpty;

  List<PackingVarient> get products => _products;

  void toggleSelection(PackingVarient product) {
    if (_selectedProducts.contains(product)) {
      _selectedProducts.remove(product);
    } else {
      _selectedProducts.clear();
      _selectedProducts.add(product);
    }
    notifyListeners();
  }

  bool isSelected(PackingVarient product) {
    return _selectedProducts.contains(product);
  }
}