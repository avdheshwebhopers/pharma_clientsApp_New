import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/requested_data_model/addToFavEntity.dart';
import '../../data/model/response_model/products/product_reponse_model.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import 'product_list_widget.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

// ignore: must_be_immutable
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  ProductViewModel model1 = ProductViewModel();
  List<Products> value1 = [];
  List<Products> product = [];
  List<String> remove = [];

  @override
  void initState() {
    model1.fetchProductsApi();
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

  Future<void> Product()async {
    model1.favProducts.clear();
    model1.fetchProductsApi();
  }


  @override
  Widget build(BuildContext context) {

    print('run');

    final provider =  Provider.of<AddtoFavViewModel>(context,listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: TextWithStyle.appBarTitle(context, ConstantStrings.favouriteScreenHeading),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,12),
                child: provider.loading
                    ? const CircularProgressIndicator()
                    : IconButton(
                    onPressed: () async {
                    if(model1.selectedProducts.isEmpty){
                      Utils.flushBarErrorMessage("Please Select Products", context);
                      }else{
                      AddToFavEntity entity = AddToFavEntity();
                      entity.id = model1.selectedProducts.map((e) => e.id!).toList();
                      provider.removeFav(entity, context, product);
                      model1.clearSelection();
                      model1.favProducts.clear();
                      model1.fetchProductsApi();
                      }
                  },
                  icon: const Icon(CupertinoIcons.heart_slash_fill,),
                  color: AppColors.primaryColor,
                  iconSize: 8.w,
                )
            ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => model1,
        child: Consumer<ProductViewModel>(
          builder: (context, value, _){
                return value.loading
                    ? const Center(child: CircularProgressIndicator(),)
                    : ProductList(product: value.favProducts);
            }
         // },
        ),
      )
    );
  }
}
