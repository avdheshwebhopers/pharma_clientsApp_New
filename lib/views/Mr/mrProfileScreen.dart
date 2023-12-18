import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/update_MrEntity.dart';
import 'package:pharma_clients_app/data/model/response_model/mrs/mrs_responseModel.dart';
import 'package:pharma_clients_app/data/repository/afterLogin/afterLogin_repository.dart';
import 'package:pharma_clients_app/data/response/api_response.dart';
import 'package:pharma_clients_app/resources/app_urls.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/views/Screens/customersOrderScreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/profile_container.dart';
import '../../utils/text_style.dart';
import '../visits_screen.dart';
import 'ResetMrPassword.dart';

class MrProfileScreen extends StatefulWidget {
  MrProfileScreen({

    required this.profile,

    Key? key}) : super(key: key);

  List<Mrs> profile;

  @override
  State<MrProfileScreen> createState() => _MrProfileScreenState();
}

class _MrProfileScreenState extends State<MrProfileScreen> {

  final bool _isProgress = false;
  bool _isEnable = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _operatingAreaFocus = FocusNode();
  MrsViewModel status = MrsViewModel();

  // of the TextField.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();
  final operatingAreaController = TextEditingController();


  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    nameController.text = widget.profile[0].name!;
    emailController.text = widget.profile[0].email!;
    phoneController.text = widget.profile[0].phone!;
    addressController.text = widget.profile[0].address!;
    dobController.text = widget.profile[0].dob!;
    operatingAreaController.text = widget.profile[0].opArea!;
    status.setColor(widget.profile[0].active!);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    widget.profile.clear();
    status.color == null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final update = Provider.of<UpdateMrViewModel>(context,listen: false);
    final status = Provider.of<MrsViewModel>(context,listen: false);

    status.setColor(widget.profile[0].active!);

