import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pharma_clients_app/data/model/response_model/about_company/about_company_response_model.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/IconWithFun/png_with_fun.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../utils/Dialogue/error_dialogue.dart';

// ignore: must_be_immutable
class DivisionScreen extends StatefulWidget {
  DivisionScreen({Key? key, required this.value, this.token}) : super(key: key);

  List<AboutCompany> value;
  String? token;

  @override
  State<DivisionScreen> createState() => _DivisionScreen();
}

class _DivisionScreen extends State<DivisionScreen> {
  DivisionsViewModel model = DivisionsViewModel();

  List value1 = [];
  var fileId;

  @override
  void initState() {
    value1.clear();
    if (widget.token != null && widget.token!.isNotEmpty) {
      model.fetchDivisions();
    } else {
      widget.value[0].downloadLinks?.forEach((element) {
          value1.add(element);
      });
    }
    // TODO: implement initState
    super.initState();
  }

  Future<void> downloadAndOpenPdfFromGoogleDrive(String url) async {
    if(url == 'NA'){
      Utils.flushBarErrorMessage('Please enter Url from Dashboard', context);
    }else {
      try {
        String? fileId = await getFileIdFromUrl(url);
        String downloadUrl = 'https://drive.google.com/u/0/uc?id=$fileId&export=download';
        var response = await http.get(Uri.parse(downloadUrl));
        var bytes = response.bodyBytes;
        final String path = (await getApplicationDocumentsDirectory()).path;
        final File file = File('$path/list.pdf');
        await file.writeAsBytes(bytes, flush: true);
        OpenFilex.open(file.path);
        if (kDebugMode) {
          print('Downloaded PDF file');
        }
      } catch (e) {
        // Handle errors
        Utils.flushBarErrorMessage('Error downloading PDF file: $e', context);
        print('Error downloading PDF file: $e');
      }
    }
  }

  Future<String?> getFileIdFromUrl(String url) async {
    var regex = RegExp(r"/d/([a-zA-Z0-9-_]+)");
    var match = regex.firstMatch(url);
    if (match != null) {
      fileId = match.group(1);
      return fileId;
    } else {
      var apiUrl = 'https://www.googleapis.com/drive/v3/files';
      var response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer ${widget.token}'
      });
      var data = json.decode(response.body);
      var files = data['files'];
      for (var file in files) {
        if (file['webViewLink'] == url) {
          return file['id'];
        }
      }
      throw Exception('Unable to get file ID from URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: 7.h,
          title: TextWithStyle.appBarTitle(context, ConstantStrings.divisions),
          elevation: 0,
        ),
        body: widget.token != null && widget.token!.isNotEmpty
            ? ChangeNotifierProvider<DivisionsViewModel>(
                create: (BuildContext context) => model,
                child: Consumer<DivisionsViewModel>(builder: (context, value, _) {
                  switch (value.divisionList.status!) {
                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.error:
                      return ErrorDialogue(message: value.divisionList.message);
                    case Status.completed:
                      return ListView.builder(
                          itemCount: value.divisionList.data?.data?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 1.h, right: 1.h, top: 1.h),
                              padding: EdgeInsets.only(bottom: 1.h,top: 1.h,),
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
                              child: ExpansionTile(
                                title: TextWithStyle.containerTitle(
                                    context,
                                    value.divisionList.data!
                                        .data?[index].name! ??
                                        'NA'),
                                trailing: Image.asset(
                                  'assets/images/png/download.png',
                                  height: 10.w,
                                ),
                                childrenPadding: EdgeInsets.only(left: 2.h,right: 2.h,top: 2.h,bottom: 1.h),
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                             downloadAndOpenPdfFromGoogleDrive(value.divisionList.data!.data?[index].productListLink ?? 'NA');
                                          },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primaryColor,
                                            minimumSize: Size(MediaQuery.of(context).size.width / 3,
                                                MediaQuery.of(context).size.height / 18),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(2.h)))),
                                        child: Text(
                                          'Products',
                                          style: GoogleFonts.workSans(
                                              color: Colors.white,
                                              textStyle: Theme.of(context).textTheme.bodyMedium,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                    ),
                                      ElevatedButton(
                                          onPressed: (){
                                            downloadAndOpenPdfFromGoogleDrive(value.divisionList.data!.data?[index].visualaidsLink ?? 'NA');
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primaryColor,
                                              minimumSize: Size(MediaQuery.of(context).size.width / 3,
                                                  MediaQuery.of(context).size.height / 18),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(2.h)))),
                                          child: Text(
                                            'Visual Aids',
                                            style: GoogleFonts.workSans(
                                                color: Colors.white,
                                                textStyle: Theme.of(context).textTheme.bodyMedium,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400),
                                          )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                  }
                }))
            : ListView.builder(
                itemCount: value1.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 3.w),
                    elevation: 2.w,
                    shadowColor: Colors.black38,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.h))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 3.h, top: 2.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWithStyle.containerTitle(
                                        context, value1[index].divisionName!),
                                    SizedBox(
                                      height: 2.h,
                                    )
                                  ],
                                ))),
                        SizedBox(
                          width: 1.h,
                        ),
                        PngIconsWithFun(
                          title: null,
                          image: 'assets/images/png/download.png',
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        ),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),
                  );
                })
    );
  }
}
