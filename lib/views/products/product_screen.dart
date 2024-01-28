import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/addToFavEntity.dart';
import 'package:pharma_clients_app/data/model/response_model/division_responseModel.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/views/Screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:badges/badges.dart' as badge;
import '../../data/model/response_model/products/product_reponse_model.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import 'product_list_widget.dart';
import '../../utils/utils.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import '../../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
   ProductScreen({
     required this.token,
     required this.isOwner,
    Key? key}) : super(key: key);
   String? token;
   bool? isOwner;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  GuestProductViewModel model = GuestProductViewModel();
  ProductViewModel products = ProductViewModel();
  DivisionsViewModel division = DivisionsViewModel();
  TextEditingController controller = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  List<Products> value1 = [];
  List<String> product = [];

  final List<CheckBoxItems> items = [];

  @override
  void initState() {

    if(widget.token != null && widget.token!.isNotEmpty){
      products.fetchProductsApi();
    }else{
      model.fetchProductApi();
    }
    division.fetchDivisions();
    value1.clear();
   product.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    value1.clear();
    product.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProductByDivision>(context, listen: false);
    final addtofav = Provider.of<AddtoFavViewModel>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.productScreen),
        toolbarHeight: 7.h,
        centerTitle: false,
        automaticallyImplyLeading: true,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(top: 0.h,bottom: 4.h),
              child: addtofav.loading
                  ? const CircularProgressIndicator()
                  : IconButton(
                onPressed: () {
                  if(products.selectedProducts.isEmpty){
                    Utils.flushBarErrorMessage("Please Select Products", context);
                  }else{
                    AddToFavEntity entity = AddToFavEntity();
                    entity.id = products.selectedProducts.map((e) => e.id!).toList();
                    addtofav.addTofav(entity, context);
                    products.selectedProducts.clear();
                  }
                },
                icon: const Icon(CupertinoIcons.suit_heart_fill,),
                color: AppColors.primaryColor,
                iconSize: 4.h,
              )
          ),
          FutureBuilder(
            future: cart.loadCart(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Consumer<Cart>(builder: (BuildContext context, value, Widget? child) {
                return badge.Badge(
                  badgeAnimation: const badge.BadgeAnimation.slide(),
                  position: badge.BadgePosition.topEnd(end: 0, top: 0),
                  badgeStyle: badge.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  badgeContent: Text(
                    value.items.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                  child: IconButton(
                      onPressed: () {
                        widget.token != null
                            ? Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> CartScreen( isOwner: widget.isOwner, owner: widget.token,)))
                            : Navigator.pop(context);
                      },
                      icon: Container(
                        margin: EdgeInsets.only(top: 0.5.h),
                        child: Icon(
                          CupertinoIcons.cart,
                          size: 3.5.h,
                        ),
                      )
                  ),
                );
              },);
            },
          ),
          SizedBox(
            width: 3.w,
          )
        ],
      ),
      body: widget.token != null && widget.token!.isNotEmpty
          ? ChangeNotifierProvider<DivisionsViewModel>(
            create: (BuildContext context) => division,
            child: ChangeNotifierProvider<ProductViewModel>(
              create: (BuildContext context) => products,
              child: Consumer2<ProductViewModel,DivisionsViewModel>(
                builder: (context, value, value2, _) {
                  switch (value2.divisionList.status!) {
                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                        case Status.error:
                        return ErrorDialogue(message: value2.divisionList.message);
                        case Status.completed:
                        return value.loading
                            ? const Center(child:CircularProgressIndicator())
                            : Column(
                          children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(3.w),
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 16.sp),
                                          controller: controller,
                                          onChanged: (value){
                                            products.filterItems(value.toLowerCase());
                                          },
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.primaryColor.withOpacity(0.1),
                                              enabledBorder: const OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(15)),
                                                  borderSide:
                                                  BorderSide(color: Colors.white)),
                                              focusedBorder: const OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(15)),
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              contentPadding: EdgeInsets.all(2.5.h),
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(left: 1.h,right: 1.h),
                                                child: Icon(CupertinoIcons.search,size: 3.h,),
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Search by Name, Type & Category"),
                                        ),
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 2.w),
                                    child: InkWell(
                                      onTap: (){
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Select Divisions',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)),
                                              actionsPadding: EdgeInsets.only(right: 2.h,bottom: 2.h),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: value2.divisionList.data!.data!.map((division) {
                                                    return Consumer<ProductByDivision>(
                                                      builder: (BuildContext context, value, Widget? child) {
                                                        return CheckboxListTile(
                                                          checkboxShape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(2.h),
                                                          ),
                                                          activeColor: AppColors.primaryColor,
                                                          title: Text(division.name!),
                                                          value: value.isSelected(division),
                                                          onChanged: (value) {
                                                            if (value!) {
                                                              provider.addDivision(division);
                                                            } else {
                                                              provider.removeDivision(division);
                                                            }
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              actions: [
                                                Consumer<ProductByDivision>(
                                                  builder: (BuildContext context, value,
                                                      Widget? child) {
                                                    return ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: AppColors.primaryColor
                                                      ),
                                                      child: const Text('OK',style: TextStyle(color: Colors.white),),
                                                      onPressed: () {
                                                        List<String>? name = [];
                                                        for(var element in value.selectedDivisions){
                                                          name.add(element.name!);
                                                        }
                                                         products.filterByDivision(name);
                                                        Navigator.of(context).pop();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.filter_list,
                                        size: 4.h,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                  child: ProductList(product: value.products,
                                  ))
                          ],
                        );
                  }
                }
              ),
            ),
          )
          : ChangeNotifierProvider<GuestProductViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<GuestProductViewModel>(
          builder: (context, value, _) {
            switch (value.productlist.status!) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                return Center(
                  child: Text(value.productlist.message.toString()),
                );
              case Status.completed:
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.w),
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                    AppColors.primaryColor.withOpacity(0.1),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.w)),
                                        borderSide:
                                        const BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.w)),
                                        borderSide: BorderSide(
                                            color: AppColors.primaryColor)
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                    prefixIcon: const Icon(CupertinoIcons.search),
                                    border: InputBorder.none,
                                    labelText: "Search",
                                    hintText: "Search Products by name,type,category"),
                                    onChanged: (value){
                                    model.filterItems(value.toLowerCase());
                                },
                              ),
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 2.w),
                          child: Icon(
                            Icons.filter_list,
                            size: 10.w,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: ProductList(
                          product: value.products,
                        )
                    )
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

class CheckBoxItems {
  bool selected;
  String name;

  CheckBoxItems({
    this.selected = false,
    required this.name,
  });
}

class ProductByDivision extends ChangeNotifier {
  final List<Data> _selectedDivisions = [];
  List<Data> get selectedDivisions => _selectedDivisions;

  void addDivision(Data division) {
    _selectedDivisions.add(division);
    notifyListeners();
  }

  void removeDivision(Data division) {
    _selectedDivisions.remove(division);
    notifyListeners();
  }

  bool isSelected(Data division) {
    return _selectedDivisions.contains(division);
  }

}