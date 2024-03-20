import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/utils/slider/slider_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: camel_case_types
class slider extends StatelessWidget {
  slider({
    Key? key,
    required this.images,
    this.aspectRatio,
    this.viewPortFraction,
  }) : super(key: key);

  List images;
  dynamic aspectRatio;
  dynamic viewPortFraction;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<SliderProvider>(context, listen: false);

    return Column(children: [
      CarouselSlider.builder(
        carouselController: _controller,
        itemCount: images.length,
        options: CarouselOptions(
            autoPlay: images.length != 1 ? true : false ,
            aspectRatio: 2.1,//2.1
            viewportFraction: 0.9,
            animateToClosest: false,
            pageSnapping: true,//0//
            enlargeCenterPage: true,// .93
            enlargeFactor: 0.4,
            onPageChanged: (index, _) {
              countProvider.setIndex(index);
            }),
        itemBuilder: (context, index, realIdx) {
          return Container(
            margin: EdgeInsets.only(left: 0.w, right: 0.w),
            child: images.isNotEmpty
                ? Image.network(
                    '${images[index]}',
                    fit: BoxFit.fitWidth,

                  )
                : Image.asset(
                    'assets/images/no_image_available.png',
                    height: 20.h,
                  ),
          );
        },
      ),
      const SizedBox(height: 5,),
      Consumer<SliderProvider>(builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return Container(
              width: value.current == entry.key ? 13.0 : 6,
              height: 6.0,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : AppColors.primaryColor)
                      .withOpacity(value.current == entry.key ? 1 : 0.2)),
            );
          }).toList(),
        );
      }),
    ]);
  }
}
