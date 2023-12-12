import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:pharma_clients_app/view_model/beforeLogin_viewModels/beforeLogin_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../data/model/requested_data_model/register_entity.dart';
import '../data/response/status.dart';
import '../resources/app_colors.dart';
import '../resources/constant_strings.dart';
import '../utils/Dialogue/error_dialogue.dart';
import '../utils/TextInputFields/password_inputField.dart';
import '../utils/TextInputFields/text_field.dart';
import '../utils/button.dart';
import '../utils/text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureConfirmPassword =
      ValueNotifier<bool>(true);

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController operationArea = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firmName = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController drugLicense = TextEditingController();
  TextEditingController aadhaarNumber = TextEditingController();
  TextEditingController firmPhone = TextEditingController();
  TextEditingController firmEmail = TextEditingController();
  TextEditingController firmAddress = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController payeeName = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode operationAreaFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode firmNameFocus = FocusNode();
  FocusNode gstNumberFocus = FocusNode();
  FocusNode drugLicenseFocus = FocusNode();
  FocusNode aadhaarNumberFocus = FocusNode();
  FocusNode firmPhoneFocus = FocusNode();
  FocusNode firmEmailFocus = FocusNode();
  FocusNode firmAddressFocus = FocusNode();
  FocusNode firmStateFocus = FocusNode();
  FocusNode firmCityFocus = FocusNode();
  FocusNode bankNameFocus = FocusNode();
  FocusNode ifscCodeFocus = FocusNode();
  FocusNode accountNumberFocus = FocusNode();
  FocusNode payeeNameFocus = FocusNode();
  FocusNode divisionFocus = FocusNode();

  StatesViewModel stateModel = StatesViewModel();
  CitiesViewModel citiesModel = CitiesViewModel();
  FirmCitiesViewModel firmCities = FirmCitiesViewModel();

  final List<Division> divisions = [];
  var state;
  var firmState;
  var city;
  var firmCity;
  final int _selectedCityIndex = 0;
  int cityindex = 0;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  var currentTime = '${DateTime.now().hour + DateTime.now().second}';
  DateTime selectedTime = DateTime.now();

  Future<void> _selectDate(BuildContext context, date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedTime,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      currentTime = DateFormat.yMMMd().format(selectedTime);
      date.text = currentTime;
    }
  }

  AboutCompanyViewModel model = AboutCompanyViewModel();

  @override
  void initState() {
    model.fetchAboutCompany();
    stateModel.states(context);
    city == null;
    divisions.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    divisions.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DivisionProvider>(context, listen: false);
    final register = Provider.of<RegisterViewModel>(context, listen: false);
    provider._selectedDivisions.clear();

    return Scaffold(
      appBar: AppBar(
        title:
            TextWithStyle.appBarTitle(context, ConstantStrings.registerHeading),
        elevation: 0,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<AboutCompanyViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<AboutCompanyViewModel>(
            builder: (BuildContext context, value, _) {
          switch (value.aboutCompany.status!) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              if (kDebugMode) {
                print(value.aboutCompany.message.toString());
              }
              return ErrorDialogue(
                message: value.aboutCompany.message.toString(),
              );
            case Status.completed:
              for (var element
                  in value.aboutCompany.data!.data!.downloadLinks!) {
                divisions.add(Division(
                    id: element.divisionId!, name: element.divisionName!));
              }
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 2.h, bottom: 2.h, top: 1.h),
                        alignment: Alignment.centerLeft,
                        child: TextWithStyle.containerTitle(
                            context, ConstantStrings.distributorDetails),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
                        padding: EdgeInsets.all(2.h),
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
                              icon: CupertinoIcons.person_fill,
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
                                } else if (validateEmail(value) != null) {
                                  return 'Please enter valid Email';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: phone,
                              style: TextStyle(fontSize: 18.sp),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.red.shade700)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    borderSide:
                                        BorderSide(color: Colors.red.shade700)),
                                contentPadding: const EdgeInsets.all(20),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  CupertinoIcons.device_phone_portrait,
                                  size: 3.h,
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
                            ),
                            // ChangeNotifierProvider<StatesViewModel>(
                            //     create: (BuildContext context) => stateModel,
                            //     child: Consumer<StatesViewModel>(
                            //       builder: (BuildContext context, value,
                            //           Widget? child) {
                            //         return DropdownButtonFormField(
                            //           value: state,
                            //           elevation: 8,
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(2.h)),
                            //           menuMaxHeight: 40.h,
                            //           style: TextStyle(
                            //             fontSize: 18.sp,
                            //             color: Colors.black,
                            //           ),
                            //           decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             focusedBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             errorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             focusedErrorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             border: InputBorder.none,
                            //             prefixIcon: Padding(
                            //               padding: EdgeInsets.all(2.w),
                            //               child: Icon(
                            //                 Icons.add_home_work_sharp,
                            //                 size: 3.h,
                            //               ),
                            //             ),
                            //             contentPadding:
                            //                 const EdgeInsets.fromLTRB(
                            //                     0, 20, 20, 20),
                            //             hintText: 'Enter your State',
                            //             labelText: 'State',
                            //             labelStyle: TextStyle(
                            //               fontSize: 18.sp,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           items: value.state
                            //               .map<DropdownMenuItem>((value) {
                            //             return DropdownMenuItem(
                            //               value: value,
                            //               child: SizedBox(
                            //                   width: MediaQuery.of(context)
                            //                           .size
                            //                           .width /
                            //                       1.8,
                            //                   child: Text(
                            //                     value.name!,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     maxLines: 2,
                            //                   )),
                            //             );
                            //           }).toList(),
                            //           onChanged: (value) {
                            //             state = value;
                            //             citiesModel.cities(
                            //                 state.id, context);
                            //           },
                            //           validator: (value) {
                            //             if (state == null) {
                            //               return 'Please enter your State';
                            //             }
                            //             return null;
                            //           },
                            //         );
                            //       },
                            //     )
                            // ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // ChangeNotifierProvider<CitiesViewModel>(
                            //     create: (BuildContext context) => citiesModel,
                            //     child: Consumer<CitiesViewModel>(
                            //       builder: (BuildContext context, value,
                            //           Widget? child) {
                            //         return DropdownButtonFormField(
                            //           value: value.city.isEmpty
                            //               ? 'NA'
                            //               : value.city[_selectedCityIndex],
                            //           elevation: 8,
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(2.h)),
                            //           menuMaxHeight: 40.h,
                            //           style: TextStyle(
                            //             fontSize: 18.sp,
                            //             color: Colors.black,
                            //           ),
                            //           decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             focusedBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             errorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             focusedErrorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     const BorderRadius.all(
                            //                         Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             border: InputBorder.none,
                            //             prefixIcon: Padding(
                            //               padding: EdgeInsets.all(2.w),
                            //               child: Icon(
                            //                 CupertinoIcons.house_alt_fill,
                            //                 size: 3.h,
                            //               ),
                            //             ),
                            //             contentPadding:
                            //                 const EdgeInsets.fromLTRB(
                            //                     0, 20, 20, 20),
                            //             hintText: 'Enter your Cities',
                            //             labelText: 'Cities',
                            //             labelStyle: TextStyle(
                            //               fontSize: 18.sp,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           items: value.city
                            //               .map<DropdownMenuItem>((val) {
                            //             return DropdownMenuItem(
                            //               value: val,
                            //               child: SizedBox(
                            //                   width: MediaQuery.of(context)
                            //                           .size
                            //                           .width /
                            //                       1.8,
                            //                   child: Text(
                            //                     val,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     maxLines: 2,
                            //                   )),
                            //             );
                            //           }).toList(),
                            //           onChanged: (val) {
                            //             city = val;
                            //           },
                            //           validator: (val) {
                            //             if (city == null) {
                            //               return 'Please enter your City';
                            //             }
                            //             return null;
                            //           },
                            //         );
                            //       },
                            //     )),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // PasswordInputField(
                            //   title: dob,
                            //   node: dobFocusNode,
                            //   obSecure: false,
                            //   hintText: 'Enter your Date of Birth',
                            //   labelText: 'D.O.B',
                            //   icon: CupertinoIcons.calendar_today,
                            //   suffixIcon: InkWell(
                            //       onTap: () async {
                            //         _selectDate(context, dob);
                            //       },
                            //       child: const Icon(Icons.date_range)),
                            // ),
                            // // TextInputField(
                            // //   title: operationArea,
                            // //   node: operationAreaFocusNode,
                            // //   hintText: 'Enter your Operation Area',
                            // //   labelText: 'Operation Area',
                            // //   icon: CupertinoIcons.briefcase_fill,
                            // // ),
                            ValueListenableBuilder(
                                valueListenable: _obsecurePassword,
                                builder: (context, value, child) {
                                  return PasswordInputField(
                                    title: password,
                                    node: passwordFocusNode,
                                    obSecure: _obsecurePassword.value,
                                    hintText: 'Password',
                                    labelText: 'Password',
                                    icon: Icons.lock_person,
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
                                    icon: Icons.lock,
                                    obSecure: _obsecureConfirmPassword.value,
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          _obsecureConfirmPassword.value =
                                              !_obsecureConfirmPassword.value;
                                        },
                                        child: Icon(
                                            _obsecureConfirmPassword.value
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
                        height: 2.h,
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 2.h, bottom: 2.h, top: 1.h),
                        alignment: Alignment.centerLeft,
                        child: TextWithStyle.containerTitle(
                            context, ConstantStrings.firmDetails),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: 1.5.h, right: 1.5.h, bottom: 4.h),
                        padding: EdgeInsets.all(2.h),
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
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            TextInputField(
                              title: firmName,
                              node: firmNameFocus,
                              hintText: 'Enter your Firm Name',
                              labelText: 'Firm Name',
                              icon: Icons.house_sharp,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Firm Name';
                                }
                                return null;
                              },
                            ),
                            // TextInputField(
                            //   title: gstNumber,
                            //   node: gstNumberFocus,
                            //   hintText: 'Enter your Gst Number',
                            //   labelText: 'Gst Number',
                            //   icon: CupertinoIcons.doc_text_fill,
                            // ),
                            // TextInputField(
                            //   title: drugLicense,
                            //   node: drugLicenseFocus,
                            //   hintText: 'Enter your DrugLicense',
                            //   labelText: 'DrugLicense',
                            //   icon: CupertinoIcons.doc_plaintext,
                            //
                            // ),
                            // TextInputField(
                            //   title: aadhaarNumber,
                            //   node: aadhaarNumberFocus,
                            //   hintText: 'Enter your Aadhaar Number',
                            //   labelText: 'Aadhaar Number',
                            //   icon: CupertinoIcons.creditcard_fill,
                            //
                            // ),
                            // TextInputField(
                            //   title: firmEmail,
                            //   node: firmEmailFocus,
                            //   hintText: 'Enter your Firm Email',
                            //   labelText: 'Firm Email',
                            //   icon: CupertinoIcons.mail,
                            // ),
                            // TextFormField(
                            //   style: TextStyle(fontSize: 18.sp),
                            //   controller: firmPhone,
                            //   focusNode: firmPhoneFocus,
                            //   keyboardType: TextInputType.number,
                            //   inputFormatters: <TextInputFormatter>[
                            //     FilteringTextInputFormatter.digitsOnly,
                            //     LengthLimitingTextInputFormatter(10),
                            //   ],
                            //
                            //   decoration: InputDecoration(
                            //     enabledBorder: OutlineInputBorder(
                            //         borderRadius: const BorderRadius.all(
                            //             Radius.circular(20)),
                            //         borderSide: BorderSide(
                            //             color: AppColors.primaryColor)),
                            //     focusedBorder: OutlineInputBorder(
                            //         borderRadius: const BorderRadius.all(
                            //             Radius.circular(20)),
                            //         borderSide: BorderSide(
                            //             color: AppColors.primaryColor)),
                            //     errorBorder: OutlineInputBorder(
                            //         borderRadius: const BorderRadius.all(
                            //             Radius.circular(20)),
                            //         borderSide:
                            //             BorderSide(color: Colors.red.shade700)),
                            //     focusedErrorBorder: OutlineInputBorder(
                            //         borderRadius: const BorderRadius.all(
                            //             Radius.circular(20)),
                            //         borderSide:
                            //             BorderSide(color: Colors.red.shade700)),
                            //     contentPadding: const EdgeInsets.all(20),
                            //     border: InputBorder.none,
                            //     prefixIcon: const Icon(
                            //         CupertinoIcons.device_phone_portrait),
                            //     hintText: 'Enter your Firm number',
                            //     labelText: 'Firm Phone',
                            //     //prefixIcon: Icon(Icons.alternate_email)
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // TextInputField(
                            //   title: firmAddress,
                            //   node: firmAddressFocus,
                            //   hintText: 'Enter your Firm Address',
                            //   labelText: 'Firm Address',
                            //   icon: CupertinoIcons.location_solid,
                            //
                            // ),
                            // ChangeNotifierProvider<StatesViewModel>(
                            //     create: (BuildContext context) => stateModel,
                            //     child: Consumer<StatesViewModel>(
                            //       builder: (BuildContext context, value,
                            //           Widget? child) {
                            //         return DropdownButtonFormField(
                            //           value: firmState,
                            //           elevation: 8,
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(2.h)),
                            //           menuMaxHeight: 40.h,
                            //           style: TextStyle(
                            //             fontSize: 18.sp,
                            //             color: Colors.black,
                            //           ),
                            //           decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             focusedBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             errorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             focusedErrorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             border: InputBorder.none,
                            //             prefixIcon: Padding(
                            //               padding: EdgeInsets.all(2.w),
                            //               child: Icon(
                            //                 Icons.add_home_work_sharp,
                            //                 size: 3.h,
                            //               ),
                            //             ),
                            //             contentPadding:
                            //             const EdgeInsets.fromLTRB(
                            //                 0, 20, 20, 20),
                            //             hintText: 'Enter your State',
                            //             labelText: 'State',
                            //             labelStyle: TextStyle(
                            //               fontSize: 18.sp,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           items: value.state
                            //               .map<DropdownMenuItem>((value) {
                            //             return DropdownMenuItem(
                            //               value: value,
                            //               child: SizedBox(
                            //                   width: MediaQuery.of(context)
                            //                       .size
                            //                       .width /
                            //                       1.8,
                            //                   child: Text(
                            //                     value.name!,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     maxLines: 2,
                            //                   )),
                            //             );
                            //           }).toList(),
                            //           onChanged: (value) {
                            //             firmState = value;
                            //             firmCities.cities(firmState.id, context);
                            //           },
                            //           validator: (value) {
                            //             if (firmState == null) {
                            //               return 'Please enter your State';
                            //             }
                            //             return null;
                            //           },
                            //         );
                            //       },
                            //     )),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // ChangeNotifierProvider<FirmCitiesViewModel>(
                            //     create: (BuildContext context) => firmCities,
                            //     child: Consumer<FirmCitiesViewModel>(
                            //       builder: (BuildContext context, value,
                            //           Widget? child) {
                            //         return DropdownButtonFormField(
                            //           value: value.city.isEmpty
                            //               ? 'NA'
                            //               : value.city[_selectedCityIndex],
                            //           elevation: 8,
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(2.h)),
                            //           menuMaxHeight: 40.h,
                            //           style: TextStyle(
                            //             fontSize: 18.sp,
                            //             color: Colors.black,
                            //           ),
                            //           decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             focusedBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: AppColors.primaryColor)),
                            //             errorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             focusedErrorBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                 const BorderRadius.all(
                            //                     Radius.circular(20)),
                            //                 borderSide: BorderSide(
                            //                     color: Colors.red.shade700)),
                            //             border: InputBorder.none,
                            //             prefixIcon: Padding(
                            //               padding: EdgeInsets.all(2.w),
                            //               child: Icon(
                            //                 CupertinoIcons.house_alt_fill,
                            //                 size: 3.h,
                            //               ),
                            //             ),
                            //             contentPadding:
                            //             const EdgeInsets.fromLTRB(
                            //                 0, 20, 20, 20),
                            //             hintText: 'Enter your Cities',
                            //             labelText: 'Cities',
                            //             labelStyle: TextStyle(
                            //               fontSize: 18.sp,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           items: value.city
                            //               .map<DropdownMenuItem>((val) {
                            //             return DropdownMenuItem(
                            //               value: val,
                            //               child: SizedBox(
                            //                   width: MediaQuery.of(context)
                            //                       .size
                            //                       .width /
                            //                       1.8,
                            //                   child: Text(
                            //                     val,
                            //                     overflow: TextOverflow.ellipsis,
                            //                     maxLines: 2,
                            //                   )),
                            //             );
                            //           }).toList(),
                            //           onChanged: (val) {
                            //             firmCity = val;
                            //           },
                            //           validator: (val) {
                            //             if (firmCity == null) {
                            //               return 'Please enter your City';
                            //             }
                            //             return null;
                            //           },
                            //         );
                            //       },
                            //     )),
                            // InkWell(
                            //   onTap: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return AlertDialog(
                            //           title: const Text('Select Divisions'),
                            //           content: SingleChildScrollView(
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: divisions.map((division) {
                            //                // provider._selectedDivisions.clear();
                            //                 return Consumer<DivisionProvider>(
                            //                   builder: (BuildContext context,
                            //                       value, Widget? child) {
                            //                     return CheckboxListTile(
                            //                       title: Text(division.name),
                            //                       value: value.isSelected(division),
                            //                       onChanged: (value) {
                            //                         if (value!) {
                            //                           provider.addDivision(division);
                            //                         } else {
                            //                           provider.removeDivision(division);
                            //                         }
                            //                       },
                            //                     );
                            //                   },
                            //                 );
                            //               }).toList(),
                            //             ),
                            //           ),
                            //           actions: [
                            //             Consumer<DivisionProvider>(
                            //               builder: (BuildContext context, value,
                            //                   Widget? child) {
                            //                 return ElevatedButton(
                            //                   child: const Text('OK'),
                            //                   onPressed: () {
                            //                     Navigator.of(context).pop();
                            //                   },
                            //                 );
                            //               },
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   },
                            //   child: Container(
                            //     padding: EdgeInsets.all(1.h),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         TextWithStyle.containerTitle(
                            //             context, "Select Divisions"),
                            //         Icon(CupertinoIcons.chevron_down_circle,
                            //             size: 2.9.h,
                            //             color: AppColors.primaryColor),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Divider(
                            //   thickness: 0.3.h,
                            //   height: 2.h,
                            // ),
                            // Consumer<DivisionProvider>(
                            //   builder:
                            //       (BuildContext context, value, Widget? child) {
                            //     return Wrap(
                            //         spacing: 5,
                            //         children: value.selectedDivisions
                            //             .map((e) => Chip(label: Text(e.name)))
                            //             .toList()
                            //         // divisions.map((e) => Chip(label: Text(e.name))).toList(),
                            //         );
                            //   },
                            // ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // TextInputField(
                            //   title: bankName,
                            //   node: bankNameFocus,
                            //   hintText: 'Enter your Bank Name',
                            //   labelText: 'Bank Name (Optional)',
                            //   icon: CupertinoIcons.money_dollar_circle_fill,
                            //   validator: (value) {
                            //     return null;
                            //   },
                            // ),
                            // TextInputField(
                            //   title: ifscCode,
                            //   node: ifscCodeFocus,
                            //   hintText: 'Enter your Ifsc Code',
                            //   labelText: 'Ifsc Code (Optional)',
                            //   icon: CupertinoIcons.doc_text,
                            //   validator: (value) {
                            //
                            //   },
                            // ),
                            // TextInputField(
                            //   title: accountNumber,
                            //   node: accountNumberFocus,
                            //   hintText: 'Enter your Account Number',
                            //   labelText: 'Account Number (Optional)',
                            //   icon: CupertinoIcons.doc_text_fill,
                            //   validator: (value) {
                            //     return null;
                            //   },
                            // ),
                            // TextInputField(
                            //   title: payeeName,
                            //   node: payeeNameFocus,
                            //   hintText: 'Enter your Payee Name',
                            //   labelText: 'Payee Name (Optional)',
                            //   icon: CupertinoIcons.person_fill,
                            //   validator: (value) {
                            //     return null;
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      Consumer2<DivisionProvider,RegisterViewModel>(
                        builder: (BuildContext context, value,value2, Widget? child) {
                          return Button(
                              title: "Submit",
                              onPress: () {
                                final isValid = _formKey.currentState?.validate();
                                if (!isValid!) {
                                  return;
                                }
                                RegisterEntity entity = RegisterEntity();
                                entity.name = name.text;
                                entity.email = email.text;
                                entity.phone = phone.text;
                                entity.address = address.text;
                                entity.firmName = firmName.text;
                                entity.password = password.text;
                                // entity.city = city.toString();
                                // entity.state = state.name.toString();
                                // entity.opArea = operationArea.text;
                                // entity.dob = dob.text;
                                //

                                // entity.gstNumber = gstNumber.text;
                                // entity.drugLicense = drugLicense.text;
                                // entity.aadhaarCard = aadhaarNumber.text;
                                // entity.firmPhone = firmPhone.text;
                                // entity.firmEmail = firmEmail.text;
                                // entity.firmState = firmState.name.toString();
                                // entity.firmDistrict = firmCity.toString();
                                // entity.firmAddress = firmAddress.text;
                                // entity.bankName = bankName.text;
                                // entity.bankAccNo = accountNumber.text;
                                // entity.bankIfsc = ifscCode.text;
                                // entity.bankPayeeName = payeeName.text;
                                // entity.divisions = value.selectedDivisions
                                //     .map((e) => e.id)
                                //     .toList();
                                register.register(
                                    entity,
                                    context,
                                    name,
                                    email,
                                    phone,
                                    address,
                                    firmName,
                                    password,
                                    confirmPassword
                                    // state.name.toString(),
                                    // city.toString(),
                                    // dob,
                                    // operationArea,
                                    //
                                    //
                                    // gstNumber,
                                    // drugLicense,
                                    // aadhaarNumber,
                                    // firmPhone,
                                    // firmEmail,
                                    // firmAddress,
                                    // firmState.toString(),
                                    // firmCity.toString(),
                                    // bankName,
                                    // ifscCode,
                                    // accountNumber,
                                    // payeeName
                                );
                              }, loading: value2.loading,);
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              );}
        }),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('firmCity', firmCity));
  }
}

