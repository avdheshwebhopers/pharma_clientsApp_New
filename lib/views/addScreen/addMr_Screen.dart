import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/addMr_entity.dart';
import 'package:pharma_clients_app/utils/TextInputFields/password_inputField.dart';
import 'package:pharma_clients_app/utils/TextInputFields/text_field.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/button.dart';
import '../../utils/text_style.dart';

class AddMrScreen extends StatefulWidget {
  const AddMrScreen({Key? key}) : super(key: key);

  @override
  State<AddMrScreen> createState() => _AddMrScreenState();
}

class _AddMrScreenState extends State<AddMrScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureConfirmPassword = ValueNotifier<bool>(true);

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController operationArea = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode operationAreaFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  StatesViewModel stateModel = StatesViewModel();
  CitiesViewModel citiesModel = CitiesViewModel();

  var currentTime = '${DateTime.now().hour + DateTime.now().second}';
  DateTime selectedTime = DateTime.now();

  Future<void> _selectDate(BuildContext context, date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedTime,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        currentTime = DateFormat.yMMMd().format(selectedTime);
        date.text = currentTime;
      });
    }
  }

  String? newState;
  var state;
  var city;
  String? newCity;
  int _selectedCityIndex = 0;

  @override
  void initState() {
    stateModel.states(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AddMrViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: TextWithStyle.appBarTitle(context, ConstantStrings.addMrheading),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(CupertinoIcons.chevron_left)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
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
                      icon: CupertinoIcons.person,
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
                      icon: CupertinoIcons.mail,
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
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.red.shade700)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.red.shade700)),
                        contentPadding: const EdgeInsets.all(20),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Icon(CupertinoIcons.phone_fill,size: 3.h,),
                        ),
                        hintText: 'Enter your phone number',
                        labelText: 'Phone',
                        //prefixIcon: Icon(Icons.alternate_email)
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextInputField(
                      title: address,
                      node: addressFocusNode,
                      hintText: 'Enter your Address',
                      labelText: 'Address',
                      icon: CupertinoIcons.location_solid,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Address';
                        }
                        return null;
                      },
                    ),
                    ChangeNotifierProvider<StatesViewModel>(
                        create: (BuildContext context) => stateModel,
                        child: Consumer<StatesViewModel>(
                          builder: (BuildContext context, value,
                              Widget? child) {
                            return DropdownButtonFormField(
                              value: state,
                              elevation: 8,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(2.h)),
                              menuMaxHeight: 40.h,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Icons.add_home_work_sharp,
                                    size: 3.h,
                                  ),
                                ),
                                contentPadding:
                                const EdgeInsets.fromLTRB(
                                    0, 20, 20, 20),
                                hintText: 'Enter your State',
                                labelText: 'State',
                                labelStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                              items: value.state
                                  .map<DropdownMenuItem>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          1.8,
                                      child: Text(
                                        value.name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),
                                );
                              }).toList(),
                              onChanged: (value) {
                                state = value;
                                citiesModel.cities(
                                    state.id, context);
                              },

                            );
                          },
                        )
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ChangeNotifierProvider<CitiesViewModel>(
                        create: (BuildContext context) => citiesModel,
                        child: Consumer<CitiesViewModel>(
                          builder: (BuildContext context, value,
                              Widget? child) {
                            return DropdownButtonFormField(
                              value: value.city.isEmpty
                                  ? 'NA'
                                  : value.city[_selectedCityIndex],
                              elevation: 8,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(2.h)),
                              menuMaxHeight: 40.h,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.red.shade700)),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    CupertinoIcons.house_alt_fill,
                                    size: 3.h,
                                  ),
                                ),
                                contentPadding:
                                const EdgeInsets.fromLTRB(
                                    0, 20, 20, 20),
                                hintText: 'Enter your Cities',
                                labelText: 'Cities',
                                labelStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                              items: value.city
                                  .map<DropdownMenuItem>((val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          1.8,
                                      child: Text(
                                        val,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),
                                );
                              }).toList(),
                              onChanged: (val) {
                                city = val;
                              },
                            );
                          },
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                    PasswordInputField(
                      title: dob,
                      node: dobFocusNode,
                      obSecure: false,
                      icon: Icons.person_pin_outlined,
                      hintText: 'Enter your Date of Birth ',
                      labelText: 'D.O.B',
                      suffixIcon: InkWell(
                          onTap: () {
                            _selectDate(context, dob);
                          },
                          child: const Icon(Icons.date_range)),
                    ),
                    TextInputField(
                      title: operationArea,
                      node: operationAreaFocusNode,
                      hintText: 'Enter your Operation Area',
                      labelText: 'Operation Area',
                      icon: Icons.add_home_work_outlined,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Operation Area';
                        }
                        return null;
                      },
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
                            icon: Icons.lock_open_rounded,
                            suffixIcon: InkWell(
                                onTap: () {
                                  _obsecurePassword.value =
                                      !_obsecurePassword.value;
                                },
                                child: Icon(_obsecurePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Password';
                              } else if (value!.length != 6) {
                                return 'Please enter 6 Digits Password';
                              }
                              return null;
                            },
                          );
                        }),
                    ValueListenableBuilder(
                        valueListenable: _obsecureConfirmPassword,
                        builder: (context, value, child) {
                          return PasswordInputField(
                            title: confirmPassword,
                            node: confirmPasswordFocusNode,
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            icon: Icons.lock_outline_rounded,
                            obSecure: _obsecureConfirmPassword.value,
                            suffixIcon: InkWell(
                                onTap: () {
                                  _obsecureConfirmPassword.value =
                                      !_obsecureConfirmPassword.value;
                                },
                                child: Icon(_obsecureConfirmPassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Confirm Password';
                              } else if (password.text !=
                                  confirmPassword.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Consumer<AddMrViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return Button(
                    title: "Add MR",
                    onPress: () {
                      final isValid = _formKey.currentState?.validate();
                      if (!isValid!) {
                        return;
                      }

                      AddMrEntity entity = AddMrEntity();
                      entity.name = name.text;
                      entity.email = email.text;
                      entity.phone = phone.text;
                      entity.address = address.text;
                      entity.state = state == null ? 'NA' : state.name.toString();
                      entity.city = city.toString().isEmpty ? 'NA' : city.toString();
                      entity.op_area = operationArea.text;
                      entity.dob = dob.text.toString().isEmpty ? '' : dob.text.toString();
                      entity.password = confirmPassword.text;

                      provider.addMr(
                          entity,
                          context,
                          name,
                          email,
                          phone,
                          address,
                          operationArea,
                          dob,
                          password,
                          confirmPassword);
                    },
                    loading: value.loading,
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
