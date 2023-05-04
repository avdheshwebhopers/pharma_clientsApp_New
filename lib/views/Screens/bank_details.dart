import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/text_style.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  FirmViewModel model = FirmViewModel();

  @override
  void initState() {
    // TODO: implement initState
    model.fetchFirm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title:
              TextWithStyle.appBarTitle(context, ConstantStrings.bankDetails),
          elevation: 0,
        ),
        body: ChangeNotifierProvider<FirmViewModel>(
            create: (BuildContext context) => model,
            child: Consumer<FirmViewModel>(
                builder: (BuildContext context, value, _) {
              switch (value.firm.status!) {
                case Status.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.error:
                  if (kDebugMode) {
                    print(value.firm.message.toString());
                  }
                  return ErrorDialogue(
                    message: value.firm.message.toString(),
                  );
                case Status.completed:
                  var data = value.firm.data!.data;
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h,top: 1.h),
                        padding: EdgeInsets.all(3.h),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bank Name',
                              style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.black45
                            ),
                            ),
                            SizedBox(height: 0.5.h,),
                            Text('${data?.bankName?? 'Na'}\n',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                fontWeight: FontWeight.w600
                              ),),
                            Text('Account Number',
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.black45
                              ),),
                            SizedBox(height: 0.5.h,),
                            Text('${data?.bankAccNo ?? 'NA'}\n',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600
                                )
                            ),
                            Text('IFSC Code',
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.black45
                              ),),
                            SizedBox(height: 0.5.h,),
                            Text('${data?.bankIfsc ?? 'NA'}\n',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600
                                )
                            ),
                            Text('Payee Name',
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.black45
                              ),),
                            SizedBox(height: 0.5.h,),
                            Text('${data?.bankPayeeName ?? 'NA'}' ,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: Image.asset(
                              'assets/images/png/webhopers_logo2.png',
                              width: MediaQuery.of(context).size.width / 3.5,
                            )),
                      ))
                    ],
                  );
              }
            })));
  }
}
