import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/login_entity.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:pharma_clients_app/utils/TextInputFields/password_inputField.dart';
import 'package:pharma_clients_app/utils/TextInputFields/text_field.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/view_model/login_viewmodel.dart';
import 'package:pharma_clients_app/views/forgotPassword/forgotPasswordScreen.dart';
import 'package:pharma_clients_app/views/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../resources/constant_strings.dart';
import '../view_model/services/splash_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final SplashServices splashServices = SplashServices();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  String? token;

  @override
  void initState() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    () async {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('User granted permission');
        }
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('User granted provisional permission');
        }
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted permission');
        }
      }

      messaging.getToken().then((value) {
        token = value;

        if (kDebugMode) {
          print('FCM TOKEN>>>>>>: ${value!}');
        }

      });
    }();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
      ),
    );

    final authviewmodel = Provider.of<LoginViewModel>(context, listen: false);

    return WillPopScope(
        onWillPop: () async {
          splashServices.checkAuthentication(context);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            iconTheme: IconThemeData(color: Colors.white), //
            actions: [

            ],
          ),
          body: Container(
              color: AppColors.primaryColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(ConstantStrings.login,
                            style: GoogleFonts.workSans(
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      padding:
                          EdgeInsets.only(left: 5.h, top: 10.h, right: 5.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.h),
                              topRight: Radius.circular(5.h))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextInputField(
                            title: email,
                            node: emailFocusNode,
                            hintText: 'Enter email or mobile number',
                            labelText: 'Email',
                            icon: CupertinoIcons.person_alt,
                          ),
                          ValueListenableBuilder(
                              valueListenable: _obsecurePassword,
                              builder: (context, value, child) {
                                return PasswordInputField(
                                  title: password,
                                  node: passwordFocusNode,
                                  obSecure: _obsecurePassword.value,
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  icon: CupertinoIcons.padlock_solid,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        _obsecurePassword.value =
                                            !_obsecurePassword.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Icon(_obsecurePassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,size: 3.h,),
                                      )),
                                );
                              }),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()
                                    ));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                        Consumer<LoginViewModel>(
                                builder: (BuildContext context, value, Widget? child) {
                                  return Button(
                                    title: 'Login',
                                    loading: value.loading,
                                    onPress: () {
                                      if (email.text.isEmpty) {
                                        Utils.flushBarErrorMessage(
                                            'Please enter Email', context);
                                      } else if (password.text.isEmpty) {
                                        Utils.flushBarErrorMessage(
                                            'Please enter Password', context);
                                      } else {
                                        LoginEntity entity = LoginEntity();
                                        entity.email = email.text.toString();
                                        entity.password =
                                            password.text.toString();
                                        entity.deviceToken = token ?? "abed12345";
                                        if (entity != null) {
                                          authviewmodel.login(entity, context);
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                          SizedBox(
                            height: 3.h,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RegisterScreen()));
                            },
                            child: Text(
                              'Register As a Distributors',
                              style: GoogleFonts.poppins(
                                  color: AppColors.primaryColor,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600),
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
