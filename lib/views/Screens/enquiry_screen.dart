import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/equiry_entity.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/IconWithFun/svg_with_fun.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/view_model/enquiry_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../data/model/response_model/about_company/about_company_response_model.dart';
import '../../utils/TextInputFields/text_field.dart';

// ignore: must_be_immutable
class EnquiryScreen extends StatelessWidget {
  EnquiryScreen({Key? key,

    required this.value,

  }) : super(key: key);

  List<AboutCompany> value;

  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController message = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

  FocusNode emailFocusNode = FocusNode();

  FocusNode phoneFocusNode = FocusNode();

  FocusNode messageFocusNode = FocusNode();

  Future<void> sendCall(phone) async {

    StringBuffer sb = StringBuffer();

    if(phone != null){
      sb.write(phone
          .replaceAll(RegExp(r'\D'), '+91')
          .replaceAll(RegExp('91'), '+91')
          .replaceAll(RegExp('^0'), '+91'));
    }

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: sb.toString(),
    );

    await launchUrl(launchUri);
  }

  Future<void> sendEmail(email) async {

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Enquiry',
      }),
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch $url';
    }
  }

  sendWhatsapp(phone) async {

      var num = phone;
      var num1  = num[0]+num[1];
      String num2;

      try {
        if(num1 == '91'){
          num2 = num;
        }else {
          num2 = "91$phone";
        }
        final link = WhatsAppUnilink(
          phoneNumber: num2,
          text: "Hello",
        );
        // ignore: deprecated_member_use
        await launch('$link');
      }on Exception catch(_){
        if (kDebugMode) {
          print('not found');
        }
      }
    }

  @override
  Widget build(BuildContext context) {

    final enquiry = Provider.of<EnquiryViewModel>(context,listen: false);

    IconWidget(url, OnPress){
      return InkWell(
        onTap: OnPress,
        child: Image.asset(url,
          width: 6.h,
          height: 6.h,
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: TextWithStyle.appBarTitle(context, ConstantStrings.enquiry)
        ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h,bottom: 2.h,top: 1.h),
                child: TextWithStyle.containerTitle(context, "Ask Your Requirement.... "),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    TextInputField(
                      title: name,
                      node: nameFocusNode,
                      hintText: 'Enter your name',
                      labelText: 'Name',
                      icon: CupertinoIcons.person_alt,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    TextInputField(
                      title: email,
                      node: emailFocusNode,
                      hintText: 'Enter your Email',
                      labelText: 'Email',
                      icon: CupertinoIcons.mail_solid,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 18.sp),
                      controller: phone,
                      focusNode: phoneFocusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Phone';
                        } else if (value.length != 10) {
                          return 'Please Enter 10 digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            borderSide:
                            BorderSide(color: AppColors.primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.red.shade700)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.red.shade700)),
                        contentPadding: const EdgeInsets.fromLTRB(0,20,10,20),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Icon(CupertinoIcons.phone_fill ,size: 3.h,),
                        ),
                        hintText: 'Enter your phone number',
                        labelText: 'Phone',
                        //prefixIcon: Icon(Icons.alternate_email)
                      ),
                    ),
                    SizedBox(height: 1.5.h,),
                    TextInputField(
                      title: message,
                      node: messageFocusNode,
                      hintText: 'Enter your Message',
                      labelText: 'Message',
                      icon: CupertinoIcons.text_bubble_fill,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Message';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h,bottom: 2.h,top: 5.h),
                alignment: Alignment.bottomCenter,
                child: Consumer<EnquiryViewModel>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Button(
                        title: 'Submit',
                        loading: value.loading,
                        onPress: (){
                          final isValid = _formKey.currentState?.validate();
                          if (!isValid!) {
                            return;
                          }
                          EnquiryEntity entity = EnquiryEntity();
                          entity.name = name.text.toString();
                          entity.email = email.text.toString();
                          entity.phone = phone.text.toString();
                          entity.message = message.text.toString();

                          if(entity != null) {
                            enquiry.postEnquiry(entity, context, name, email, phone, message);
                          }
                        },
                    );
                  },
                ) ,
              ),
              SizedBox(height: 4.h,),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWithStyle.containerTitle(context, 'Connect With Us'),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIconsWithFun(
                          image: 'assets/images/svg/call.svg',
                          onPress: (){
                            String phone = value[0].phone!;
                            sendCall(phone);
                          }, title: null,
                        ),
                        SizedBox(width: 1.h,),
                        IconWidget(
                            'assets/images/png/whatsapp.png',
                              (){
                            String phone = value[0].whatsapp!;
                            sendWhatsapp(phone);
                          },),
                        SizedBox(width: 1.h,),
                        IconWidget(
                          'assets/images/png/email.png',
                              (){
                                String email = value[0].email!;
                                sendEmail(email);
                          },),
                        // SvgIconsWithFun(
                        //   image: 'assets/images/svg/email.svg',
                        //   onPress: (){
                        //     String email = value[0].email!;
                        //     sendEmail(email);
                        //   }, title: null,
                        // ),
                        SizedBox(width: 1.h,),
                        SvgIconsWithFun(
                          image: 'assets/images/svg/web.svg',
                          onPress: (){
                            Uri url = Uri.parse(value[0].website!);
                            _launchUrl(url);
                          },
                          title: null,
                        ),
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
      )
    );
  }
}
