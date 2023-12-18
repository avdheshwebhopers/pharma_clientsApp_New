import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/updateProfile.dart';
import 'package:pharma_clients_app/utils/button.dart';
import 'package:pharma_clients_app/view_model/afterLogin_viewModel/afterLogin_viewModels.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/response/status.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_imageString.dart';
import '../../resources/constant_strings.dart';
import '../../utils/Dialogue/error_dialogue.dart';
import '../../utils/TextInputFields/password_inputField.dart';
import '../../utils/TextInputFields/text_field.dart';
import '../../utils/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController adharNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  // TextEditingController state = TextEditingController();
  // TextEditingController city = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController opArea = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode adharNumberFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode opAreaFocusNode = FocusNode();

  var state;
  String? newState;
  var city;
  String? newCity;
  int _selectedCityIndex = 0;

  var currentTime = '${DateTime
      .now()
      .hour + DateTime
      .now()
      .second}';
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

  ProfileViewModel model = ProfileViewModel();
  StatesViewModel stateModel = StatesViewModel();
  CitiesViewModel citiesModel = CitiesViewModel();

  @override
  void initState() {
    model.fetchProfile();
    stateModel.states(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateProfileViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: TextWithStyle.appBarTitle(
              context, ConstantStrings.updateProfileHeading),
          elevation: 0,
        ),
        body: ChangeNotifierProvider<ProfileViewModel>(
          create: (BuildContext context) => model,
          child: Consumer<ProfileViewModel>(
            builder: (BuildContext context, value, _) {
              switch (value.profile.status!) {
                case Status.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.error:
                  if (kDebugMode) {
                    print(value.profile.message.toString());
                  }
                  return ErrorDialogue(
                    message: value.profile.message.toString(),
                  );
                case Status.completed:
                  print(value.profile.data!.data?.state);
                  name.text = value.profile.data!.data?.name ?? 'NA';
                  email.text = value.profile.data!.data?.email ?? 'NA';
                  adharNumber.text = value.profile.data!.data?.aadharNo ?? 'NA';
                  address.text = value.profile.data!.data?.address ?? 'NA';
                  newState = value.profile.data!.data?.state ?? 'NA';
                  newCity = value.profile.data!.data?.city ?? 'NA';
                  StringBuffer sb = StringBuffer();
                  if (phone != null) {
                    sb.write(
                        value.profile.data!.data?.phone!
                            .replaceAll(RegExp(r'\D'), '')
                            .replaceAll(RegExp('91'), '')
                            .replaceAll(RegExp('^0+'), '')
                    );
                    phone.text = sb.toString();
                  }
                  dob.text = value.profile.data!.data?.dob ?? '';
                  opArea.text = value.profile.data!.data?.opArea ?? 'NA';

                  return value.profile.data?.data != null
                      ? Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.only(left: 1.5.h, right: 1.5.h),
                            padding: EdgeInsets.all(2.h),
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
                                  icon: CupertinoIcons.mail_solid,
                                  hintText: 'Enter your email',
                                  labelText: 'Email',
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
                                        BorderRadius.all(Radius.circular(20)),
                                        borderSide:
                                        BorderSide(
                                            color: AppColors.primaryColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        const BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide:
                                        BorderSide(
                                            color: AppColors.primaryColor)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.red.shade700)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.red.shade700)),
                                    contentPadding: const EdgeInsets.all(20),
                                    border: InputBorder.none,
                                    prefixIcon:
                                    const Icon(
                                        CupertinoIcons.phone_fill),
                                    hintText: 'Enter your phone number',
                                    labelText: 'Phone',
                                    //prefixIcon: Icon(Icons.alternate_email)
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextInputField(
                                  title: adharNumber,
                                  node: adharNumberFocusNode,
                                  icon: CupertinoIcons.creditcard_fill,
                                  hintText: 'Enter your Aadhaar Number',
                                  labelText: 'Aadhaar Number',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Aadhaar Number';
                                    }
                                    return null;
                                  },
                                ),
                                TextInputField(
                                  title: address,
                                  node: addressFocusNode,
                                  icon: CupertinoIcons.placemark_fill,
                                  hintText: 'Enter your Address',
                                  labelText: 'Address',
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
                                          hint: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.8,
                                              child: Text(
                                                newState!,
                                                style: const TextStyle(
                                                color: Colors.black
                                              ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )
                                          ),
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
                                          items: value.state.map<DropdownMenuItem>((value) {
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
                                            citiesModel.cities(state.id, context);
                                          },
                                          validator: (val) {
                                            if (val == null && val == newState) {
                                              return 'Please enter your State';
                                            }
                                            return null;
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
                                          hint: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.8,
                                              child: Text(
                                                newCity!,
                                                style: const TextStyle(
                                                    color: Colors.black
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              )),
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
                                          validator: (val) {
                                            if (val == null) {
                                              return 'Please enter your City';
                                            }
                                            return null;
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Date of Birth';
                                      }
                                      return null;
                                    },
                                    obSecure: false,
                                    icon: CupertinoIcons.calendar_today,
                                    hintText: 'Enter your Date of Birth ',
                                    labelText: 'D.O.B',
                                    suffixIcon: InkWell(
                                        onTap: () async {
                                          _selectDate(context, dob);
                                        },
                                        child: const Icon(Icons.date_range))

                                ),
                                TextInputField(
                                  title: opArea,
                                  node: opAreaFocusNode,
                                  icon: CupertinoIcons.briefcase_fill,
                                  hintText: 'Enter your Operation Area',
                                  labelText: 'Operation Area',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Operation Area';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          provider.loading
                              ? CircularProgressIndicator()
                              : Button(
                            title: 'Update',
                            onPress: () {
                              final isValid = _formKey.currentState?.validate();
                              if (!isValid!) {
                                return;
                              }
                              UpdateProfile entity = UpdateProfile();
                              entity.name = name.text;
                              entity.email = email.text;
                              entity.phone = phone.text;
                              entity.aaddhar = adharNumber.text;
                              entity.address = address.text;
                              entity.state = state.name.toString() != null && state.name.toString().isNotEmpty ? state.name.toString() : newState ;
                              entity.city = city.toString() == null && city.toString().isEmpty? newCity : city.toString();
                              entity.op_area = opArea.text;
                              entity.dob = dob.text;

                              provider.updateProfile(
                                  entity,
                                  context,
                                  name,
                                  email,
                                  phone,
                                  adharNumber,
                                  address,
                                  dob,
                                  opArea);

                            }, loading: false,),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  )
                      : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ConstantImage.empty,
                          width: 70.w,
                          //height: 30.h,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 2.h),
                        TextWithStyle.appBarTitle(
                            context, ConstantStrings.emptyScreen)
                      ],
                    ),
                  );
              }
            },),
        )
    );
  }
}

