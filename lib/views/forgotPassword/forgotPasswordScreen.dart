import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/forgotPassword/profileSearchEntity.dart';
import 'package:pharma_clients_app/utils/TextInputFields/text_field.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/utils/text_style.dart';
import 'package:pharma_clients_app/view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();

  final emailController = TextEditingController();

  bool _isProgress = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //entity = ForgotPasswordEntity();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProfileSearchViewModel>(context);

    // void forgotPasswordApi() async {
    //   setState(() {
    //     _isProgress = true;
    //   });
    //   try {
    //     final response = await _helper.post(AppUrl.forgotPassword, entity);
    //     if (response['success']) {
    //       var data = ForgotPasswordResponse.fromJson(response).data;
    //       print(data);
    //
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => OtpScreen(
    //               id: ForgotPassword.fromJson(data).id,
    //               email: ForgotPassword.fromJson(data).email),
    //         ),
    //       );
    //     } else
    //       showErrorDialog(context, response, 'Forgot Password');
    //
    //     setState(() {
    //       _isProgress = false;
    //     });
    //   } catch (e) {
    //     setState(() {
    //       _isProgress = false;
    //     });
    //     return successMessageDialog(context, e.toString(), 'Forgot Password');
    //   }
    // }

    forgotLabel() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextWithStyle.appBarTitle(context, 'Forgot Password ?')
          ),
          Image.asset(
            'assets/images/png/ic_forgot_password.png',
            width: 8.h,
            height: 8.h,
            fit: BoxFit.cover,
          ),
        ],
      );
    }

    forgotDescription() {
      return Text(
        'Enter your company email below to \nreceive your password reset instructions.',
        style: TextStyle(
            fontSize: 16.sp,),
        textAlign: TextAlign.start,
        maxLines: 2,
      );
    }

    final emailField = TextInputField(
      title: emailController,
      node: _emailFocus,
      hintText: 'Enter Your Email Address',
      labelText: 'Email',
      icon: CupertinoIcons.mail_solid,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );

    final forgotButton = Button(
      title: 'Send',
      onPress: (){

        final isValid = _formKey.currentState!.validate();
        if (!isValid) {
          return;
        }
        ProfileSearchEntity entity = ProfileSearchEntity();
        entity.email = emailController.text;
        provider.getProfile(entity, context);

        // _formKey.currentState!.save();

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context)=> OtpScreen(id: '', email: 'avdheshgupta754@gmail.com',)));

      }, loading: false,
    );

    _signInWidget() {
      if (_isProgress) {
        return const CircularProgressIndicator();
      } else {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    forgotLabel(),
                    SizedBox(
                      height: 2.h,
                    ),
                    forgotDescription(),
                    SizedBox(
                      height: 4.h,
                    ),
                    emailField,
                  ],
                ),
              ),
              provider.loading ? const CircularProgressIndicator() : forgotButton,
            ],
          ),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottomOpacity: 0,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                 // color: ColorFile.hint_color,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white])),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: _signInWidget(),
        ),
      ),
    );
  }
}
