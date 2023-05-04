import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/selfAnalysisResponseModel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/text_style.dart';

class VisitWiseRecordScreen extends StatefulWidget {
  VisitWiseRecordScreen({Key? key,required this.data}) : super(key: key);

  List<Customers> data;

  @override
  State<VisitWiseRecordScreen> createState() => _VisitWiseRecordScreenState();
}

class _VisitWiseRecordScreenState extends State<VisitWiseRecordScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: TextWithStyle.appBarTitle(
            context, ConstantStrings.selfAnalysis),
        elevation: 0,
      ),
      body: widget.data.isNotEmpty
          ? ListView.builder(
        itemCount: widget.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final data = widget.data[index];
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
                  Row (children: [
                        Text('Customer Name: ',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: TextWithStyle.customerDetails(context, data.customerInfo?.name ?? 'NA'),
                        )
                      ]),
                  const Divider(
                    thickness: 1,
                  ),
                  Row (
                      children: [
                        Text('Total Visits:  ',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: TextWithStyle.customerDetails(context, data.visitsCount.toString()),
                        )
                      ]),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone No.:  ',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                            child: TextWithStyle.customerDetails(context, data.customerInfo?.phone.toString() ?? '0'),
                        )
                      ]),
                  SizedBox(
                    height: 1.h,),
                  Column(
                    children: data.dataByVisit!.map((e) => Column(
                      children: [
                        const Divider(
                          thickness: 1,
                        ),
                        Row (
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Response:  ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: TextWithStyle.customerDetails(context, data.dataByVisit?[0].remark ?? 'Na'),
                              )

                            ]),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Products:    ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: TextWithStyle.customerDetails(context, data.dataByVisit?[0].products?.map((e) => '${e.name} x ${e.count ?? '1'}').join(',  ') ?? 'Na'),
                              )

                            ]),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Place:            ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: TextWithStyle.customerDetails(context, data.dataByVisit?[0].place ?? 'Na'),
                              )

                            ]),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Time:             ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: TextWithStyle.customerDetails(context, data.dataByVisit?[0].time ?? 'Na'),
                              )

                            ]),
                      ],
                    )).toList(),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     // TextWithStyle.customerProductDetails(context, pro),
                  //     // TextWithStyle.customerDetails(context, packing),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  // const Divider(
                  //   thickness: 1,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //      TextWithStyle.customerTimeDetails(context, data.dataByVisit?[0].time ?? 'Na'),
                  //     // TextWithStyle.customerProductDetails(context, 'Rs.$Price'),
                  //   ],
                  // )
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
      )
    );
  }
}
