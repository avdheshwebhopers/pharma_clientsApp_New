import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/forgotPassword/otpVerificationEntity.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/requested_data_model/forgotPassword/profileSearchEntity.dart';
import '../../utils/button.dart';
import '../../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';

/*
todo Created By Anuj Kamboj
 */
class OtpScreen extends StatefulWidget {
  OtpScreen({
    required this.id,
    required this.email,
  });

  final String id;
  final String email;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  int _start = 120;
  String time = '';
  bool isResend = false;
  Color color = Colors.black;

  @override
  void initState() {
    getTime();
    super.initState();
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void getTime() {
    isResend = false;
    _start = 120;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            isResend = true;
            color = AppColors.primaryColor;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            final duration = Duration(seconds: _start);
            time = format(duration);
          });
        }
      },
    );
  }

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  FocusNode otpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProfileSearchViewModel>(context, listen: false);
    final otpVerify = Provider.of<OtpVerifyViewModel>(context, listen: false);

    descriptionLabel() {
      return InkWell(
        onTap: () {},
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter the verification code send to',
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              SizedBox(height: 1.h,),
              Text(
                widget.email == '' ? 'NA' : widget.email,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      );
    }

    final submitButton = Consumer<OtpVerifyViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Button(
          title: 'Submit',
          onPress: (){
            String otp = (_fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text);
            OtpVerificationEntity entity = OtpVerificationEntity();
            entity.id = widget.id;
            entity.otp = otp;
            otpVerify.verifyOtp(entity, context);
          }, loading: value.loading,
        );
      },
    );

    otpWidgetsFields() {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5.h,),
              descriptionLabel(),
              SizedBox(height: 4.h,),
              TextWithStyle.customerName(context, time),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: EdgeInsets.all(4.h),
                padding: EdgeInsets.all(3.h),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(
                          0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpInput(_fieldOne, true), // auto focus
                        OtpInput(_fieldTwo, true),
                        OtpInput(_fieldThree, true),
                        OtpInput(_fieldFour, true)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: otpVerify.loading
                        ? const CircularProgressIndicator()
                        : submitButton),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'If you didn\'t receive a code ?',
                  ),
                  const SizedBox(width: 10.0),
                  InkWell(
                    onTap: () {
                      ProfileSearchEntity entity = ProfileSearchEntity();
                      entity.email = widget.email;
                      provider.resendOtp(entity, context);
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                          color: color, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: TextWithStyle.appBarTitle(context, 'Verification'),
        elevation: 0,
      ),
      body: otpWidgetsFields(),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        style: TextStyle(fontSize: 18.sp),
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 18.sp)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}