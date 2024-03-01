import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/requested_data_model/presentaionData.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/text_style.dart';
import 'addPresentationScreen.dart';

class PresentationListScreen extends StatefulWidget {

  @override
  State<PresentationListScreen> createState() => _PresentationListScreenState();
}

class _PresentationListScreenState extends State<PresentationListScreen> {

  Presentation prefs = Presentation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextWithStyle.appBarTitle(context, ConstantStrings.presentationHeading),
        elevation: 0,
        toolbarHeight: 6.h,
      ),
      body: FutureBuilder(
        future: prefs.loadPresentations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final presentations = snapshot.data!;
            if (presentations.isEmpty) {
              return const Center(
                child: Text('No presentations found.'),
              );
            }
            return ListView.builder(
              itemCount: presentations.length,
              itemBuilder: (context, index) {
                final presentation = presentations[index];
                return Container(
                  margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                  padding: EdgeInsets.only(left: 2.h,bottom: 0.5.h),
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
                  child: ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: 1.h),
                      child: TextWithStyle.containerTitle(context,presentation.name),
                    ),
                    subtitle: TextWithStyle.productDescription(context,'${presentation.images.length} images'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PresentationScreen(
                        presentation: presentation,
                      )));
                      // navigate to a screen to display the presentation
                    },
                    // leading: GestureDetector(
                    //     child: Icon(Icons.edit),
                    //   onTap: () {
                    //     final updatepresentation = PresentationData(name: 'Avi', images: [ImageData(name: 'abc', imageUrl: 'https://clientapps.webhopers.com:3227/core/uploads/products/vis/1.jpg')]);
                    //     setState(() {
                    //       prefs.updatePresentation(presentation.name, updatepresentation);
                    //     });
                    //   },
                    // ),
                    trailing: GestureDetector(
                      onTap: (){
                        setState(() {
                          prefs.removepresentation(presentation.name);
                        });
                    },child: const Icon(Icons.delete),),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading presentations: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PresentationScreen extends StatelessWidget {
  final PresentationData presentation;

  const PresentationScreen({Key? key, required this.presentation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = List.from(presentation.images.map((image) => image.imageUrl)); // Extracting image URLs directly

    // Add default images to the beginning and end of the list
    images.insert(0, 'assets/images/png/presentation_front.png');
    images.add('assets/images/png/presentation_back.png');

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextWithStyle.appBarTitle(context, presentation.name),
        elevation: 0,
      ),
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          String imageUrl = images[index];
          if (index == 0 || index == images.length - 1) { // First and last images
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              ),
            );
          } else {
            return imageUrl.startsWith('assets/') ? AssetImageWidget(imageUrl) : CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => PlaceholderImage(),
              errorWidget: (context, url, error) {
                print('Failed to load image: $imageUrl\n$error');
                return const Icon(Icons.error);
              },
            );
          }
        },
      ),
    );
  }
}

class AssetImageWidget extends StatelessWidget {
  final String imageUrl;

  const AssetImageWidget(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover, // Adjust as needed
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        print('Failed to load asset image: $imageUrl\n$exception');
        return const Icon(Icons.error);
      },
    );
  }
}

class PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppColors.backgroundColor,
      child: Center(
        child: Image.asset(
          'assets/images/png/loading-gif.gif',
          height: 6.h,
        ),
      ),
    );
  }
}

