import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/constant_imageString.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import '../../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';

// ignore: must_be_immutable
class VisualAidsScreen extends StatefulWidget {
   VisualAidsScreen({
    required this.token,
    Key? key}) : super(key: key);

  String? token;
  @override
  State<VisualAidsScreen> createState() => _VisualAidsScreenState();
}

class _VisualAidsScreenState extends State<VisualAidsScreen> {

  TextEditingController controller = TextEditingController();

  GuestVisualAidsViewModel model = GuestVisualAidsViewModel();
  VisualAidsViewModel model1 = VisualAidsViewModel();

  @override
  void initState() {
    // TODO: implement initState

    if(widget.token != null && widget.token!.isNotEmpty){
      model1.fetchVisualAids();
    }else{
      model.fetchVisualAids();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 7.h,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.visualAidsscreenHeading),
      ),
      body: widget.token != null && widget.token!.isNotEmpty
          ? ChangeNotifierProvider<VisualAidsViewModel>(
        create: (BuildContext context) => model1,
        child: Consumer<VisualAidsViewModel>(
          builder: (context,value,_){
            switch(value.visualaidsList.status!){
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                return ErrorDialogue(message: value.visualaidsList.message);
              case Status.completed:
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(3.w),
                      child: TextFormField(
                        style: TextStyle(fontSize: 16.sp),
                        controller: controller,
                        onChanged: (value){
                          model1.filteredVisuals(value.toLowerCase());
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
                            hintText: "Search by Product Name"),
                      ),
                    ),
                    Expanded(
                      child: value.visualAids.isNotEmpty
                      ? Container(
                        margin: EdgeInsets.only(left: 1.h,right: 1.h,top:1.h),
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2
                            ),
                            itemCount: value.visualAids.length,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePage(imageUrl: value.visualAids[index].url!)));
                                },
                                child: Card(
                                  margin: EdgeInsets.only(left: 1.w,right: 1.w,top: 2.w),
                                  elevation: 2.w,
                                  shadowColor: Colors.black54,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.h))),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/png/loading.gif',
                                    image: '${value.visualAids[index].url}',
                                  ),
                                  // Image.network(''),
                                ),
                              );
                            }),
                      )
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
            )
                    ),
                  ],
            );
            }
          },
        ),
      )
          : ChangeNotifierProvider<GuestVisualAidsViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<GuestVisualAidsViewModel>(
          builder: (context,value,_){
            switch(value.visualaidsList.status!){
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.error:
                if (kDebugMode) {
                  print('run error');
                }
                return Center(
                  child: Text(value.visualaidsList.message.toString()),
                );
              case Status.completed:
                return Container(
                  margin: EdgeInsets.only(left: 1.h,right: 1.h,top:1.h),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),
                      itemCount: value.visualaidsList.data?.data?.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePage(imageUrl: value.visualaidsList.data!.data![index].url!)));
                          },
                          child: Card(
                            margin: EdgeInsets.only(left: 1.w,right: 1.w,top: 2.w),
                            elevation: 2.w,
                            shadowColor: Colors.black54,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(2.h))),
                            child: CachedNetworkImage(
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
                                imageUrl: '${value.visualaidsList.data?.data?[index].url}'
                            )
                          ),
                        );
                      }),
                );
            }
          },
        ),
      )
    );
  }
}

class ImagePage extends StatelessWidget {
  final String imageUrl;

  ImagePage({required this.imageUrl});

  int height = 0;

  int width = 0;

  // @override
  @override
  Widget build(BuildContext context) {
    Image myImage = Image.network(imageUrl);
    myImage.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        height = imageInfo.image.height;
        width = imageInfo.image.width;
        print('Actual height: ${imageInfo.image.height}');
        print('Actual width: ${imageInfo.image.width}');
      }),
    );
    return ///(height == width || height > width) ?
    _buildPortraitPageView(imageUrl);
        // : _buildLandscapePageView(imageUrl);
  }

  Widget _buildPortraitPageView(String imageUrl) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    return InteractiveViewer(
      child: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Image.network(imageUrl,
            fit: BoxFit.contain,),
        ],
      ),
    );
  }

  Widget _buildLandscapePageView(String imageUrl) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    // ]);
    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView(
            children: [
              Image.network(imageUrl),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 3.h,right: 10.w),
              child: const Icon(CupertinoIcons.clear_thick_circled, color: Colors.white,))
        ]
      ),
    );
  }
}

