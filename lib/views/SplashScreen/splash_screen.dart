import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/view_model/services/splash_services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import '../../view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();


  @override
  void initState() {

   //model1.fetchProductsApi();
    Timer(const Duration(seconds: 3), () {
      splashServices.checkAuthentication(context);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
      children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/png/splash.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: Center(
                  child: Image.asset(
                    'assets/images/png/webhopers_logo2.png',
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                )),
      ],
    ));
  }
}