    final emailField = TextFormField(
      obscureText: false,
      enabled: _isEnable,
      style: TextStyle(
        color: AppColors.mrcontaonerheading,
        fontSize: 17.sp,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _emailFocus, _phoneFocus);
      },
      onChanged: (value) {
        setState(() {
          _formKey.currentState?.validate();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      controller: emailController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15,right: 10),
        labelText: 'Email',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        )
      ),
    );

    final phoneField = TextFormField(
      obscureText: false,
      enabled: _isEnable,
      style: TextStyle(
        fontSize: 16.sp,
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      focusNode: _phoneFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _phoneFocus, _addressFocus);
      },
      onChanged: (value) {
        setState(() {
          _formKey.currentState?.validate();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
      controller: phoneController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15,right: 10),
        labelText: 'Phone',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
            color: Colors.black45,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          )
      ),
    );

    final addressField = TextFormField(
      obscureText: false,
      enabled: _isEnable,
      style: TextStyle(
        fontSize: 17.sp,
      ),
      keyboardType: TextInputType.streetAddress,
      textInputAction: TextInputAction.next,
      focusNode: _addressFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _addressFocus, _dobFocus);
      },
      onChanged: (value) {
        setState(() {
          _formKey.currentState?.validate();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your address';
        }
        return null;
      },
      controller: addressController,
      decoration: InputDecoration(
        contentPadding:  const EdgeInsets.only(left: 15,right: 10),
        labelText: 'Address :',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          )
      ),
    );

    final dobirthField = TextFormField(
      obscureText: false,
      enabled: _isEnable,
      style: TextStyle(
        //color: ColorFile.text_color,
        fontSize: 16.sp,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _dobFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _dobFocus, _operatingAreaFocus);
      },
      onChanged: (value) {
        setState(() {
          _formKey.currentState?.validate();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your DOB';
        }
        return null;
      },
      controller: dobController,
      decoration: InputDecoration(
        contentPadding:  const EdgeInsets.only(left: 15,right: 10),
        labelText: 'DOB',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
            //color: ColorFile.hint_color,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),

        ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          )
      ),
    );

    final operatingAreaField = TextFormField(
      obscureText: false,
      enabled: _isEnable,
      style: TextStyle(
        //color: ColorFile.text_color,
        fontSize: 17.sp,
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      focusNode: _operatingAreaFocus,
      onFieldSubmitted: (term) {
        _operatingAreaFocus.unfocus();
      },
      onChanged: (value) {
        setState(() {
          _formKey.currentState?.validate();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter operating area';
        }
        return null;
      },
      controller: operatingAreaController,
      decoration: InputDecoration(
        contentPadding:  const EdgeInsets.only(left: 15,right: 10),
        labelText: 'Operating Area',
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
            //color: ColorFile.hint_color,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:AppColors.primaryColor),

        ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          )
      ),
    );

    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 7.h,
      title: TextWithStyle.appBarTitle(context, ConstantStrings.mrsprofileheading),
        actions: [
        IconButton(
          icon: Icon(!_isEnable ? Icons.edit : CupertinoIcons.checkmark_alt_circle_fill),
          iconSize: 3.5.h,
          color:  AppColors.primaryColor,
          onPressed: () {
            setState(() {
              _isEnable = !_isEnable;
              if (!_isEnable) {
                final isValid = _formKey.currentState?.validate();
                if (!isValid!) {
                  return;
                }
                _formKey.currentState?.save();
                UpdateMrEntity entity = UpdateMrEntity();
                entity.id = widget.profile[0].id;
                entity.name = widget.profile[0].name;
                entity.email = emailController.text;
                entity.phone = phoneController.text;
                entity.address = addressController.text;
                entity.dob = dobController.text;
                entity.opArea = operatingAreaController.text;
                update.updateMrs(entity, context);
              }
            });
          },
        ),
        // IconButton(
        //   icon: const Icon(Icons.delete),
        //   color: AppColors.primaryColor,
        //   onPressed: () {
        //     // Utils.confirmationDialogue(
        //     //     'Are you sure you want to delete ${widget.profile[0].name}',
        //     //         (){
        //     //           delete.deleteMrs(widget.profile[0].id, context);
        //     //         },context);
        //   },
        // ),
        const SizedBox(width: 10,)
      ],
    ),
      body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 2.h,right: 2.h,bottom: 1.h,top: 1.h),
              padding: EdgeInsets.only(left: 3.h,right: 3.h,bottom: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                  )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 2.h,),
                      CircleAvatar(
                        radius: 4.h,
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.brown.withOpacity(0.5),
                        child: Text(
                          widget.profile[0].name!.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight:
                              FontWeight.w600),
                        ), // setting it true will show initials text above profile picture, default false
                      ),
                      SizedBox(width: 3.h,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWithStyle.appBarTitle(context, widget.profile[0].name!),
                          Consumer<MrsViewModel>(
                            builder: (BuildContext context, value, Widget? child) {
                              //print(value.color);
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: value.color != true
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(2.h))
                                    )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(1.h),
                                  child: Text(
                                    value.color == true
                                        ? "Deactivate"
                                        : "Activate",
                                    style: GoogleFonts.workSans(
                                        color: Colors.white,
                                        textStyle: Theme.of(context).textTheme.bodyMedium,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w400
                                    ),),
                                ),
                                onPressed: (){
                                  status.statusMr(value.color == true
                                      ? '${AppUrls.deactivateMR}/${widget.profile[0].id}'
                                      : '${AppUrls.activateMR}/${widget.profile[0].id}'
                                      , context);

                                },);
                            },
                          )
                        ],
                      )
                    ],),
                  SizedBox(height: 3.h,),
                  emailField,
                  SizedBox(height: 1.h,),
                  phoneField,
                  SizedBox(height: 1.h,),
                  operatingAreaField,
                  SizedBox(height: 1.h,),
                  dobirthField,
                  SizedBox(height: 1.h,),
                  addressField,
                ],
              ),
            ),
            ProfileContainer(
              onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomersOrderScreen(repId: widget.profile[0].id)));
              },
              title: 'View Orders',
              image: 'assets/images/svg/viewOrders.svg',
            ),
            ProfileContainer(
              onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> VisitsScreen(repId: widget.profile[0].id)));
              },
              title: 'View Visits',
              image: 'assets/images/svg/viewVisits.svg',
            ),
            ProfileContainer(
              onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetMrPasswordScreen(id: widget.profile[0].id)));
              },
              title: 'Reset Password',
              image: 'assets/images/svg/resetPassword.svg',
            ),
          ],
        ),
      ),
    ),
    );
  }
}
