import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/response_model/products/product_reponse_model.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import 'product_list_widget.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import '../../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';

// ignore: must_be_immutable
class UpcomingProductScreen extends StatefulWidget {
   UpcomingProductScreen({
     required this.token,
     Key? key}) : super(key: key);
   String? token;

  @override
  State<UpcomingProductScreen> createState() => _UpcomingProductScreenState();
}

class _UpcomingProductScreenState extends State<UpcomingProductScreen> {

  GuestProductViewModel model = GuestProductViewModel();
  ProductViewModel model1 = ProductViewModel();
  List<Products> value1 = [];
  List<Products> product = [];

  @override
  void initState() {
    if(widget.token != null && widget.token!.isNotEmpty){
      model1.fetchProductsApi();
    }else{
      model.fetchProductApi();
    }
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.upcomingScreenHeading)
      ),
      body: widget.token != null && widget.token!.isNotEmpty
          ? ChangeNotifierProvider(
            create: (BuildContext context) => model1,
            child: Consumer<ProductViewModel>(
              builder: (context,value, _){
                    return value.loading
                        ? const Center(child: CircularProgressIndicator(),)
                        : ProductList(product: value.upcoming);

                }
              //},
            ),
          )
          : ChangeNotifierProvider<GuestProductViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<GuestProductViewModel>(
          builder: (context,value, _){
            switch(value.productlist.status!){
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (kDebugMode) {
                  print(value.productlist.message.toString());
                }
                return ErrorDialogue(
                  message: value.productlist.message,
                );
              case Status.completed:
                for (var element in value.productlist.data!.data!) {
                  if(element.upcoming == true && element.active == true){
                    product.add(element);
                  }
                }
                return ProductList(product: product);
            }
          },
        ),
      ),
    );
  }
}