class Division {
  String id;
  String name;

  Division({
    required this.id,
    required this.name,
  });
}

class DivisionProvider extends ChangeNotifier {
  final List<Division> _selectedDivisions = [];

  List<Division> get selectedDivisions => _selectedDivisions;

  void addDivision(Division division) {
    _selectedDivisions.add(division);
    notifyListeners();
  }

  void removeDivision(Division division) {
    _selectedDivisions.remove(division);
    notifyListeners();
  }

  bool isSelected(Division division) {
    return _selectedDivisions.contains(division);
  }
}

// ignore: must_be_immutable
// class RegisterContinueScreen extends StatefulWidget {
//   RegisterContinueScreen(
//       {
//         this.name,
//       this.email,
//       this.phone,
//       this.address,
//       this.state,
//       this.city,
//       this.dob,
//       this.operationArea,
//       this.password,
//       this.confirmPassword,
//       Key? key})
//       : super(key: key);
//
//   String? name;
//   String? email;
//   String? phone;
//   String? address;
//   String? state;
//   String? city;
//   String? dob;
//   String? operationArea;
//   String? password;
//   String? confirmPassword;
//
//   @override
//   State<RegisterContinueScreen> createState() => _RegisterContinueScreenState();
// }
//
// class _RegisterContinueScreenState extends State<RegisterContinueScreen> {
//
//   final _formKey = GlobalKey<FormState>();
//
//
//
//
//
//   String? validateEmail(String? value) {
//     const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
//         r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
//         r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
//         r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
//         r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
//         r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
//         r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
//     final regex = RegExp(pattern);
//
//     return value!.isNotEmpty && !regex.hasMatch(value)
//         ? 'Enter a valid email address'
//         : null;
//   }
//
//
//
//
//   List<String> ids = [];
//
//
//   @override
//   void initState() {
//
//     model.fetchAboutCompany();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     divisions.clear();
//     ids.clear();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: TextWithStyle.appBarTitle(context, ConstantStrings.registerHeading),
//         elevation: 0,
//         centerTitle: false,
//       ),
//       body:
//
//             return SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 1.h,
//                     ),
//
//                     SizedBox(
//                       height: 4.h,
//                     ),
//                     Consumer<DivisionProvider>(
//                       builder: (BuildContext context, value, Widget? child) {
//                         return Button(
//                             title: "Register",
//                             onPress: () {
//
//                               final isValid = _formKey.currentState?.validate();
//                               if (!isValid!) {
//                                 return;
//                               }
//
//                             }
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//
//     );
//   }
// }
